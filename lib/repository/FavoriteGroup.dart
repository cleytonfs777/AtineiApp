import 'package:atinei_appl/database/db_firestore.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritasRepository extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  final List<int> _lista = [];
  List<int> get lista => _lista;
  late FirebaseFirestore db;
  late AuthService auth;
  late int supplier;
  FavoritasRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    // await _openBox();
    await _startFirestore();
    await _readFavoritas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFavoritas() async {
    debugPrint("Entrando no _readFavoritas");
    if (auth.usuario != null && _lista.isEmpty) {
      try {
        debugPrint("Entrou no try");
        final snapshot =
            await db.collection('clients/${auth.usuario!.uid}/favorites').get();

        if (snapshot.docs.isEmpty) {
          debugPrint("Vazio");
        }
        for (var fav in snapshot.docs) {
          debugPrint("O que vem do Firebase: ${fav.toString()}");
        }
        notifyListeners();
      } catch (e) {
        print('Sem id de usuário');
      }
    }
  }
}
