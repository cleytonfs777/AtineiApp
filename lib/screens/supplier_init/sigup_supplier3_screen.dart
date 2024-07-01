import 'package:atinei_appl/components/custom_textfield.dart';
import 'package:atinei_appl/data/supplier_form_data.dart';
import 'package:atinei_appl/screens/supplier_init/sigup_supplier4_screen.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SigupSupplier3Screen extends StatefulWidget {
  final SupplierFormData supplierFormData;

  SigupSupplier3Screen({super.key, required this.supplierFormData});

  @override
  State<SigupSupplier3Screen> createState() => _SigupSupplier3ScreenState();
}

class _SigupSupplier3ScreenState extends State<SigupSupplier3Screen> {
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
      // Aplica a máscara para 11 dígitos
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

  bool _isStrongPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password);
    // RegExp(r'[!@#\$&*~]').hasMatch(password);
  }

  Future<void> _checkEmailAndProceed() async {
    if (formKey.currentState!.validate() &&
        _senhaApp1Controller.text == _senhaApp2Controller.text) {
      final authService = Provider.of<AuthService>(context, listen: false);
      final isRegistered =
          await authService.isEmailRegistered(_emailController.text);

      if (isRegistered) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('E-mail já está cadastrado.')),
        );
      } else {
        widget.supplierFormData.responsavel = _respEmpresaController.text;
        widget.supplierFormData.cpf = _cpfController.text;
        widget.supplierFormData.email = _emailController.text;
        widget.supplierFormData.senha = _senhaApp1Controller.text;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SigupSupplier4Screen(
              supplierFormData: widget.supplierFormData,
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Verifique se as senhas são iguais e se os campos estão corretos.')),
      );
    }
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
                              return 'Informe o responsável pela empresa';
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
                                  14), // Limita a 14 caracteres, considerando os caracteres da máscara.
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
                              return 'Informe o e-mail';
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
                              return 'Informe a senha';
                            } else if (!_isStrongPassword(value)) {
                              return 'A senha deve ter pelo menos 8 caracteres, \nincluindo letra maiúscula, minúscula e número.';
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
                          onPressed: _checkEmailAndProceed,
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
                      children: [Text("3-6")],
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
