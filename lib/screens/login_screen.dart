import 'package:atinei_appl/components/custom_button.dart';
import 'package:atinei_appl/components/custom_textfield.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRememberMeChecked = false; // Mantenha esta variável aqui

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/logo.png', height: 80.0),
                    const SizedBox(height: 50),
                    CustomTextField(
                        placeholder: "E-mail", controller: _emailController),
                    CustomTextField(
                        placeholder: "Senha",
                        obscureText: true,
                        controller: _passwordController),
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
                            onTap: () => toggleRememberMe(!isRememberMeChecked),
                            child: const Text(
                              "Salvar meu login e minha senha",
                              style: TextStyle(
                                  color: Colors.grey), // Texto em cinza
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                        buttonText: "ENTRAR",
                        backgroundColor: AppColors.firstGreen,
                        onPressed: () {}),
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
    );
  }
}
