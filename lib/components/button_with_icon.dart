import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final IconData? icon;

  const ButtonWithIcon({
    Key? key,
    required this.buttonText,
    required this.backgroundColor,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Define a cor de fundo.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Bordas arredondadas.
          ),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (icon != null)
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: 30, // Tama
                  )
                : Container(),
            const SizedBox(width: 10),
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                // Define a cor do texto.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
