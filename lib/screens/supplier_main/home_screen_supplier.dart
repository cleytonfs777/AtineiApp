import 'package:atinei_appl/providers/client_provider.dart';
import 'package:atinei_appl/screens/supplier_main/configure_screen_supplier.dart';
import 'package:atinei_appl/screens/supplier_main/visited_screen_supplier.dart';
import 'package:atinei_appl/screens/targetsuplier_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenSupplier extends StatefulWidget {
  final int initialPage;

  const HomeScreenSupplier({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _HomeScreenSupplierState createState() => _HomeScreenSupplierState();
}

class _HomeScreenSupplierState extends State<HomeScreenSupplier> {
  double sizeIconBottom = 100.0;
  double sizeIcon = 30.0;

  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Consumer<ClientProvider>(
            builder: (context, clientProvider, child) {
              if (clientProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Client> clients = clientProvider.clients;

              return Column(
                children: [
                  const SizedBox(height: 60.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.asset(
                            'images/litle_atinei.png',
                            height: 60.0,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) =>
                                clientProvider.filterClients(value),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "O que você procura?",
                              contentPadding: const EdgeInsets.all(0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              fillColor: AppColors.greyback,
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text(
                      'Nenhum Chat Disponível',
                      style: TextStyle(
                        color: Colors.purple, // Cor do texto
                        fontWeight: FontWeight.bold, // Negrito
                        fontSize: 20.0, // Tamanho da fonte (opcional)
                      ),
                      textAlign: TextAlign.center, // Centraliza o texto
                    ),
                  )
                      // CustomScrollView(
                      //   slivers: [
                      //     SliverList(
                      //       delegate: SliverChildBuilderDelegate(
                      //         (BuildContext context, int index) {
                      //           Client client = clients[index];
                      //           return Padding(
                      //             padding: const EdgeInsets.all(3.0),
                      //             child: Container(
                      //               color: const Color.fromARGB(131, 3, 218, 197),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: ListTile(
                      //                   contentPadding: const EdgeInsets.all(0),
                      //                   leading: Image.network(
                      //                     client.photoUrl.isNotEmpty
                      //                         ? client.photoUrl
                      //                         : 'images/logo.png',
                      //                     width: 80,
                      //                     fit: BoxFit.fill,
                      //                   ),
                      //                   title: Text(client.name),
                      //                   trailing: IconButton(
                      //                     icon: const Icon(Icons.arrow_forward),
                      //                     onPressed: () async {
                      //                       var resultado = await Navigator.push(
                      //                         context,
                      //                         MaterialPageRoute(
                      //                           builder: (context) =>
                      //                               TargetSupplierScreen(
                      //                             listItems: client.toMap(),
                      //                           ),
                      //                         ),
                      //                       );

                      //                       if (resultado != null) {
                      //                         _onItemTapped(resultado);
                      //                       }
                      //                     },
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //         childCount: clients.length,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      ),
                ],
              );
            },
          ),
          const VisitedScreenSupplier(),
          const ConfigureScreenSupplier(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
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
              buildNavItem(Icons.message, 0),
              buildNavItem(Icons.remove_red_eye_outlined, 1),
              buildNavItem(Icons.person_outline_outlined, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index) {
    return InkWell(
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
