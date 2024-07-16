import 'package:flutter/material.dart';
import 'package:medical/res/components/customTextFields.dart';
import '../../conts/consts.dart';


class DoctorSignUpView extends StatefulWidget {
  const DoctorSignUpView({Key? key}) : super(key: key);

  @override
  _DoctorSignUpViewState createState() => _DoctorSignUpViewState();
}

class _DoctorSignUpViewState extends State<DoctorSignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleSignUp() {
    // Your sign-up logic goes here

    // // After successful sign-up, navigate to DoctorAppointmentsView
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     // builder: (context) => DoctorAppointmentsView(doctorId: 'Ju0G3eQ16r3uh4JIPZ35'), // Example doctorId
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Sign Up'),
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
              CustomTextField(
                hint: 'Name',
                textController: nameController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hint: 'Email',
                textController: emailController,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hint: 'Password',
                textController: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: handleSignUp,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Sign Up',
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

