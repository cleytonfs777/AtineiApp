import 'package:atinei_appl/components/button_socialmedia.dart';
import 'package:atinei_appl/components/custom_button.dart';
import 'package:atinei_appl/components/custom_textfield.dart';

import 'package:atinei_appl/screens/termos_uso_screen.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:atinei_appl/widget/auth_check.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SigupClientScreen extends StatefulWidget {
  String typeUser;

  SigupClientScreen({super.key, required this.typeUser});

  @override
  State<SigupClientScreen> createState() => _SigupClientScreenState();
}

class _SigupClientScreenState extends State<SigupClientScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isRememberMeChecked = false; // Mantenha esta variável aqui
  final TextEditingController _firstPasswordController =
      TextEditingController();
  final TextEditingController _secondPasswordController =
      TextEditingController();
  final telefoneController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    telefoneController.addListener(_formatarTelefone);
  }

  void register(userData, pass) async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .registrarCliente(userData: userData, pass: pass);
      // Operação de registro bem-sucedida; atualizar o estado aqui se necessário.
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthCheck()),
      );
    } on AuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstPasswordController.dispose();
    _secondPasswordController.dispose();
    _nameController.dispose();
    telefoneController.removeListener(_formatarTelefone);
    telefoneController.dispose();
    super.dispose();
  }

  void toggleRememberMe(bool? newValue) {
    setState(() {
      isRememberMeChecked = newValue ?? false;
      print("isChecked: $isRememberMeChecked, newValue: $newValue");
    });
  }

  void _formatarTelefone() {
    String texto = telefoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Removendo a formatação para reavaliar e aplicar conforme o tamanho
    if (texto.length < 10) {
      telefoneController.value = TextEditingValue(
        text: texto,
        selection: TextSelection.collapsed(offset: texto.length),
      );
    } else if (texto.length == 10) {
      // Aplica a máscara para 10 dígitos
      final formatado =
          '(${texto.substring(0, 2)}) ${texto.substring(2, 6)}-${texto.substring(6, 10)}';
      telefoneController.value = TextEditingValue(
        text: formatado,
        selection: TextSelection.collapsed(offset: formatado.length),
      );
    } else if (texto.length == 11) {
      // Aplica a máscara para 11 dígitos
      final formatado =
          '(${texto.substring(0, 2)}) ${texto.substring(2, 7)}-${texto.substring(7, 11)}';
      telefoneController.value = TextEditingValue(
        text: formatado,
        selection: TextSelection.collapsed(offset: formatado.length),
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
                alignment: Alignment.center,
                color: const Color.fromRGBO(255, 255, 255, 1),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                            placeholder: "Nome",
                            controller: _nameController,
                            keyboardtype: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informa seu Nome';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            placeholder: "E-mail",
                            controller: _emailController,
                            keyboardtype: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informa seu E-mail';
                              } else if (!value.contains('@')) {
                                return 'E-mail inválido';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            placeholder: "Senha",
                            obscureText: true,
                            controller: _firstPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe a senha';
                              }
                              if (value.length < 6) {
                                return 'A senha deve ter pelo menos 6 dígitos';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            placeholder: "Repetir Senha",
                            obscureText: true,
                            controller: _secondPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Repita a senha';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: telefoneController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: AppColors.fundoTextField,
                                filled: true,
                                hintText: 'Telefone',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.bordaTextField),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    15), // Limita a 15 caracteres, considerando os caracteres da máscara.
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o número do telefone';
                                } else if (value.length < 14) {
                                  // Checando se o valor tem menos de 15 caracteres
                                  return 'Por favor, insira um número de telefone válido';
                                }
                                return null; // Retorna null se o dado estiver válido
                              },
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .max, // Altere para max para ocupar toda a largura disponível
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Mantém o alinhamento à esquerda
                          children: [
                            Checkbox(
                              value: isRememberMeChecked,
                              onChanged: toggleRememberMe,
                              activeColor:
                                  Colors.grey, // Fundo da caixa de seleção
                            ),
                            GestureDetector(
                              onTap: () =>
                                  toggleRememberMe(!isRememberMeChecked),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TermoUsoScreen(onAccept: () {
                                        Navigator.pop(
                                            context); // Retorna para a tela anterior
                                        toggleRememberMe(
                                            true); // Seta isRememberMeChecked como true
                                      }),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors
                                            .black), // Cor padrão para o texto
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: 'Estou de acordo com os '),
                                      TextSpan(
                                        text: 'termos de uso',
                                        style: const TextStyle(
                                            color: Colors
                                                .blue), // Estilo para 'termos de uso'
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navega para a tela de Termos de Uso
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TermoUsoScreen(
                                                        onAccept: () {
                                                  Navigator.pop(
                                                      context); // Retorna para a tela anterior
                                                  toggleRememberMe(
                                                      true); // Seta isRememberMeChecked como true
                                                }),
                                              ),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      (loading)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors
                                      .firstGreen, // Define a cor de fundo.
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0), // Bordas arredondadas.
                                  ),
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                child: const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : CustomButton(
                              buttonText: "CADASTRAR",
                              backgroundColor: AppColors.firstGreen,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // Verifica se isRememberMeChecked é true
                                  if (!isRememberMeChecked) {
                                    // Mostra um alerta ou uma mensagem de erro
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: const Text(
                                            'Por favor, aceite os termos de uso.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else if (_firstPasswordController.text ==
                                      _secondPasswordController.text) {
                                    // Procede com o envio do formulário
                                    Map<String, dynamic> userData = {
                                      "name": _nameController.text,
                                      "email": _emailController.text,
                                      "phone": telefoneController.text,
                                      "photo_url": null,
                                      "favorites": [],
                                      "type": "client",
                                    };
                                    register(userData,
                                        _firstPasswordController.text);
                                  } else {
                                    // Mostra um alerta ou uma mensagem de erro
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content:
                                            Text('As senhas não correspondem.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Divider(color: Colors.grey[300]),
                      ),
                      ButtonSocialmedia(
                        buttonText: "Login com Google",
                        backgroundColor: AppColors.firstBlue,
                        onPressed: () async {
                          try {
                            setState(() => loading = true);
                            final user = await context
                                .read<AuthService>()
                                .signInWithGoogle();
                            if (!mounted) {
                              return; // Adiciona esta linha para verificar se o estado ainda existe
                            }
                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AuthCheck()),
                              );
                            } else {
                              throw AuthException(
                                  'Autenticação com Google falhou');
                            }
                          } catch (e) {
                            if (!mounted) {
                              return; // Adiciona esta linha para verificar se o estado ainda existe
                            }
                            setState(() => loading = false);
                            final errorMessage = e is AuthException
                                ? e.message
                                : 'Ocorreu um erro durante o login.';
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)));
                          }
                        },
                        simbolmedia: FontAwesomeIcons.google,
                        widthMain: 230.0,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
