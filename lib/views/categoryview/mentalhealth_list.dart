import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../conts/consts.dart';
import '../BookAppoinment/book_appoinment.dart';

class MentalHealthDoctorsDetailsScreen extends StatelessWidget {
  const MentalHealthDoctorsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mental Health Doctors'),
        backgroundColor: AppColors.purpleColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetX<MentalHealthDoctorsController>(
          init: MentalHealthDoctorsController(),
          builder: (controller) {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (controller.doctors.isEmpty) {
              return Center(child: Text('No doctors found.'));
            }
            return ListView.builder(
              itemCount: controller.doctors.length,
              itemBuilder: (context, index) {
                final doctor = controller.doctors[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.medical_services, color: AppColors.purpleColor),
                    title: Text(doctor['docName']),
                    subtitle: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        SizedBox(width: 4),
                        Text(doctor['docRating'].toString()),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.purpleColor),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookAppointment(docId: doctor['docId']),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class MentalHealthDoctorsController extends GetxController {
  var isLoading = true.obs;
  var doctors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  void fetchDoctors() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .where('docCategory', isEqualTo: 'Mental Health')
          .get();

      final List<Map<String, dynamic>> loadedDoctors = snapshot.docs.map((doc) {
        return {
          'docId': doc.id, // Include the document ID
          'docName': doc['docName'],
          'docRating': doc['docRating'],
        };
      }).toList();

      doctors.value = loadedDoctors;
    } catch (e) {
      print('Error fetching doctors: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
