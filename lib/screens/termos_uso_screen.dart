import 'package:atinei_appl/components/custom_button.dart';
import 'package:atinei_appl/components/paragraf_bloc.dart';
import 'package:atinei_appl/data/termo_aceite_data.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TermoUsoScreen extends StatelessWidget {
  final VoidCallback onAccept;

  const TermoUsoScreen({super.key, required this.onAccept})
      : assert(onAccept != null, "onAccept callback cannot be null");

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dataTermo =
        TermoGenerator(tipo: 'cliente').generateTermo();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 50),
            const Text(
                "TERMO DE ACEITE DAS CONDIÇÕES DE USO E TRATAMENTO DE DADOS",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            const Padding(
              padding: EdgeInsets.symmetric(
                  vertical:
                      10.0), // Adiciona um espaçamento nas laterais e superior(8.0),
              child: Text("– USUÁRIO –",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
            const ParagrafBloc(
                maintext:
                    "A “INDIQUEI” é uma plataforma disponibilizada ao público em geral, que consiste em reunir fornecedores de produtos e serviços para eventos, mediante prévio cadastro, e disponibilizar suas informações para usuários que buscam organizar festividades."),
            const ParagrafBloc(
                maintext:
                    "Tanto o usuário quanto os fornecedores cadastrados são partes legítimas para seguirem regras na plataforma e, ao utilizar os serviços e ferramentas ofertadas, aceitam os termos de uso, que segue descrito abaixo. Recomendamos que leia atentamente este documento antes de prosseguir com o cadastro e utilização da plataforma."),
            // Usando o operador de expansão para inserir uma lista de Widgets Text
            ...dataTermo
                .map((item) => ParagrafBloc(
                    pretext: item['pretext'] ?? 'pretextPadrao',
                    maintext: item['maintext'] ?? 'maintextPadrao'))
                .toList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: CustomButton(
                  buttonText: "Aceito os Termos de Uso",
                  backgroundColor: AppColors.firstGreen,
                  onPressed: onAccept),
            ),
          ]),
        ),
      ),
    );
  }
}
