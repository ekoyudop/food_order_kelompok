import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../components/my_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            // Shop Name

            // icon
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('assets/logo.png'),
            ),

            const SizedBox(height: 25),

            // title
            Text("The Taste of Warmindo",
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 44,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center),

            const SizedBox(height: 10),
            // subtitle
            Text("Feel the taste of the original warmindo",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center),

            const SizedBox(height: 30),
            // get started button
            MyButton(
              text: "Get Started",
              onTap: () {
                // Go to login Page
                Navigator.pushNamed(context, '/loginpage');
              },
            )
          ],
        ),
      ),
    );
  }
}
