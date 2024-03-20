import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TargetSupplierScreen extends StatefulWidget {
  final Map<String, dynamic> listItems;

  const TargetSupplierScreen({required this.listItems, super.key});

  @override
  State<TargetSupplierScreen> createState() => _TargetSupplierScreenState();
}

class _TargetSupplierScreenState extends State<TargetSupplierScreen> {
  // Medidas Padrão
  double sizeIconBottom = 100.0;

  double sizeIcon = 30.0;

  //Controle de fluxos
  int selectedIndex = 0;
  // Inicializa sem nenhum botão selecionado
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.firstPurple,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.firstGreen),
        title: Text(widget.listItems['title'],
            style: const TextStyle(
              color: AppColors.firstGreen,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(widget.listItems['title']),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.greyBar,
        child: IconTheme(
          data: IconThemeData(
            size: sizeIcon,
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = 0;
                    });
                  },
                  child: Container(
                    width: sizeIconBottom, // Largura do container
                    height: sizeIconBottom, // Altura do container
                    decoration: BoxDecoration(
                      color: currentPage == 0
                          ? AppColors.firstPurple
                          : Colors.transparent, // Cor de fundo do container
                      shape: BoxShape.circle, // Forma do container
                    ),
                    child: Icon(
                      Icons.home_outlined,
                      color: currentPage == 0 ? Colors.white : Colors.black,
                      size: sizeIcon, // Tamanho do ícone ajustado
                    ),
                  ),
                ),
                // Repita para outros ícones conforme necessário
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = 1;
                    });
                  },
                  child: Container(
                    width: sizeIconBottom, // Largura do container
                    height: sizeIconBottom, // Altura do container
                    decoration: BoxDecoration(
                      color: currentPage == 1
                          ? AppColors.firstPurple
                          : Colors.transparent, // Cor de fundo do container
                      shape: BoxShape.circle, // Forma do container
                    ),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: currentPage == 1 ? Colors.white : Colors.black,
                      size: sizeIcon, // Tamanho do ícone ajustado
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = 2;
                    });
                  },
                  child: Container(
                    width: sizeIconBottom, // Largura do container
                    height: sizeIconBottom, // Altura do container

                    decoration: BoxDecoration(
                      color: currentPage == 2
                          ? AppColors.firstPurple
                          : Colors.transparent, // Cor de fundo do container
                      shape: BoxShape.circle, // Forma do container
                    ),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: currentPage == 2 ? Colors.white : Colors.black,
                      size: sizeIcon, // Tamanho do ícone ajustado
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
