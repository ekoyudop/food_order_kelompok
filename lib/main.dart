import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order_kelompok/services/auth/login_or_register.dart';
import 'package:food_order_kelompok/firebase_options.dart';
import 'package:food_order_kelompok/models/warmindo.dart';
import 'package:food_order_kelompok/pages/settings_page.dart';
import 'package:food_order_kelompok/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/intro_page.dart';
import 'pages/menu_page.dart';
import 'pages/add_menu_page.dart';
import 'pages/all_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => Warmindo()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/menupage': (context) => const HomePage(),
        '/addmenupage': (context) => AddMenuPage(),
        '/allmenupage': (context) => MenuPage(),
        '/loginpage': (context) => const LoginOrRegister(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
