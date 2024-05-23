import 'package:flutter/material.dart';

class ParagrafBloc extends StatelessWidget {
  final String? pretext;
  final String? maintext;

  const ParagrafBloc({super.key, this.pretext, required this.maintext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black), // Cor padrão para o texto
          children: <TextSpan>[
            TextSpan(
              text: pretext,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: maintext,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
