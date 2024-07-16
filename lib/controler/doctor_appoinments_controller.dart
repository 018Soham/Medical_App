import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorAppointmentController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getAppointments(String docId) {
    return _firestore
        .collection('appointments')
        .where('docId', isEqualTo: docId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return data;
      }).toList();
    });
  }
}
