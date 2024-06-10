import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/my_button.dart';
import 'package:food_order_kelompok/components/my_textfield.dart';
import 'package:food_order_kelompok/services/auth/auth_service.dart';

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
  void Login() async {
    // fill authentication logic
    final _authService = AuthService();

    try {
      await _authService.signInWithEmailPassword(
        emailControler.text,
        passwordControler.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
    // navigate to menu page
    Navigator.pushNamed(context, '/menupage');
  }

  void forgotPw() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("User tapped forgot password."),
      ),
    );
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
            MyButton(text: "Sign In", onTap: Login),

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
