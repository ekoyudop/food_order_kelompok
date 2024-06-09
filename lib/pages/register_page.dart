import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/my_button.dart';
import 'package:food_order_kelompok/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controller
  final TextEditingController emailControler = TextEditingController();

  final TextEditingController passwordControler = TextEditingController();

  final TextEditingController confirmPasswordControler =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
              "Let's create an account for you",
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

            // confirm password input
            MyTextField(
              controller: confirmPasswordControler,
              hintText: "Confirm Password",
              obscureText: true,
            ),

            const SizedBox(height: 25),

            // login button
            MyButton(text: "Sign up", onTap: () {}),

            const SizedBox(height: 25),

            // already have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login now",
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
