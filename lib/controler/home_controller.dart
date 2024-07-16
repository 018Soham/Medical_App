import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  var popularDoctors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopularDoctors();
  }

  void fetchPopularDoctors() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('doctors').get();
      popularDoctors.value = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'name': data['docName'] ?? 'Unknown Doctor',
          'category': data['docCategory'] ?? 'Unknown Category',
        };
      }).toList();
    } catch (e) {
      print("Error fetching popular doctors: $e");
    }
  }
}
