import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

import 'login_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to LoginView after a delay of 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Get.to(LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Aaroyga Sathi',
                    speed: Duration(milliseconds: 290), // Adjust speed to ensure animation lasts about 4 seconds
                    cursor: '',
                  ),
                ],
                totalRepeatCount: 1,
                pause: Duration(milliseconds: 0), // No pause to ensure it fits in 4 seconds
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

