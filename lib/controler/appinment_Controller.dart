
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getAppointments(String userId) {
    return _firestore
        .collection('appointments')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .asyncMap((snapshot) async {
      var appointmentsList = await Future.wait(snapshot.docs.map((doc) async {
        var data = doc.data() as Map<String, dynamic>;
        var docId = data['docId']; // Assuming this is the doctor's document ID

        // Fetch doctor's details using the docId
        var doctorSnapshot = await _firestore.collection('doctors').doc(docId).get();
        if (doctorSnapshot.exists) {
          var doctorData = doctorSnapshot.data() as Map<String, dynamic>;
          return {
            'name': data['name'] ?? 'No Name',
            'email': doctorData['docEmail'] ?? 'No Email', // Fetch doctor's email from doctor data
            'phone': data['phone'] ?? 'No Phone',
            'date': data['date'] ?? 'No Date',
            'time': data['time'] ?? 'No Time',
            'message': data['message'] ?? 'No Message',
            'docId': docId ?? 'No Doctor ID',
            'userId': userId ?? 'No User ID',
            'docName': doctorData['docName'] ?? 'No Doctor Name',
            'docCategory': doctorData['docCategory'] ?? 'No Category',
            'docAddress': doctorData['docAddress'] ?? 'No Address',
            'docPhone': doctorData['docPhone'] ?? 'No Doctor Phone',
            'docTiming': doctorData['docTiming'] ?? 'No Timing',
            'docFees': doctorData['docFees'] ?? 'No Fees',
          };
        } else {
          return null; // Return null if doctor not found
        }
      }));

      // Filter out null appointments
      appointmentsList = appointmentsList.where((appointment) => appointment != null).toList();

      return appointmentsList.cast<Map<String, dynamic>>();
    });
  }
}
