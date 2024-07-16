
import 'package:flutter/material.dart';
import '../../controler/appinment_Controller.dart';
import '../../conts/colors.dart';

class AppointmentScreen extends StatelessWidget {
  final String userId;

  AppointmentScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final appointmentController = AppointmentController();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
        backgroundColor: AppColors.purpleColor,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: appointmentController.getAppointments(userId),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No appointments available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var appointment = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Doctor Name: ${appointment['docName']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Category: ${appointment['docCategory']}'),
                        Text('Email: ${appointment['email']}'), // Use 'email' field instead of 'docEmail'
                        Text('Fees: ${appointment['docFees']}'),
                        Text('Phone: ${appointment['docPhone']}'),
                        Text('Timing: ${appointment['docTiming']}'),
                        Text('Address: ${appointment['docAddress']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
