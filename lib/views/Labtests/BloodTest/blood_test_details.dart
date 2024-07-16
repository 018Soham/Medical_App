import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../conts/colors.dart';

class BloodTestDetails extends StatelessWidget {
  const BloodTestDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Slot'),
        backgroundColor: AppColors.purpleColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SlotBookingForm(),
      ),
    );
  }
}

class SlotBookingForm extends StatefulWidget {
  const SlotBookingForm({Key? key}) : super(key: key);

  @override
  _SlotBookingFormState createState() => _SlotBookingFormState();
}

class _SlotBookingFormState extends State<SlotBookingForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please log in to book a slot')));
        return;
      }

      try {
        await FirebaseFirestore.instance.collection('bloodtests').add({
          'userId': uid,
          'name': _nameController.text,
          'phone': _phoneController.text,
          'email': _emailController.text,
          'address': _addressController.text,
          'pinCode': _pinCodeController.text,
          'date': _dateController.text,
          'time': _timeController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        _showConfirmationDialog();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to book slot')));
        print('Error: $error');
      }
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Confirmed'),
          content: Text('Your slot is confirmed. We will contact you shortly.'),
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
    controller: _addressController,
    decoration: InputDecoration(
    labelText: 'Address',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.home),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your address';
    }
    return null;
    },
    ),
    SizedBox(height: 16.0),
    TextFormField(
    controller: _pinCodeController,
    decoration: InputDecoration(
    labelText: 'Pin Code',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.pin),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your pin code';
    }
    return null;
    },
    ),
    SizedBox(height: 16.0),
    TextFormField(
    controller: _dateController,
    decoration: InputDecoration(
    labelText: 'Slot Date',
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
    return 'Please select a slot date';
    }
    return null;
    },
    readOnly: true,
    ),
    SizedBox(height: 16.0),
    TextFormField(
    controller: _timeController,
    decoration: InputDecoration(
    labelText: 'Slot Time',
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
    return 'Please select a slot time';
    }
    return null;
    },
    readOnly: true,
    ),
    SizedBox(height: 32.0),
    ElevatedButton(
    onPressed: _submitForm,
    style: ElevatedButton.styleFrom(
    primary: AppColors.purpleColor,
    padding: EdgeInsets.symmetric(vertical: 16.0),
    shape   : RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Reduced border radius
    ),
    ),
    child: Text(
    'Book Slot',
    style: TextStyle(
    fontSize: 16.0,
    color: Colors.black, // Changed text color to black
    ),
    ),
    ),
    ],
    ),
    );
  }
}

