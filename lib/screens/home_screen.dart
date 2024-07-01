import 'package:atinei_appl/screens/configure_screen.dart';
import 'package:atinei_appl/screens/favorite_screen.dart';
import 'package:atinei_appl/screens/targetsuplier_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atinei_appl/providers/supplier_provider.dart';

class HomeScreen extends StatefulWidget {
  final int initialPage;

  const HomeScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Consumer<SupplierProvider>(
          builder: (context, supplierProvider, child) {
            if (supplierProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            List<Map<String, dynamic>> allServices =
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

            List<Map<String, dynamic>> Listpremiumlist = allServices
                .where((element) => element['isPremium'] == true)
                .toList();
            List<String> categories = supplierProvider.suppliers
                .expand((supplier) => supplier.categories)
                .toSet()
                .toList();

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
                              supplierProvider.filterSuppliers(value),
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isSliverVisible =
                                                !_isSliverVisible;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.tune,
                                          color: AppColors.firstGreen,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                    categories.length,
                                    (index) => Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          5.0, 0, 5.0, 10.0),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide.none,
                                          backgroundColor:
                                              selectedIndex == index
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
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (_isSliverVisible)
                            const SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: SizedBox(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Filtros Avançados",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.firstGreen),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Selecione seu DDD",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.firstGreen),
                                        textAlign: TextAlign.left,
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
                                                              index],
                                                    ),
                                                  ),
                                                );

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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: Image.network(
                                                          Listpremiumlist[index]
                                                              ['imagesUrl'][0],
                                                          width: 130.0,
                                                          height: 130.0,
                                                          fit: BoxFit.cover,
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
                                                          color: AppColors
                                                              .firstGreen,
                                                          fontSize: 15.0,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
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
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        supplierProvider.suppliers.length,
                                    itemBuilder: (context, index) {
                                      var supplier =
                                          supplierProvider.suppliers[index];
                                      return ListTile(
                                        leading: Image.network(
                                          supplier.imagesUrl[0],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(supplier.title),
                                        subtitle: Text(
                                          supplier.description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.arrow_forward),
                                          onPressed: () async {
                                            var resultado =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TargetSupplierScreen(
                                                  listItems: {
                                                    "id": supplier.id,
                                                    "isPremium":
                                                        supplier.isPremium,
                                                    "categories":
                                                        supplier.categories,
                                                    "imagesUrl":
                                                        supplier.imagesUrl,
                                                    "title": supplier.title,
                                                    "description":
                                                        supplier.description,
                                                    "description_long": supplier
                                                        .descriptionLong,
                                                    "website": supplier.website,
                                                    "contact": supplier.contact,
                                                    "location":
                                                        supplier.location,
                                                    "cnpj": supplier.cnpj,
                                                    "phone": supplier.phone,
                                                    "contactwhats":
                                                        supplier.contactWhats,
                                                    "starts": supplier.starts,
                                                  },
                                                ),
                                              ),
                                            );

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
            );
          },
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
