import 'package:flutter/material.dart';

class CardPriceText extends StatelessWidget {
  final String text;
  final String? simbol;
  final Color colorType;
  final double fontSizeType;
  final bool isbold;
  final TextAlign aligntext;

  const CardPriceText({
    Key? key,
    required this.text,
    this.simbol,
    this.colorType = Colors.white,
    this.fontSizeType = 18.0,
    this.isbold = false,
    this.aligntext = TextAlign.justify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (simbol == null)
          Text(
            text,
            style: TextStyle(
              fontSize: fontSizeType,
              color: Colors.white,
              fontWeight: isbold ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: aligntext,
          )
        else
          RichText(
            textAlign: aligntext,
            text: TextSpan(
              children: [
                TextSpan(
                  text: simbol,
                  style: TextStyle(
                    fontSize: fontSizeType + 10.0,
                    color: colorType,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' ', // Adiciona um espaço entre o simbol e o texto
                  style: TextStyle(fontSize: fontSizeType),
                ),
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: fontSizeType,
                    color: Colors.white,
                    fontWeight: isbold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(
            height: 8.0), // Ajuste a altura do espaçamento conforme necessário
      ],
    );
  }
}
