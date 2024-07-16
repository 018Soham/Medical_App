import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'BloodTest/blood_test_details.dart';
 // Update with your actual project path

class LabTestDetailsScreen extends StatelessWidget {
  final String testName;
  final String purpose;
  final String procedure;
  final String preparationInstructions;
  final String turnaroundTime;
  final String risksAndSideEffects;
  final String documentId;

  LabTestDetailsScreen({
    required this.testName,
    required this.purpose,
    required this.procedure,
    required this.preparationInstructions,
    required this.turnaroundTime,
    required this.risksAndSideEffects,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(testName),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purpose:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(purpose),
                SizedBox(height: 16.0),
                Text(
                  'Procedure:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(procedure),
                SizedBox(height: 16.0),
                Text(
                  'Preparation Instructions:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(preparationInstructions),
                SizedBox(height: 16.0),
                Text(
                  'Turnaround Time for Results:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(turnaroundTime),
                SizedBox(height: 16.0),
                Text(
                  'Risks and Side Effects:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(risksAndSideEffects),
                SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BloodTestDetails(),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.blue,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Book a Slot',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Minimum charges of 200 will be taken by our Doctor.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                const Center(
                  child: Text(
                    'We will send your certificate via your provided Email ID.',
                    style: TextStyle(
                      color: Colors.red, // You can choose any color
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
