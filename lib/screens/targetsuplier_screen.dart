import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:atinei_appl/data/fornecedores_data.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  List<String> categories = FornecedoresData.categories;

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthService>(context).userData;

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
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              15.0), // ajuste o valor de acordo com a quantidade de arredondamento desejada
                          child: AnotherCarousel(
                            images: widget.listItems['imagesUrl'].map((url) {
                              return Image.asset(url);
                            }).toList(),
                            dotSize: 4.0,
                            dotSpacing: 15.0,
                            dotColor: Colors.white,
                            indicatorBgPadding: 5.0,
                            autoplay: false,
                            animationCurve: Curves.fastOutSlowIn,
                            animationDuration:
                                const Duration(milliseconds: 1000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    // Defina a altura e a largura conforme necessário

                    width: double.infinity,
                    decoration: const BoxDecoration(
                      // Define o gradiente
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter, // Início do gradiente
                        end: Alignment.topCenter, // Fim do gradiente
                        colors: [
                          AppColors.firstPurple, // Cor inicial (bottom)
                          Colors.white, // Cor final (top)
                        ],
                        // Você pode ajustar os pontos de parada para controlar como as cores são distribuídas
                        stops: [0.0, 1.0],
                      ),
                    ),
                    // Você pode adicionar um child ao Container, se necessário
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.listItems['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: AppColors.firstPurple,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    widget.listItems['location']['street'],
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "${widget.listItems['location']['neigbor']}, ${widget.listItems['location']['city']} - ${widget.listItems['location']['state']}",
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    widget.listItems['cnpj'],
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    widget.listItems['phone'],
                                    textAlign: TextAlign.start,
                                  ),
                                ]),
                            Column(children: [
                              const Text("AVALIAÇÃO"),
                              const Text("starts"),
                              IconButton(
                                icon: const Icon(Icons
                                    .share), // Define o ícone de compartilhamento
                                onPressed: () {},
                              )
                            ]),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(children: [
                            Text(
                              "Quem somos",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ]),
                        ),
                      ]),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SizedBox(
                      width: 40.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.listItems['description_long'],
                            style: TextStyle(
                                fontSize: 17.0, color: Colors.grey[500]),
                            textAlign: TextAlign.justify,
                          ),
                          Row(
                            children: [
                              Text(
                                "Contato: ${widget.listItems['contact']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                    color: Color.fromARGB(255, 20, 20, 20)),
                                textAlign: TextAlign.start,
                              ),
                              const Icon(Icons.phone_android,
                                  color: Colors.green),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Preço: ${widget.listItems['price']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Color.fromARGB(255, 20, 20, 20)),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
