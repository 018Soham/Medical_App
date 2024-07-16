import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../conts/consts.dart';

class DoctorAppointmentsView extends StatefulWidget {
  final String doctorId;

  const DoctorAppointmentsView({Key? key, required this.doctorId}) : super(key: key);

  @override
  _DoctorAppointmentsViewState createState() => _DoctorAppointmentsViewState();
}

class _DoctorAppointmentsViewState extends State<DoctorAppointmentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointments'),
        backgroundColor: AppColors.purpleColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality here
              // Navigate to HomeView after logout
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('docId', isEqualTo: widget.doctorId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No appointments found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot appointment = snapshot.data!.docs[index];
              DateTime appointmentDateTime = _parseDateTime(appointment['date'], appointment['time']);
              bool isPastAppointment = appointmentDateTime.isBefore(DateTime.now());

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 5,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text('Appointment ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${appointment['name']}'),
                      Text('Email: ${appointment['email']}'),
                      Text('Phone: ${appointment['phone']}'),
                      Text('Date: ${appointment['date']}'),
                      Text('Time: ${appointment['time']}'),
                      Text('Message: ${appointment['message']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          if (isPastAppointment) {
                            _showDeleteConfirmationDialog(context, appointment);
                          } else {
                            _showDeleteNotAllowedDialog(context);
                          }
                        },
                      ),
                      Checkbox(
                        value: appointment['completed'],
                        onChanged: (bool? value) {
                          if (value != null && value) {
                            _showCompleteConfirmationDialog(context, appointment.id);
                          }
                        },
                        checkColor: Colors.green, // Change the color of the check mark to green
                        activeColor: Colors.green.withOpacity(0.5), // Change the color of the checkbox itself to a lighter green
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  DateTime _parseDateTime(String date, String time) {
    List<String> dateParts = date.split('/');
    List<String> timeParts = time.split(':');
    return DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  void _showDeleteNotAllowedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cannot Delete Appointment'),
          content: Text('The appointment date and time have not passed yet. You can only delete past appointments.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCompleteConfirmationDialog(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mark Appointment as Completed'),
          content: Text('Are you sure you want to mark this appointment as completed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(appointmentId)
                    .update({'completed': true});
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, DocumentSnapshot appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Appointment'),
          content: Text('Are you sure you want to delete this appointment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(appointment.id)
                    .delete();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
