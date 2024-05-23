import 'package:atinei_appl/components/box_favorite.dart';
import 'package:atinei_appl/data/fornecedores_data.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Categorias
  List<String> categories = FornecedoresData.categories;
  List<Map<String, dynamic>> partyServices = FornecedoresData.partyServices;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                        selectedIndex =
                            index; // Atualiza o índice do botão selecionado
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none, // Remove a borda do botão
                      backgroundColor: selectedIndex == index
                          ? Colors.purple
                          : Colors.transparent, // Fundo roxo se selecionado
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors
                                .grey, // Texto branco se selecionado, senão cinza
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: BoxFavorite(),
        ),
      ],
    );
  }
}
