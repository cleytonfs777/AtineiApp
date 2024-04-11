import 'package:atinei_appl/components/custom_button.dart';
import 'package:atinei_appl/components/custom_textfield.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:atinei_appl/widget/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRememberMeChecked = false; // Mantenha esta variável aqui
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toggleRememberMe(bool? newValue) {
    setState(() {
      isRememberMeChecked = newValue ?? false;
      print("isChecked: $isRememberMeChecked, newValue: $newValue");
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .login(_emailController.text, _passwordController.text);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthCheck()),
      );
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: IntrinsicHeight(
            child: Container(
              alignment: Alignment.center,
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/logo.png', height: 80.0),
                      const SizedBox(height: 50),
                      CustomTextField(
                        placeholder: "E-mail",
                        controller: _emailController,
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
                        controller: _passwordController,
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
                              child: const Text(
                                "Salvar meu login e minha senha",
                                style: TextStyle(
                                    color: Colors.grey), // Texto em cinza
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
                              buttonText: "ENTRAR",
                              backgroundColor: AppColors.firstGreen,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  login();
                                }
                              }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Divider(color: Colors.grey[300]),
                      ),
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
