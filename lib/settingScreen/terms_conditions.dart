import 'package:flutter/material.dart';
import '../conts/consts.dart'; // Ensure this contains necessary styling and constants

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Colors.green, // Change to a green color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction',
              style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 10),
            Text(
              'Welcome to Our Medical App! By accessing or using our service, you agree to be bound by these terms. If you disagree with any part of the terms, you may not access the service.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 10),
            Text(
              'Your privacy is important to us. It is our policy to respect your privacy and comply with any applicable law and regulation regarding any personal information we may collect about you...',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            // Additional sections could be added similarly
          ],
        ),
      ),
    );
  }
}
