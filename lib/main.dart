import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:medical/settingScreen/setting_screen.dart';
import 'package:medical/views/AppoinmentDetails/AppoinmentDetails.dart';
import 'package:medical/views/DoctorsTab/doctor_signin_view.dart';
import 'package:medical/views/homeview/home_view.dart';
import 'package:medical/views/login_view/login_view.dart';
import 'package:medical/views/login_view/splashScreen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter bindings have been initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );// Initialize Firebase
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  // Removed 'const' from constructor
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // AppointmentScreen(),
    );
  }
}



