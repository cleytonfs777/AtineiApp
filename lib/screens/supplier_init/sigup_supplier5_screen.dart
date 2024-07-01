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
                    Stack(
                      clipBehavior:
                          Clip.none, // Permite que o botão extrapole os limites
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColors.firstPurple,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Premium',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 44.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              CardPriceText(
                                text: 'R\$ 4,90',
                                isbold: true,
                                fontSizeType: 44.0,
                              ),
                              CardPriceText(
                                text: 'À PARTIR DO 6º MÊS R\$ 15,90',
                              ),
                              CardPriceText(
                                text:
                                    'Informações de contato (telefone, e-mail, endereço)',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text:
                                    'Upload de fotos dos serviços realizados (até 5 fotos)',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text: 'Avaliação dos clientes',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text: 'Chat Atinei (Cliente - fornecedor)',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text: 'Botão Whatsapp',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text: 'Fotos dos serviços na página',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text: 'inicial do site (carrossel)',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text:
                                    'Empresa topo - aparecerá no topo do segmento após pesquisa do cliente',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              SizedBox(
                                  height:
                                      40.0), // Espaço para o botão na parte inferior
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -25.0, // Ajuste para extrapolar
                          child: ElevatedButton(
                            onPressed: () {
                              // Configura como plano Premium
                              widget.supplierFormData.plain = 'PREMIUM';
                              // Atualiza a data de expiração ao clicar no botão
                              widget.supplierFormData.expiresIn =
                                  DateTime.now().add(const Duration(days: 60));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigupSupplier6Screen(
                                    supplierFormData: widget.supplierFormData,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.firstGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
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
                    ),
                    const SizedBox(
                        height: 50), // Espaço extra para acomodar o botão
                    Stack(
                      clipBehavior:
                          Clip.none, // Permite que o botão extrapole os limites
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColors.firstGreen,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Básico',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 44.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              CardPriceText(
                                text: 'R\$ 1,90',
                                isbold: true,
                                fontSizeType: 44.0,
                              ),
                              CardPriceText(
                                text: 'À PARTIR DO 6º MÊS R\$ 9,90',
                              ),
                              CardPriceText(
                                text:
                                    'Informações de contato (telefone, e-mail, endereço)',
                                simbol: '✔️',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text:
                                    'Upload de fotos dos serviços realizados (até 5 fotos)',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text: 'Avaliação dos clientes',
                                simbol: '✓',
                                colorType: Colors.green,
                              ),
                              CardPriceText(
                                text: 'Chat Atinei (Cliente - fornecedor)',
                                simbol: '✖️',
                                colorType: Colors.red,
                              ),
                              CardPriceText(
                                text: 'Botão Whatsapp',
                                simbol: '✖️',
                                colorType: Colors.red,
                              ),
                              CardPriceText(
                                text: 'Fotos dos serviços na página',
                                simbol: '✖️',
                                colorType: Colors.red,
                              ),
                              CardPriceText(
                                text: 'inicial do site (carrossel)',
                                simbol: '✖️',
                                colorType: Colors.red,
                              ),
                              CardPriceText(
                                text:
                                    'Empresa topo - aparecerá no topo do segmento após pesquisa do cliente',
                                simbol: '✖️',
                                colorType: Colors.red,
                              ),
                              SizedBox(
                                  height:
                                      40.0), // Espaço para o botão na parte inferior
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -25.0, // Ajuste para extrapolar
                          child: ElevatedButton(
                            onPressed: () {
                              // Configura como plano Premium
                              widget.supplierFormData.plain = 'PREMIUM';
                              // Atualiza a data de expiração ao clicar no botão
                              widget.supplierFormData.expiresIn =
                                  DateTime.now().add(const Duration(days: 60));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigupSupplier6Screen(
                                    supplierFormData: widget.supplierFormData,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.firstPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
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
}
