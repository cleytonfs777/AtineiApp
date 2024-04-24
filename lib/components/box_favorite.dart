import 'package:atinei_appl/data/fornecedores_data.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BoxFavorite extends StatelessWidget {
  final List<dynamic> supplierFavorite;

  const BoxFavorite({super.key, required this.supplierFavorite});

  final List<Map<String, dynamic>> partyServices =
      FornecedoresData.partyServices;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredServices = partyServices
        .where((service) => supplierFavorite.contains(service['id'] as int))
        .toList(); // Cast 'service['id']' para int se não for garantido como int

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          filteredServices.length,
          (index) {
            double starts = filteredServices[index]['starts']?.toDouble() ??
                0.0; // Converta para double e trate nulos
            return Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    filteredServices[index]['imagesUrl'][0],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width,
                  ),
                  const Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(Icons.favorite, color: Colors.red, size: 44),
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
                          stops: [
                            0.5,
                            0.8,
                            1.0
                          ], // Ponto de transição das cores
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
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
                            ignoring: true, // Desativa a interação
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
            );
          },
        ),
      ),
    );
  }
}
