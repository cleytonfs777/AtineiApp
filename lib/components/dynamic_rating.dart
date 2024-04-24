import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DynamicRatingBar extends StatefulWidget {
  final bool readOnly; // Controla se a barra de classificação é interativa
  final double currentRating; // Classificação inicial fornecida

  const DynamicRatingBar({
    Key? key,
    this.readOnly = false,
    this.currentRating = 3.0, // Valor padrão se não for especificado
  }) : super(key: key);

  @override
  _DynamicRatingBarState createState() => _DynamicRatingBarState();
}

class _DynamicRatingBarState extends State<DynamicRatingBar> {
  late double currentRating;

  @override
  void initState() {
    super.initState();
    currentRating = widget.currentRating; // Inicializa com o valor passado
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring:
          widget.readOnly, // Desativa a interação se readOnly for verdadeiro
      child: RatingBar.builder(
        itemBuilder: (context, index) => Icon(
          index < currentRating ? Icons.star : Icons.star_border,
          color: index < currentRating
              ? AppColors.firstGreen
              : const Color.fromARGB(255, 185, 43, 43),
        ),
        onRatingUpdate: (rating) {
          if (!widget.readOnly) {
            // Verifica se não está em modo somente leitura antes de atualizar
            setState(() {
              currentRating = rating;
            });
          }
        },
        itemSize: 20.0,
        initialRating: currentRating,
        minRating: 1,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
      ),
    );
  }
}
