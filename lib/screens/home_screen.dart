import 'package:atinei_appl/data/fornecedores_data.dart';
import 'package:atinei_appl/screens/configure_screen.dart';
import 'package:atinei_appl/screens/favorite_screen.dart';
import 'package:atinei_appl/screens/targetsuplier_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int initialPage;

  const HomeScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Medidas Padrão
  double sizeIconBottom = 100.0;
  double sizeIcon = 30.0;

  //Controle de fluxos
  int selectedIndex = 0; // Inicializa sem nenhum botão selecionado
  int currentPage = 0;
  late PageController pageController;
  late List<Map<String, dynamic>> Listpremiumlist;
  late List<Map<String, dynamic>> resultSearch;
  List<Map<String, dynamic>> allServices = [];

  @override
  void initState() {
    super.initState();
    allServices = List.from(FornecedoresData.partyServices);
    resultSearch = List.from(FornecedoresData.partyServices);
    pageController = PageController(initialPage: widget.initialPage);
    Listpremiumlist = FornecedoresData.partyServices
        .where((element) => element['isPremium'] == true)
        .toList();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      resultSearch = List.from(allServices);
    } else {
      resultSearch = allServices
          .where((service) =>
              service['title']
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              service['description']
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      // Atualiza a UI para refletir os novos resultados de busca
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
    setState(() {
      currentPage = index;
    });
  }

  // Categorias
  List<String> categories = FornecedoresData.categories;
  List<Map<String, dynamic>> partyServices = FornecedoresData.partyServices;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Bloqueia o botão de voltar nesta tela
      child: Scaffold(
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
                      onChanged: (value) => runFilter(value),
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
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              categories.length,
                              (index) => Container(
                                padding: const EdgeInsets.fromLTRB(
                                    5.0, 0, 5.0, 10.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex =
                                          index; // Atualiza o índice do botão selecionado
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide
                                        .none, // Remove a borda do botão
                                    backgroundColor: selectedIndex == index
                                        ? Colors.purple
                                        : Colors
                                            .transparent, // Fundo roxo se selecionado
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
                                child: Container(
                                  color: AppColors.greyback,
                                  child: Row(
                                    children: List.generate(
                                      // Supondo que você tenha uma lista chamada `items` para esta Row
                                      Listpremiumlist.length,
                                      (index) {
                                        return InkWell(
                                          onTap: () async {
                                            var resultado =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TargetSupplierScreen(
                                                        listItems:
                                                            Listpremiumlist[
                                                                index]),
                                              ),
                                            ); // Chama o callback após retornar

                                            // 'resultado' contém o parâmetro passado de volta pelo Navigator.pop()
                                            if (resultado != null) {
                                              _onItemTapped(resultado);
                                            }
                                          },
                                          child: Container(
                                            color: AppColors.firstPurple,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0), // Define o raio das bordas
                                                    child: Image.asset(
                                                      Listpremiumlist[index]
                                                          ['imagesUrl'][0],
                                                      width: 130.0,
                                                      height: 130.0,
                                                      fit: BoxFit
                                                          .cover, // Define o modo de redimensionamento
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    Listpremiumlist[index]
                                                        ['title'],
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.firstGreen,
                                                      fontSize: 15.0,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: SizedBox(
                                                    width: 130.0,
                                                    height: 100.0,
                                                    child: Text(
                                                      Listpremiumlist[index]
                                                          ['description'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow: TextOverflow
                                                          .ellipsis, // Adiciona "..." ao exceder o espaço disponível
                                                      maxLines: 4,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        // Na HomeScreen, ao construir HomeTile ou VerticalTile
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap:
                                    true, // Importante para ListView dentro de Column
                                physics:
                                    const NeverScrollableScrollPhysics(), // Desativa o scroll próprio da ListView
                                itemCount: resultSearch
                                    .length, // Supondo que exista uma lista `listItems`
                                itemBuilder: (context, index) {
                                  return
                                      // Na HomeScreen, ao construir HomeTile ou VerticalTile
                                      ListTile(
                                    leading: Image.asset(
                                      resultSearch[index]['imagesUrl'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(resultSearch[index]['title']),
                                    subtitle: Text(
                                      resultSearch[index]['description'],
                                      overflow: TextOverflow
                                          .ellipsis, // Adiciona "..." ao exceder o espaço disponível
                                      maxLines: 2,
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () async {
                                        var resultado = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TargetSupplierScreen(
                                                    listItems:
                                                        resultSearch[index]),
                                          ),
                                        ); // Chama o callback após retornar

                                        // 'resultado' contém o parâmetro passado de volta pelo Navigator.pop()
                                        if (resultado != null) {
                                          _onItemTapped(resultado);
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const FavoriteScreen(),
                  const ConfigureScreen(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomAppBar buildBottomNavigationBar() {
    return BottomAppBar(
      color: AppColors.greyBar,
      child: IconTheme(
        data: IconThemeData(size: sizeIcon),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home_outlined, 0),
              buildNavItem(Icons.favorite_border_outlined, 1),
              buildNavItem(Icons.person_outline_outlined, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = index;
          pageController.jumpToPage(index);
        });
      },
      child: Container(
        width: sizeIconBottom,
        height: sizeIconBottom,
        decoration: BoxDecoration(
          color:
              currentPage == index ? AppColors.firstPurple : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: currentPage == index ? Colors.white : Colors.black,
          size: sizeIcon,
        ),
      ),
    );
  }
}
