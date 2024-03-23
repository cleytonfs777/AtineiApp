import 'package:atinei_appl/components/button_socialmedia.dart';
import 'package:atinei_appl/components/custom_button.dart';
import 'package:atinei_appl/components/custom_textfield.dart';
import 'package:atinei_appl/screens/login_screen.dart';
import 'package:atinei_appl/styles/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigupClientScreen extends StatefulWidget {
  const SigupClientScreen({super.key});

  @override
  State<SigupClientScreen> createState() => _SigupClientScreenState();
}

class _SigupClientScreenState extends State<SigupClientScreen> {
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
                      placeholder: "Nome",
                      controller: _emailController,
                    ),
                    CustomTextField(
                      placeholder: "E-mail",
                      controller: _emailController,
                    ),
                    CustomTextField(
                        placeholder: "Senha",
                        obscureText: true,
                        controller: _passwordController),
                    CustomTextField(
                        placeholder: "Repetir Senha",
                        obscureText: true,
                        controller: _passwordController),
                    CustomTextField(
                      placeholder: "Telefone (Opcional)",
                      controller: _emailController,
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
                            onTap: () => toggleRememberMe(!isRememberMeChecked),
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
                                                  const LoginScreen()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                        buttonText: "CADASTRAR",
                        backgroundColor: AppColors.firstGreen,
                        onPressed: () {
                          // Exemplo de navegação de uma tela para outra
                          Navigator.pushNamed(context, '/home_screen');
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Divider(color: Colors.grey[300]),
                    ),
                    ButtonSocialmedia(
                      buttonText: "Login com Google",
                      backgroundColor: AppColors.firstBlue,
                      onPressed: () {},
                      simbolmedia: FontAwesomeIcons.google,
                      widthMain: 230.0,
                    ),
                    const SizedBox(height: 20),
                    ButtonSocialmedia(
                      buttonText: "Login com Facebook",
                      backgroundColor: const Color(0xFF1877F2),
                      onPressed: () {},
                      simbolmedia: FontAwesomeIcons.facebookF,
                      widthMain: 260.0,
                    ),
                    const SizedBox(height: 20),
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
