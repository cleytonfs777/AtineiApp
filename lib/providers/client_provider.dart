import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Client {
  final String id;
  final String email;
  final List<String> favorites;
  final String name;
  final String phone;
  final String photoUrl;
  final String type;

  Client({
    required this.id,
    required this.email,
    required this.favorites,
    required this.name,
    required this.phone,
    required this.photoUrl,
    required this.type,
  });

  factory Client.fromMap(Map<String, dynamic> data, String documentId) {
    return Client(
      id: documentId,
      email: data['email'] ?? '',
      favorites: List<String>.from(data['favorites'] ?? []),
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      photoUrl: data['photo_url'] ?? '',
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'favorites': favorites,
      'name': name,
      'phone': phone,
      'photo_url': photoUrl,
      'type': type,
    };
  }
}

class ClientProvider with ChangeNotifier {
  List<Client> _clients = [];
  List<Client> _filteredClients = [];
  bool _isLoading = true;

  List<Client> get clients => _filteredClients;
  bool get isLoading => _isLoading;

  ClientProvider() {
    fetchClients();
  }

  Future<void> fetchClients() async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('clients').get();
      _clients = snapshot.docs.map((doc) {
        return Client.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      _filteredClients = _clients;
    } catch (e) {
      print("Erro ao buscar clientes: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterClients(String query) {
    if (query.isEmpty) {
      _filteredClients = List.from(_clients);
    } else {
      _filteredClients = _clients.where((client) {
        return client.name.toLowerCase().contains(query.toLowerCase()) ||
            client.email.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
