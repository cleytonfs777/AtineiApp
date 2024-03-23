import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonSocialmedia extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final IconData simbolmedia;
  final VoidCallback onPressed;
  final double widthMain;

  const ButtonSocialmedia({
    Key? key,
    required this.buttonText,
    required this.backgroundColor,
    required this.simbolmedia,
    required this.onPressed,
    required this.widthMain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthMain,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor, // Define a cor de fundo.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0), // Bordas arredondadas.
            ),
            minimumSize: const Size.fromHeight(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                simbolmedia,
                color: Colors.white, // Cor do ícone
                size: 24.0, // Tamanho do ícone
              ),
              const SizedBox(width: 10), // Espaço de 20 pixels entre os ícones

              Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  // Define a cor do texto.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
