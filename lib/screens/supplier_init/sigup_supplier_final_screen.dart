import 'package:atinei_appl/styles/app_colors.dart';
import 'package:atinei_appl/widget/auth_check.dart';
import 'package:flutter/material.dart';

class SigupSupplierFinalScreen extends StatefulWidget {
  final bool isRenderSucess;

  SigupSupplierFinalScreen({super.key, required this.isRenderSucess});

  @override
  _SigupSupplierFinalScreenState createState() =>
      _SigupSupplierFinalScreenState();
}

class _SigupSupplierFinalScreenState extends State<SigupSupplierFinalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.isRenderSucess
                ? const Text("🥳",
                    style: TextStyle(
                        color: AppColors.firstGreen,
                        fontSize: 70,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
                : const Text(
                    "😔",
                    style: TextStyle(color: Colors.red, fontSize: 70),
                  ),
            widget.isRenderSucess
                ? const Text("Cadastro concluido com Sucesso!!",
                    style: TextStyle(
                        color: AppColors.firstGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
                : const Text(
                    "Não foi possível concluir seu cadastro. Tente novamente mais tarde.",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthCheck(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.firstPurple, // Define a cor de fundo.
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
