import 'package:atinei_appl/components/home_tile.dart';
import 'package:atinei_appl/components/vertical_tile.dart';
import 'package:atinei_appl/data/fornecedores_data.dart';
import 'package:atinei_appl/screens/configure_screen.dart';
import 'package:atinei_appl/screens/favorite_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Medidas Padrão
  double sizeIconBottom = 100.0;
  double sizeIcon = 30.0;

  //Controle de fluxos
  int selectedIndex = 0; // Inicializa sem nenhum botão selecionado
  int currentPage = 0;
  PageController pageController = PageController();

  // Categorias
  List<String> categories = FornecedoresData.categories;
  List<Map<String, dynamic>> partyServices = FornecedoresData.partyServices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.all(2), // Ajuste conforme necessário
                  child: Image.asset(
                    'images/litle_atinei.png', // Substitua pelo caminho do seu logotipo
                    height: 60.0, // Ajuste a altura conforme necessário
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "O que você procura?",
                      contentPadding: const EdgeInsets.all(0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      fillColor: AppColors.greyback,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
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
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          width: 40.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Organizado por: ",
                                style: TextStyle(fontSize: 13),
                                textAlign: TextAlign.left,
                              ),
                              PopupMenuButton<String>(
                                onSelected: (String value) {
                                  // Lógica de seleção
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'a-z',
                                    child: Text('A-Z'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'addrecently',
                                    child: Text('Adicionado recentemente'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'lastconversations',
                                    child: Text('Últimas conversas'),
                                  ),
                                  // Adicione mais opções conforme necessário
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  // Supondo que você tenha uma lista chamada `items` para esta Row
                                  partyServices.length,
                                  (index) => VerticalTile(
                                      index: index,
                                      listItems: partyServices[index]),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap:
                                  true, // Importante para ListView dentro de Column
                              physics:
                                  const NeverScrollableScrollPhysics(), // Desativa o scroll próprio da ListView
                              itemCount: partyServices
                                  .length, // Supondo que exista uma lista `listItems`
                              itemBuilder: (context, index) {
                                return HomeTile(
                                    index: index,
                                    listItems: partyServices[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                FavoriteScreen(),
                ConfigureScreen(),
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
                      pageController.jumpToPage(0);
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
                      pageController.jumpToPage(1);
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
                      pageController.jumpToPage(2);
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
