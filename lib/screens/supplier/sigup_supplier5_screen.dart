import 'package:atinei_appl/components/custom_textfield.dart';
import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:atinei_appl/screens/supplier/sigup_supplier4_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SigupSupplier5Screen extends StatefulWidget {
  final SupplierFormData supplierFormData;

  SigupSupplier5Screen({super.key, required this.supplierFormData});

  @override
  State<SigupSupplier5Screen> createState() => _SigupSupplier5ScreenState();
}

class _SigupSupplier5ScreenState extends State<SigupSupplier5Screen> {
  final TextEditingController _respEmpresaController = TextEditingController();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _senhaApp1Controller = TextEditingController();

  final TextEditingController _senhaApp2Controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void _formatarCpf() {
    String texto = _cpfController.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Removendo a formatação para reavaliar e aplicar conforme o tamanho
    if (texto.length < 11) {
      _cpfController.value = TextEditingValue(
        text: texto,
        selection: TextSelection.collapsed(offset: texto.length),
      );
    } else if (texto.length == 11) {
      // Aplica a máscara para 10 dígitos
      final formatado =
          '${texto.substring(0, 3)}.${texto.substring(3, 6)}.${texto.substring(6, 9)}-${texto.substring(9, 11)}';
      _cpfController.value = TextEditingValue(
        text: formatado,
        selection: TextSelection.collapsed(offset: formatado.length),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _cpfController.addListener(_formatarCpf);
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
                          placeholder: "Responsável pela empresa",
                          controller: _respEmpresaController,
                          keyboardtype: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informa o responsável pela empresa';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _cpfController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: AppColors.fundoTextField,
                              filled: true,
                              hintText: "CPF",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.bordaTextField),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  14), // Limita a 15 caracteres, considerando os caracteres da máscara.
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o CPF';
                              } else if (value.length < 14) {
                                return 'CPF inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        CustomTextField(
                          placeholder: "E-mail",
                          controller: _emailController,
                          keyboardtype: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informa o e-mail';
                            } else if (!value.contains('@')) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          placeholder: "Senha",
                          controller: _senhaApp1Controller,
                          obscureText: true,
                          keyboardtype: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informa a senha';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          placeholder: "Confirme a senha",
                          controller: _senhaApp2Controller,
                          obscureText: true,
                          keyboardtype: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirme a senha';
                            } else if (value != _senhaApp1Controller.text) {
                              return 'As senhas devem ser iguais';
                            }
                            return null;
                          },
                        )
                      ]),
                    ),
                    const SizedBox(height: 10),
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
                            if (formKey.currentState!.validate() &&
                                _senhaApp1Controller.text ==
                                    _senhaApp2Controller.text) {
                              widget.supplierFormData.responsavel =
                                  _respEmpresaController.text;
                              widget.supplierFormData.cpf = _cpfController.text;
                              widget.supplierFormData.email =
                                  _emailController.text;
                              widget.supplierFormData.senha =
                                  _senhaApp1Controller.text;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigupSupplier4Screen(
                                    supplierFormData: widget.supplierFormData,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Verifique se as senhas são iguais e se os campos estão corretos.'),
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
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Divider(),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("5-7")],
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
