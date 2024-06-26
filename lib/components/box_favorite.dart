import 'package:atinei_appl/service/auth_service.dart';
import 'package:atinei_appl/screens/targetsuplier_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class BoxFavorite extends StatelessWidget {
  final List<Map<String, dynamic>> partyServices;

  const BoxFavorite({required this.partyServices, super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthService>();
    final List<dynamic> favorites = user.userData['favorites'] ?? [];

    List<Map<String, dynamic>> filteredServices = partyServices
        .where((service) => favorites.contains(service['id'] as String))
        .toList(); // Cast 'service['id']' para String

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          filteredServices.length,
          (index) {
            double starts = filteredServices[index]['starts']?.toDouble() ??
                0.0; // Converta para double e trate nulos
            return InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TargetSupplierScreen(
                        listItems: filteredServices[index]),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      filteredServices[index]['imagesUrl'][0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 44,
                        ),
                        onPressed: () {
                          user.modifyFavorites(
                              filteredServices[index]['id'], 'remove');
                          print(filteredServices[index]['id']);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(121, 38, 170, 0.9),
                              Color.fromRGBO(3, 218, 198, 0.6),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.5, 0.8, 1.0],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              filteredServices[index]['title'],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 40, 20, 51),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              filteredServices[index]['description'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: RatingBar.builder(
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: index < starts
                                      ? Colors.white
                                      : const Color.fromARGB(255, 185, 43, 43),
                                ),
                                onRatingUpdate: (rating) {},
                                itemSize: 20.0,
                                initialRating: starts,
                                minRating: 1,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
