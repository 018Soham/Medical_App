import 'package:flutter/material.dart';
import 'package:medical/conts/colors.dart';

class DentalCategoriesDetails extends StatelessWidget {
  final List<String> doctorNames = [
    'Dr. John Doe',
    'Dr. Jane Smith',
    'Dr. Michael Johnson',
    'Dr. Emily Williams',
    'Dr. David Brown',
    'Dr. Jennifer Lee',
    'Dr. Christopher Martinez',
    'Dr. Amanda Taylor',
    'Dr. Matthew Anderson',
    'Dr. Sarah Garcia'
  ];

   DentalCategoriesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        title: Text('Dental Doctors'),
      ),
      body: ListView.builder(
        itemCount: doctorNames.length,
        itemBuilder: (context, index) {
          int rating = 1 + index % 5;

          return Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: AppColors.purpleColor.withOpacity(0.15), // Set background color
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/doctor_avatar.png'), // Placeholder image
              ),
              title: Text(doctorNames[index]),
              subtitle: Row(
                children: List.generate(
                  rating,
                      (index) => Icon(Icons.star, color: Colors.amber),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
