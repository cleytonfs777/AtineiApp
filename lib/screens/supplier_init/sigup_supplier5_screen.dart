import 'package:atinei_appl/components/cardprice_text.dart';
import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:atinei_appl/screens/supplier_init/sigup_supplier6_screen%20.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SigupSupplier5Screen extends StatefulWidget {
  final SupplierFormData supplierFormData;

  SigupSupplier5Screen({super.key, required this.supplierFormData});

  @override
  State<SigupSupplier5Screen> createState() => _SigupSupplier5ScreenState();
}

class _SigupSupplier5ScreenState extends State<SigupSupplier5Screen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                color: const Color.fromRGBO(255, 255, 255, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/logo.png', height: 80.0),
                    const SizedBox(height: 40),
                    Container(
                      color: AppColors.greyBar,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 35.0),
                        child: Text(
                          "Selecione o plano desejado",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: AppColors.firstPurple,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildPlanOption(
                      context: context,
                      title: 'Premium',
                      price: 'R\$ 4,90',
                      afterPrice: 'À PARTIR DO 6º MÊS R\$ 15,90',
                      benefits: [
                        'Informações de contato (telefone, e-mail, endereço)',
                        'Upload de fotos dos serviços realizados (até 5 fotos)',
                        'Avaliação dos clientes',
                        'Chat Atinei (Cliente - fornecedor)',
                        'Botão Whatsapp',
                        'Fotos dos serviços na página inicial do site (carrossel)',
                        'Empresa topo - aparecerá no topo do segmento após pesquisa do cliente',
                      ],
                      onSelect: () => selectPlan('PREMIUM'),
                      buttonColor: AppColors.firstGreen,
                    ),
                    const SizedBox(height: 50),
                    buildPlanOption(
                      context: context,
                      title: 'Básico',
                      price: 'R\$ 1,90',
                      afterPrice: 'À PARTIR DO 6º MÊS R\$ 9,90',
                      benefits: [
                        'Informações de contato (telefone, e-mail, endereço)',
                        'Upload de fotos dos serviços realizados (até 5 fotos)',
                        'Avaliação dos clientes',
                        'Chat Atinei (Cliente - fornecedor)',
                        'Botão Whatsapp',
                        'Fotos dos serviços na página inicial do site (carrossel)',
                        'Empresa topo - aparecerá no topo do segmento após pesquisa do cliente',
                      ],
                      onSelect: () => selectPlan('BASICO'),
                      buttonColor: AppColors.firstPurple,
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.greyBar, // Define a cor de fundo.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Bordas arredondadas.
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Text(
                              "VOLTAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                // Define a cor do texto.
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Selecione um plano para prosseguir'),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.firstGreen, // Define a cor de fundo.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Bordas arredondadas.
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Text(
                              "PRÓXIMA",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                // Define a cor do texto.
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Divider(),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("5-6")],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlanOption({
    required BuildContext context,
    required String title,
    required String price,
    required String afterPrice,
    required List<String> benefits,
    required VoidCallback onSelect,
    required Color buttonColor,
  }) {
    final lista = [
      'Avaliação dos clientes',
      'Chat Atinei (Cliente - fornecedor)',
      'Botão Whatsapp',
      'Fotos dos serviços na página inicial do site (carrossel)',
      'Empresa topo - aparecerá no topo do segmento após pesquisa do cliente',
    ];
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: title == 'Premium'
                ? AppColors.firstPurple
                : AppColors.firstGreen,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 44.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              CardPriceText(
                text: price,
                isbold: true,
                fontSizeType: 44.0,
              ),
              CardPriceText(
                text: afterPrice,
              ),
              ...benefits.map(
                (benefit) => CardPriceText(
                  text: benefit,
                  simbol: (title != 'Premium' && lista.contains(benefit))
                      ? 'x'
                      : '✓',
                  colorType: (title != 'Premium' && lista.contains(benefit))
                      ? Colors.red
                      : Colors.green,
                ),
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
        Positioned(
          bottom: -25.0,
          child: ElevatedButton(
            onPressed: onSelect,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Text(
                'SELECIONAR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectPlan(String plan) {
    setState(() {
      widget.supplierFormData.plain = plan;
      widget.supplierFormData.expiresIn =
          DateTime.now().add(const Duration(days: 60));
    });

    print('Navigating to next screen');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SigupSupplier6Screen(
          supplierFormData: widget.supplierFormData,
        ),
      ),
    ).then((_) {
      print('Navigation completed');
    });
  }
}
