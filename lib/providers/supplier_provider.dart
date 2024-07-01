import 'package:atinei_appl/service/supplier_service.dart';
import 'package:flutter/material.dart';
import 'package:atinei_appl/models/supplier.dart';

class SupplierProvider with ChangeNotifier {
  List<Supplier> _suppliers = [];
  List<Supplier> _filteredSuppliers = [];
  bool _isLoading = true;

  List<Supplier> get suppliers => _filteredSuppliers;
  bool get isLoading => _isLoading;

  SupplierProvider() {
    fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _suppliers = await SupplierService().getSuppliers();
      _filteredSuppliers = _suppliers; // Initialize filtered list
    } catch (e) {
      print("Erro ao buscar fornecedores: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterSuppliers(String query) {
    if (query.isEmpty) {
      _filteredSuppliers = List.from(_suppliers);
    } else {
      _filteredSuppliers = _suppliers.where((supplier) {
        return supplier.title.toLowerCase().contains(query.toLowerCase()) ||
            supplier.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
