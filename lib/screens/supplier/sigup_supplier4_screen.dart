import 'package:atinei_appl/components/custom_textfield.dart';
import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SigupSupplier2Screen extends StatelessWidget {
  final SupplierFormData supplierFormData;

  SigupSupplier2Screen({super.key, required this.supplierFormData});

  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                          placeholder: "Rua ou avenida da empresa",
                          controller: _ruaController,
                          keyboardtype: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a rua ou avenida da empresa';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            // Número (1/3 do espaço)
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _numeroController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: AppColors.fundoTextField,
                                    filled: true,
                                    hintText: "Número",
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.bordaTextField),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Informe o número';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10), // Espaço entre os campos
                            // Bairro (2/3 do espaço)
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _bairroController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    fillColor: AppColors.fundoTextField,
                                    filled: true,
                                    hintText: "Bairro",
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.bordaTextField),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Informe o Bairro';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        CustomTextField(
                          placeholder: "Cidade",
                          controller: _cidadeController,
                          keyboardtype: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a Cidade';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          placeholder: "Estado",
                          controller: _estadoController,
                          keyboardtype: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o estado';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          placeholder: "Telefone",
                          controller: _telefoneController,
                          keyboardtype: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o telefone';
                            }
                            return null;
                          },
                        ),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
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
                          onPressed: () {},
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
                      children: [Text("2-4")],
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
