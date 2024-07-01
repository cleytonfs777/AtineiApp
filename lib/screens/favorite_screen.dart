import 'package:atinei_appl/components/box_favorite.dart';
import 'package:atinei_appl/providers/supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<SupplierProvider>(
      builder: (context, supplierProvider, child) {
        if (supplierProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        List<Map<String, dynamic>> allSuppliers =
            supplierProvider.suppliers.map((supplier) {
          return {
            "id": supplier.id,
            "isPremium": supplier.isPremium,
            "categories": supplier.categories,
            "imagesUrl": supplier.imagesUrl,
            "title": supplier.title,
            "description": supplier.description,
            "description_long": supplier.descriptionLong,
            "website": supplier.website,
            "contact": supplier.contact,
            "location": supplier.location,
            "cnpj": supplier.cnpj,
            "phone": supplier.phone,
            "contactwhats": supplier.contactWhats,
            "starts": supplier.starts,
          };
        }).toList();

        List<String> categories = allSuppliers
            .expand((supplier) => List<String>.from(supplier['categories']))
            .toSet()
            .toList();

        List<Map<String, dynamic>> partyServices = allSuppliers;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => Container(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 10.0),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          backgroundColor: selectedIndex == index
                              ? Colors.purple
                              : Colors.transparent,
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BoxFavorite(partyServices: partyServices),
            ),
          ],
        );
      },
    );
  }
}
