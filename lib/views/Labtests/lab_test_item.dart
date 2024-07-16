import 'dart:ui';
import 'package:flutter/material.dart';
import 'LabTestDetailsScreen.dart';

class LabTestItem extends StatelessWidget {
  final String testName;
  final IconData icon;
  final String purpose;
  final String procedure;
  final String preparationInstructions;
  final String turnaroundTime;
  final String risksAndSideEffects;
  final String documentId; // Add this line

  LabTestItem({
    required this.testName,
    required this.icon,
    required this.purpose,
    required this.procedure,
    required this.preparationInstructions,
    required this.turnaroundTime,
    required this.risksAndSideEffects,
    required this.documentId, // Initialize the documentId parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LabTestDetailsScreen(
              testName: testName,
              purpose: purpose,
              procedure: procedure,
              preparationInstructions: preparationInstructions,
              turnaroundTime: turnaroundTime,
              risksAndSideEffects: risksAndSideEffects,
              documentId: documentId, // Pass the documentId parameter
            ),
          ),
        );
      },
      child: SizedBox(
        width: 150, // Adjust the width as needed
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
              ),
              SizedBox(height: 8),
              Text(
                testName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
