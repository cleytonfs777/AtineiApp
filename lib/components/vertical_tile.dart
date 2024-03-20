import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class VerticalTile extends StatelessWidget {
  final Map<String, dynamic> listItems;
  final int index;

  const VerticalTile({required this.listItems, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.firstPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Define o raio das bordas
              child: Image.network(
                listItems['imageUrl'],
                width: 130.0,
                height: 130.0,
                fit: BoxFit.cover, // Define o modo de redimensionamento
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              listItems['title'],
              style: const TextStyle(
                color: AppColors.firstGreen,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 130.0,
              height: 100.0,
              child: Text(
                listItems['description'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.start,
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
    );
  }
}
