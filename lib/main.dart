import 'package:atinei_appl/screens/home_screen.dart';
import 'package:atinei_appl/screens/login_screen.dart';
import 'package:atinei_appl/screens/prelogin_screen.dart';
import 'package:atinei_appl/screens/sigup_client_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atinei App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 155, 156, 156),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/', // Define a tela inicial usando initialRoute
      // home: const PreloginScreen(), // Remova esta linha
      routes: {
        '/': (context) => const PreloginScreen(), // Tela inicial
        '/login_screen': (context) => const LoginScreen(), // Login
        '/home_screen': (context) => const HomeScreen(), // Home
        '/sigup_client_screen': (context) => const SigupClientScreen(), // Home
      },
    );
  }
}
