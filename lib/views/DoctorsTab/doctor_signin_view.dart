import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../conts/consts.dart';
import 'doctors_appointment_view.dart';

class DoctorSignInView extends StatefulWidget {
  const DoctorSignInView({Key? key}) : super(key: key);

  @override
  _DoctorSignInViewState createState() => _DoctorSignInViewState();
}

class _DoctorSignInViewState extends State<DoctorSignInView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
      await FirebaseFirestore.instance.collection('doctors').get();

      final doctors = doctorsSnapshot.docs.map((doc) => {
        'docId': doc['docId'],
        'email': doc['docEmail'],
        'password': doc['docPassword'],
      }).toList();

      final Map<String, dynamic>? doctor = doctors.firstWhere(
            (doctor) => doctor['email'] == emailController.text && doctor['password'] == passwordController.text,
        // orElse: () => null,
      );

      if (doctor != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorAppointmentsView(doctorId: doctor['docId']),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Doctor Not Registered'),
              content: Text('Please contact the authority to register.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Sign-in failed: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sign-in Failed'),
            content: Text('An error occurred. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Sign In'),
        backgroundColor: AppColors.purpleColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/img_login.png',
                height: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 44),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _signIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.purpleColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
