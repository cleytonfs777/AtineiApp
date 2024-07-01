import 'package:cloud_firestore/cloud_firestore.dart';

class Supplier {
  final String id;
  final bool isPremium;
  final List<String> categories;
  final List<String> imagesUrl;
  final String title;
  final String description;
  final String descriptionLong;
  final String website;
  final String contact;
  final Map<String, String> location;
  final String cnpj;
  final String phone;
  final String contactWhats;
  final double starts;

  Supplier({
    required this.id,
    required this.isPremium,
    required this.categories,
    required this.imagesUrl,
    required this.title,
    required this.description,
    required this.descriptionLong,
    required this.website,
    required this.contact,
    required this.location,
    required this.cnpj,
    required this.phone,
    required this.contactWhats,
    required this.starts,
  });

  factory Supplier.fromMap(Map<String, dynamic> map, String id) {
    return Supplier(
      id: id,
      isPremium: map['plain'] == 'PREMIUM',
      categories: List<String>.from(map['categorias']),
      imagesUrl: List<String>.from(map['fotos']),
      title: map['razaoSocial'],
      description: map['descricao'],
      descriptionLong: map['descricao'],
      website: "",
      contact: map['telefone'],
      location: {
        'street': map['rua'],
        'neighbor': map['bairro'],
        'city': map['cidade'],
        'state': map['estado'],
      },
      cnpj: map['cnpj'],
      phone: map['telefone'],
      contactWhats: map['telefone'],
      starts: 5.0,
    );
  }
}
