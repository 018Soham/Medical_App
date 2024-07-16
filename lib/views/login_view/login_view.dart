import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical/conts/images.dart';
import 'package:medical/conts/strings.dart';
import 'package:medical/res/components/customTextFields.dart';
import 'package:medical/res/components/custom_button.dart';
import 'package:flutter/services.dart';

import '../../controler/auth_controller.dart';
import '../sign_up_view/sign_up_view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // This will close the app
        return Future.value(false); // Prevent the default back button behavior
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Image.asset(AppAssets.icLogin, height: 200),
              Text("Log In", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              SizedBox(height: 30),
              CustomTextField(hint: AppStrings.email, textController: emailController),
              SizedBox(height: 20),
              CustomTextField(hint: AppStrings.password, textController: passwordController, obscureText: true),
              SizedBox(height: 20),
              CustomButton(
                buttonText: "Log In",
                onTap: () {
                  controller.loginUser(emailController.text, passwordController.text);
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignUpView());
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
