import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:atinei_appl/components/button_with_icon.dart';
import 'package:atinei_appl/components/dynamic_rating.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:atinei_appl/service/auth_service.dart';

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
  int currentPage = 0;

  late bool isFavorite;

  Future<void> openWhatsApp(String phoneNumber, [String message = ""]) async {
    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'api.whatsapp.com',
      path: 'send',
      queryParameters: {
        'phone': phoneNumber,
        'text': message,
      },
    );

    if (!await launchUrl(whatsappUri)) {
      throw 'Could not launch $whatsappUri';
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (!await launchUrl(launchUri)) {
      throw 'Could not launch $launchUri';
    }
  }

  void shareContent(String text, String subject, [List<String>? files]) {
    Share.share(text,
        subject: subject,
        sharePositionOrigin:
            const Rect.fromLTWH(0, 0, 100, 100) // Opcional: posição para iPads
        );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context);
    List<dynamic> favorites = user.userData['favorites'] ?? [];

    isFavorite = favorites.contains(widget.listItems['id']);

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
                widget.listItems['categories'].length,
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
                        backgroundColor: Colors.purple),
                    child: Text(
                      widget.listItems['categories'][index],
                      style: const TextStyle(color: Colors.white),
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
                              return Image.network(url);
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
                                  SizedBox(
                                    child: Container(
                                      width: 210,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.listItems['title'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                color: AppColors.firstPurple,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border),
                                            color: Colors.red,
                                            iconSize:
                                                35, // Ajuste o tamanho do ícone aqui

                                            style: IconButton.styleFrom(
                                              foregroundColor: Colors.red,
                                              shape: const CircleBorder(),
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                            ),
                                            onPressed: () async {
                                              if (isFavorite) {
                                                isFavorite =
                                                    await user.modifyFavorites(
                                                        widget.listItems['id'],
                                                        "remove");
                                              } else {
                                                isFavorite =
                                                    await user.modifyFavorites(
                                                        widget.listItems['id'],
                                                        "add");
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.listItems['location']['street'],
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "${widget.listItems['location']['neighbor']}, ${widget.listItems['location']['city']} - ${widget.listItems['location']['state']}",
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
                              DynamicRatingBar(
                                  readOnly: true,
                                  currentRating: widget.listItems['starts']),
                              IconButton(
                                icon: const Icon(Icons
                                    .share), // Define o ícone de compartilhamento
                                onPressed: () => shareContent(
                                    'Confira este conteúdo incrível!',
                                    'Veja Isso!'),
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
                          const SizedBox(height: 30.0),
                          Text(
                            widget.listItems['description_long'],
                            style: TextStyle(
                                fontSize: 17.0, color: Colors.grey[500]),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 30.0),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ButtonWithIcon(
                                buttonText: "Falar pelo chat",
                                backgroundColor: AppColors.firstGreen,
                                onPressed: () => openWhatsApp(
                                      widget.listItems['contactwhats'],
                                      'Olá! Gostaria de mais informações sobre seus serviços colocados no Atinei.',
                                    ),
                                icon: Icons.message_outlined),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ButtonWithIcon(
                                buttonText: "Ligar para o prestador",
                                backgroundColor: AppColors.firstGreen,
                                onPressed: () => makePhoneCall(
                                    widget.listItems['contactwhats']),
                                icon: Icons.phone_sharp),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ButtonWithIcon(
                              buttonText: "Falar pelo whatsapp",
                              backgroundColor: AppColors.firstGreen,
                              onPressed: () => openWhatsApp(
                                  widget.listItems['contactwhats']),
                              icon: FontAwesomeIcons
                                  .whatsapp, // Correção: passar apenas o IconData
                            ),
                          )
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
// Algum ponto na sua lógica onde você decide voltar para a tela anterior
                    Navigator.of(context).pop(0);
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
                    // Faz um navigation pop para voltar para a tela anterior
// Algum ponto na sua lógica onde você decide voltar para a tela anterior
                    Navigator.of(context).pop(1);
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
// Algum ponto na sua lógica onde você decide voltar para a tela anterior
                    Navigator.of(context).pop(2);
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
