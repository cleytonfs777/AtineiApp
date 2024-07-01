import 'dart:io';
import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? usuario;
  bool isLoading = true;
  Map<String, dynamic> userData = {};
  String? categoryUser;
  String url_general =
      "https://firebasestorage.googleapis.com/v0/b/atinei-appl.appspot.com/o/capa.png?alt=media&token=daadd388-85e3-4ef4-a48e-0dc521848c7f";

  final FirebaseStorage _storage = FirebaseStorage.instance;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      if (usuario != null) {
        _getUser();
      }
      notifyListeners();
    });
  }

  _getUser() async {
    usuario = _auth.currentUser;
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('clients')
          .doc(_auth.currentUser!.uid)
          .get();
      var userDataMap = snapshot.data(); // Esta é a mudança chave
      if (userDataMap != null) {
        userData = userDataMap;
        notifyListeners();
      } else {
        var snapshot = await FirebaseFirestore.instance
            .collection('suppliers')
            .doc(_auth.currentUser!.uid)
            .get();
        userDataMap = snapshot.data(); // Esta é a mudança chave
        if (userDataMap != null) {
          userData = userDataMap;
          notifyListeners();
        } else {
          print("Erro: Nenhum dado encontrado para o usuário");
          logout();
        }
      }
    } catch (e) {
      print("Erro ao carregar UserData: $e");
    }
  }

  _getRegisteredUser() {
    usuario = _auth.currentUser;
  }

  Future<void> _saveClientData(Map<String, dynamic> userData) async {
    print("Iniciando _saveClientData com UserData: $userData");
    try {
      await FirebaseFirestore.instance
          .collection('clients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userData);
      this.userData = userData;
      notifyListeners();
    } catch (e) {
      print("Erro ao salvar UserData: $e");
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        // Fetch user data from Firestore or initialize it if new user
        await _fetchOrUpdateUserData(user);
        usuario = user;
        notifyListeners();
      }
      return user;
    } catch (e) {
      print("Erro ao autenticar com Google: $e");
      throw AuthException('Falha ao autenticar com Google');
    }
  }

  Future<void> _fetchOrUpdateUserData(User user) async {
    final userDoc =
        FirebaseFirestore.instance.collection('clients').doc(user.uid);
    var doc = await userDoc.get();
    if (doc.exists) {
      userData = doc.data()!;
    } else {
      // Assuming some default data needs to be written for a new user
      userData = {
        "email": user.email,
        "favorites": [],
        "name": user.displayName,
        "phone": "",
        "photo_url": user.photoURL,
        "type": "client",
      };
      await userDoc.set(userData);
    }
    notifyListeners();
  }

  registrarCliente({
    required Map<String, dynamic> userData,
    required String pass,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userData['email'], password: pass);
      usuario = _auth.currentUser;

      print("Antes de salvar: $userData");
      _saveClientData(userData).then((_) {
        print("Depois de salvar: ${this.userData}");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Erro: $e");
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      } else {
        throw AuthException('Email ou Senha estão incorretos!');
      }
    }
  }

  setUserInit() async {
    _getUser();
  }

  logout() async {
    await _auth.signOut();
    if (_googleSignIn.currentUser != null) {
      // Verifica se há uma sessão do Google ativa
      await _googleSignIn.signOut(); // Faz logout do Google SignIn
    }
    _getUser(); // Chama _getUser para atualizar o estado interno
  }

  Future<void> reauthenticate(String email, String password) async {
    User? user = _auth.currentUser;
    if (user != null) {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      try {
        await user.reauthenticateWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        throw AuthException('Falha na reautenticação: ${e.message}');
      }
    }
  }

  Future<void> deleteAccount() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Primeiro, deletar os dados do usuário no Firestore
        await FirebaseFirestore.instance
            .collection('clients')
            .doc(_auth.currentUser!.uid)
            .delete();

        // Depois, deletar a conta do usuário no Firebase Authentication
        await user.delete();

        // Atualizar o estado interno para refletir que o usuário foi deletado
        usuario = null;
        userData = {};
        _authCheck();
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        print("Erro ao deletar conta de usuário: $e");
        isLoading = false;
        if (e.code == 'requires-recent-login') {
          // Este erro significa que o usuário precisa reautenticar para deletar a conta
          throw AuthException(
              'Por favor, faça login novamente antes de tentar deletar sua conta.');
        } else {
          throw AuthException('Falha ao deletar conta: ${e.message}');
        }
      } catch (e) {
        isLoading = false;
        print("Erro desconhecido ao deletar conta: $e");
        throw AuthException('Erro desconhecido ao deletar conta.');
      }
    }
  }

  // Verifica se um email já está cadastrado tentando criar um usuário com o email
  Future<bool> isEmailRegistered(String email) async {
    try {
      // Tenta criar um usuário com uma senha dummy para verificar se o email já está em uso
      await _auth.createUserWithEmailAndPassword(
          email: email, password: 'dummyPassword');
      // Se o usuário for criado com sucesso, exclua-o imediatamente
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
      }
      return false; // Email não está registrado
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return true; // Email já está registrado
      }
      // Tratar outros possíveis erros
      print("Erro ao verificar email: $e");
      return false;
    }
  }

  // FUNCTIONS SUPPLIERS

  Future<List<String>> uploadFiles(List<XFile> files) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(
          code: 'user-not-authenticated', message: 'Usuário não autenticado');
    }

    List<String> downloadUrls = [];
    try {
      for (XFile file in files) {
        String filePath = 'images/${user.uid}/${DateTime.now()}_${file.name}';
        Reference ref = _storage.ref().child(filePath);
        UploadTask uploadTask = ref.putFile(File(file.path));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
      return downloadUrls;
    } catch (e) {
      print("Erro ao carregar imagens para o Firebase: $e");
      throw Exception('Erro ao carregar imagens para o Firebase.');
    }
  }

  Future<void> registrarSupplier(SupplierFormData supplierData) async {
    try {
      // Cria um usuário no Firebase Authentication

      await _auth.createUserWithEmailAndPassword(
          email: supplierData.email, password: supplierData.senha);
      User? user = _auth.currentUser;

      print("User: $user");

      // Certifique-se de que a lista photoUrls não é nula
      supplierData.photoUrls ??= [];

      // Salva as imagens e gera as URLs
      for (int i = 0; i < supplierData.fotos.length; i++) {
        String filePath =
            'images/${user!.uid}/${DateTime.now()}_${supplierData.fotos[i].path.split('/').last}';
        Reference ref = _storage.ref().child(filePath);
        UploadTask uploadTask = ref.putFile(File(supplierData.fotos[i].path));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        print("Download URL: $downloadUrl");
        supplierData.photoUrls!.add(downloadUrl);
      }

      print("Todas as fotos: ${supplierData.photoUrls}");

      userData = supplierData.toMap();
      Map<String, dynamic> supplierMap = supplierData.toMap();

      print("Esse é o resultado de supplierMap: $supplierMap");

      await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(user!.uid)
          .set(supplierMap);

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      } else {
        throw AuthException('Erro ao registrar fornecedor: $e');
      }
    }
  }
  // Função para registrar um fornecedor (supplier)

  Future<void> _saveSupplierData(SupplierFormData supplierData) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw AuthException('Usuário não autenticado');
      }

      // Upload das fotos em paralelo e obtenção das URLs
      List<Future<String>> uploadFutures = supplierData.fotos.map((foto) {
        return uploadImageToFirebase(File(foto.path));
      }).toList();

      // Use Future.wait para esperar todos os uploads concluírem
      List<String> photoUrls = await Future.wait(uploadFutures);

      // Converte SupplierFormData para um mapa, incluindo as URLs das fotos
      Map<String, dynamic> supplierMap = supplierData.toMap();

      await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(user.uid)
          .set(supplierMap);

      notifyListeners();
    } catch (e) {
      print("Erro ao salvar dados do fornecedor: $e");
      throw AuthException('Erro ao salvar dados do fornecedor.');
    }
  }

  // FUNCTIONS FOTOS

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      // Verifica se o usuário está autenticado
      User? user = _auth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
            code: 'user-not-authenticated', message: 'Usuário não autenticado');
      }

      // Reautentica o usuário se necessário
      await user.reload();
      user = _auth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
            code: 'user-not-authenticated',
            message: 'Usuário não autenticado após recarregar');
      }

      String filePath =
          'images/${user.uid}/${DateTime.now()}_${imageFile.path.split('/').last}';
      Reference ref = FirebaseStorage.instance.ref().child(filePath);
      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask;

      String downloadUrl = await ref.getDownloadURL();
      print("Imagem enviada para o Firebase com sucesso: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Erro ao carregar imagem para o Firebase: $e");
      throw AuthException('Erro ao carregar imagem para o Firebase.');
    }
  }

  Future<void> updatePhotoUrl(String newUrl) async {
    userData['photo_url'] = newUrl; // Atualiza localmente

    // Salva a nova URL no Firestore
    await FirebaseFirestore.instance
        .collection('clients')
        .doc(_auth.currentUser!.uid)
        .update({'photo_url': newUrl});

    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  Future<void> removePhoto() async {
    if (userData['photo_url'] != null && userData['photo_url'].isNotEmpty) {
      String fileUrl = userData['photo_url'];
      Reference ref = FirebaseStorage.instance.refFromURL(fileUrl);

      try {
        await ref.delete();
        // Após deletar do Storage, atualize Firestore
        await FirebaseFirestore.instance
            .collection('clients')
            .doc(_auth.currentUser!.uid)
            .update({'photo_url': url_general});
        userData['photo_url'] = url_general;

        notifyListeners();
      } catch (e) {
        print("Erro ao deletar imagem do Storage: $e");
        throw e; // Lança o erro para ser tratado pelo widget
      }
    }
  }

  // FUNCTIONS FAVORITE

  Future<bool> modifyFavorites(String itemId, String action) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var docRef = FirebaseFirestore.instance.collection('clients').doc(userId);

    DocumentSnapshot docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      List<dynamic> favorites = docSnapshot.get('favorites') ?? [];

      if (action == 'add') {
        if (!favorites.contains(itemId)) {
          // Se o itemId não estiver na lista, adicione-o
          await docRef.update({
            'favorites': FieldValue.arrayUnion([itemId])
          });
          userData['favorites'].add(itemId);
          notifyListeners();
          return true;
        }
        return false;
      } else if (action == 'remove') {
        if (favorites.contains(itemId)) {
          // Se o itemId estiver na lista, remova-o
          await docRef.update({
            'favorites': FieldValue.arrayRemove([itemId])
          });
          userData['favorites'].remove(itemId);
          notifyListeners();
          return false;
        }
        return true;
      }
    }
    return false; // Retorne false se o documento não existir
  }
}
