import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:atinei_appl/models/supplier.dart';

class SupplierService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Supplier>> getSuppliers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('suppliers').get();
      List<Supplier> suppliers = snapshot.docs.map((doc) {
        return Supplier.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return suppliers;
    } catch (e) {
      print("Erro ao buscar fornecedores: $e");
      return [];
    }
  }
}
