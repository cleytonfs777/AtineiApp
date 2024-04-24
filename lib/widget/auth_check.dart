import 'package:atinei_appl/screens/home_screen.dart';
import 'package:atinei_appl/screens/prelogin_screen.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      auth.setUserInit();
      return const PreloginScreen();
    } else {
      auth.setUserInit();
      return const HomeScreen();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
