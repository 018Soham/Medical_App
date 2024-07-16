import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../conts/consts.dart';

class BookAppointment extends StatelessWidget {
  final String docId;

  const BookAppointment({Key? key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
        backgroundColor: AppColors.purpleColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppointmentForm(docId: docId),
      ),
    );
  }
}

class AppointmentForm extends StatefulWidget {
  final String docId;

  const AppointmentForm({Key? key, required this.docId}) : super(key: key);

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please log in to book an appointment')));
        return;
      }

      try {
        await FirebaseFirestore.instance.collection('appointments').add({
          'userId': uid,
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'date': _dateController.text,
          'time': _timeController.text,
          'message': _messageController.text,
          'docId': widget.docId, // Set the docId field with the doctor's document ID
          'completed': false, // Add the 'completed' field with a default value of false
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment Booked Successfully')));

        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _dateController.clear();
        _timeController.clear();
        _messageController.clear();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to book appointment')));
        print('Error: $error');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: 'Appointment Date',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an appointment date';
              }
              return null;
            },
            readOnly: true,
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _timeController,
            decoration: InputDecoration(
              labelText: 'Appointment Time',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.access_time),
            ),
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  _timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an appointment time';
              }
              return null;
            },
            readOnly: true,
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.message),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
            maxLines: 3,
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              primary: AppColors.purpleColor,
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text('Book Appointment', style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
