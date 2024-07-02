import 'package:atinei_appl/providers/client_provider.dart';
import 'package:atinei_appl/screens/targetsuplier_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitedScreenSupplier extends StatefulWidget {
  final int initialPage;

  const VisitedScreenSupplier({Key? key, this.initialPage = 0})
      : super(key: key);

  @override
  _VisitedScreenSupplierState createState() => _VisitedScreenSupplierState();
}

class _VisitedScreenSupplierState extends State<VisitedScreenSupplier> {
  double sizeIconBottom = 100.0;
  double sizeIcon = 30.0;
  bool _isSliverVisible = false;
  int selectedIndex = 0;
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
    return Consumer<ClientProvider>(
      builder: (context, clientProvider, child) {
        if (clientProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
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
                      onChanged: (value) => clientProvider.filterClients(value),
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
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        Client client = clients[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network(
                              client.photoUrl.isNotEmpty
                                  ? client.photoUrl
                                  : 'images/logo.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            title: Text(client.name),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () async {
                                var resultado = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TargetSupplierScreen(
                                      listItems: client.toMap(),
                                    ),
                                  ),
                                );

                                if (resultado != null) {
                                  _onItemTapped(resultado);
                                }
                              },
                            ),
                          ),
                        );
                      },
                      childCount: clients.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
