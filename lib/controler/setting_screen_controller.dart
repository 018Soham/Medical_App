import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingScreenController extends GetxController {
  var userName = ''.obs;

  SettingScreenController(String uid) {
    fetchUserName(uid);
  }

  void fetchUserName(String uid) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        userName.value = userDoc['email'] ?? 'No Name';
      } else {
        userName.value = 'User not found';
      }
    } catch (e) {
      print("Error fetching user: $e");
      userName.value = 'Error fetching user';
    }
  }
}
