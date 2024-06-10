import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/my_button.dart';
import 'package:food_order_kelompok/components/my_textfield.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final TextEditingController emailControler = TextEditingController();

  final TextEditingController passwordControler = TextEditingController();

  // login function
  void login() async {
    // Mengisi logika otentikasi
    final _authService = AuthService();

    try {
      await _authService.signInWithEmailPassword(
          emailControler.text, passwordControler.text);

      // Menampilkan pesan jika login berhasil
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Successful"),
          content: Text("Welcome back! You have successfully logged in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      Navigator.pushNamed(context, '/menupage');
    } catch (e) {
      // Menampilkan pesan jika login gagal
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Login Failed"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Email or password is incorrect. Please check your credentials and try again."),
              SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(Icons.account_circle_rounded,
                size: 100, color: Theme.of(context).colorScheme.inversePrimary),

            const SizedBox(height: 25),
            // massage
            Text(
              "Food Order App",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 25),

            // email input
            MyTextField(
              controller: emailControler,
              hintText: "Email",
              obscureText: false,
            ),

            const SizedBox(height: 10),

            // password input
            MyTextField(
              controller: passwordControler,
              hintText: "Password",
              obscureText: true,
            ),

            const SizedBox(height: 25),

            // login button
            MyButton(text: "Sign In", onTap: login),

            const SizedBox(height: 25),

            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
