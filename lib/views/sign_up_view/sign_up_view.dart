import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical/conts/images.dart';
import 'package:medical/conts/strings.dart';
import 'package:medical/res/components/customTextFields.dart';
import 'package:medical/res/components/custom_button.dart';
import '../../controler/auth_controller.dart';
import '../login_view/login_view.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image.asset(AppAssets.icLogin, height: 200),
            Text("Sign Up", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            SizedBox(height: 30),
            CustomTextField(hint: AppStrings.email, textController: emailController),
            SizedBox(height: 20),
            CustomTextField(hint: AppStrings.password, textController: passwordController, obscureText: true),
            SizedBox(height: 20),
            CustomTextField(hint: "Confirm Password", textController: confirmPasswordController, obscureText: true),
            SizedBox(height: 20),
            CustomButton(
              buttonText: "Sign Up",
              onTap: () {
                if (passwordController.text == confirmPasswordController.text) {
                  controller.signupUser(emailController.text, passwordController.text);
                } else {
                  Get.snackbar('Error', 'Passwords do not match');
                }
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Get.off(LoginView());
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
