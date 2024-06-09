import 'package:flutter/material.dart';
import 'package:food_order_kelompok/auth/login_or_register.dart';
import 'package:food_order_kelompok/models/warmindo.dart';
import 'package:food_order_kelompok/pages/settings_page.dart';
import 'package:food_order_kelompok/theme/theme_provider.dart';
import 'pages/intro_page.dart';
import 'pages/menu_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        // warmindo provider
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
          '/loginpage': (context) => const LoginOrRegister(),
          '/settings': (context) => const SettingsPage(),
        });
  }
}
