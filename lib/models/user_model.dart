import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  // Usuário atual

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? userFire;
  Map<String, dynamic> userData = {};

  bool isLoadding = false;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void signUp(
      {required Map<String, dynamic> userData,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) {
    isLoadding = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((userCredential) async {
      userFire = userCredential.user;

      await _saveUserData(userData);

      onSuccess();
      isLoadding = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoadding = false;
      notifyListeners();
    });
  }

  void signIn(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoadding = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((userCredential) async {
      userFire = userCredential.user;

      await _loadCurrentUser();

      onSuccess();
      isLoadding = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoadding = false;
      notifyListeners();
    });

    await Future.delayed(
      const Duration(seconds: 3),
    );

    isLoadding = false;
    notifyListeners();
  }

  void signOut() async {
    await _auth.signOut();
    userData = {};
    userFire = null;

    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userData);
  }

  Future<void> _loadCurrentUser() async {
    userFire ??= _auth.currentUser;
    if (userFire != null) {
      if (userData['name'] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        userData = docUser.data() as Map<String, dynamic>;
      }
    }
  }

  notifyListeners();
}
