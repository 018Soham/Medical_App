import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:medical/conts/colors.dart';
import 'package:medical/settingScreen/terms_conditions.dart';
import '../services/auth_service.dart';
import '../controler/setting_screen_controller.dart';
import '../views/login_view/login_view.dart';

class SettingsScreen extends StatefulWidget {
  final String uid; // Define the uid parameter

  SettingsScreen({required this.uid}); // Constructor with uid parameter

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _image;
  late SettingScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SettingScreenController(widget.uid));
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.purpleColor,
      ),
      body: Obx(() {
        return ListView(
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey) : null,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                controller.userName.value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                AuthService().signOut();
                Get.to(() => LoginView());// Navigate to login page after sign out
                Get.defaultDialog(
                  title: 'Success',
                  middleText: 'Logged out successfully',
                  backgroundColor: AppColors.primaryColor,
                  titleStyle: TextStyle(color: Colors.white),
                  middleTextStyle: TextStyle(color: Colors.white),
                );


              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Terms and Conditions'),
              onTap: () {
                // Navigate to terms and conditions screen
                Get.to(() => TermsCondition());
              },
            ),
          ],
        );
      }),
    );
  }
}
