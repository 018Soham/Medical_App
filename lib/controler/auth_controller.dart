import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../conts/consts.dart';
import '../views/homeview/home_view.dart';
import '../views/login_view/login_view.dart'; // Update the path according to your project structure

class AuthController extends GetxController {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Sign up method
  Future<void> signupUser(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await storeUserData(userCredential.user!.uid, fullnameController.text, email);
      // Navigate to login screen after successful signup
      Get.off(() => LoginView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message!);
    }
  }

  // Login method
  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to home screen or any other screen after successful login
      Get.off(() => HomeView());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message!);
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginView()); // Navigate to login screen after sign out
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message!);
    }
  }

  // Store user data in Firestore
  Future<void> storeUserData(String uid, String fullname, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'fullname': fullname,
      'email': email,
      'uid': uid,
    });
  }
}
