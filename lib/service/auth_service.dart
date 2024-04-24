import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;
  Map<String, dynamic> userData = {};

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
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
        print("Documento não encontrado ou sem dados.");
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

  registrarFornecedor(
    String email,
    String senha,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getRegisteredUser();
    } on FirebaseAuthException catch (e) {
      print("Erro: $e");
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    }
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
    _getUser();
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
}
