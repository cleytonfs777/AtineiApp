import 'package:atinei_appl/components/custom_button.dart';
import 'package:atinei_appl/screens/login_screen.dart';
import 'package:atinei_appl/screens/sigup_client_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class PreloginScreen extends StatelessWidget {
  const PreloginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/logo.png', // Substitua pelo caminho do seu logotipo
                height: 80.0, // Ajuste a altura conforme necessário
              ),
              const SizedBox(
                height: 100,
              ),
              CustomButton(
                buttonText: "SOU CLIENTE",
                backgroundColor: AppColors.firstGreen,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigupClientScreen(
                        typeUser: "client",
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                buttonText: "SOU PRESTADOR",
                backgroundColor: AppColors.firstPurple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigupClientScreen(
                        typeUser: "supplier",
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Divider(
                  color: Colors.grey[300],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Faz o botão ser transparente
                  textStyle: const TextStyle(
                    color: AppColors.greyback, // Cor do texto em cinza
                    fontWeight: FontWeight.bold, // Texto em negrito
                  ),
                  splashFactory: NoSplash
                      .splashFactory, // Remove o efeito de splash ao pressionar
                ),
                child: const Text(
                  "JÁ SOU CADASTRADO",
                  style: TextStyle(
                    color: Colors.grey, // Cor do texto em cinza
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
