import 'package:atinei_appl/components/custom_textfield.dart';
import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:atinei_appl/screens/supplier/sigup_supplier2_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SigupSupplier1Screen extends StatefulWidget {
  SigupSupplier1Screen({super.key});

  @override
  State<SigupSupplier1Screen> createState() => _SigupSupplier1ScreenState();
}

class _SigupSupplier1ScreenState extends State<SigupSupplier1Screen> {
  final TextEditingController _razaoSocialController = TextEditingController();

  final TextEditingController _cnpjController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final SupplierFormData supplierFormData = SupplierFormData();

  void formatarCnpj() {
    String texto = _cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Removendo a formatação para reavaliar e aplicar conforme o tamanho
    if (texto.length < 14) {
      _cnpjController.value = TextEditingValue(
        text: texto,
        selection: TextSelection.collapsed(offset: texto.length),
      );
    } else if (texto.length == 14) {
      // Aplica a máscara para 10 dígitos
      final formatado =
          '${texto.substring(0, 2)}.${texto.substring(2, 5)}.${texto.substring(5, 8)}/${texto.substring(8, 12)}-${texto.substring(12, 14)}';
      _cnpjController.value = TextEditingValue(
        text: formatado,
        selection: TextSelection.collapsed(offset: formatado.length),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _cnpjController.addListener(formatarCnpj);
  }

  @override
  void dispose() {
    _cnpjController.removeListener(formatarCnpj);
    super.dispose();
  }

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
                    const SizedBox(height: 50),
                    Form(
                      key: formKey,
                      child: Column(children: [
                        CustomTextField(
                          placeholder: "Razão Social",
                          controller: _razaoSocialController,
                          keyboardtype: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informa sua Razão Social';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _cnpjController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: AppColors.fundoTextField,
                              filled: true,
                              hintText: "CNPJ",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.bordaTextField),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  18), // Limita a 15 caracteres, considerando os caracteres da máscara.
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o CNPJ';
                              } else if (value.length < 18) {
                                return 'CNPJ inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 120),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: 100,
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              supplierFormData.razaoSocial =
                                  _razaoSocialController.text;
                              supplierFormData.cnpj = _cnpjController.text;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigupSupplier2Screen(
                                      supplierFormData: supplierFormData),
                                ),
                              );
                            }
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
                      padding: EdgeInsets.only(top: 20.0, bottom: 120.0),
                      child: Divider(),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("1-7")],
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
