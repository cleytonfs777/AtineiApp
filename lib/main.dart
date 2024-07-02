import 'package:atinei_appl/my_app.dart';
import 'package:atinei_appl/providers/client_provider.dart';
import 'package:atinei_appl/providers/supplier_provider.dart';
import 'package:atinei_appl/repository/FavoriteGroup.dart';
import 'package:atinei_appl/service/auth_service.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    // appleProvider: AppleProvider.appAttest,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
            create: (context) => FavoritasRepository(
                  auth: context.read<AuthService>(),
                )),
        ChangeNotifierProvider(create: (context) => ClientProvider()),
        ChangeNotifierProvider(create: (context) => SupplierProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
