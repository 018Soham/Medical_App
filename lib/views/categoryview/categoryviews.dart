// import 'package:flutter/material.dart';
// import 'package:medical/views/categoryview/surgery_doctors_list.dart';
// import '../../conts/consts.dart';
// import 'dental_list.dart';
// import 'dermatologyList.dart';
// import 'medicine_doctors_list.dart';
// import 'mentalhealth_list.dart';
// import 'orthopedic_list.dart';
//
// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Categories'),
//         backgroundColor: AppColors.purpleColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16.0,
//             mainAxisSpacing: 16.0,
//           ),
//           itemCount: categoryItems.length,
//           itemBuilder: (context, index) {
//             return buildCategoryItem(context, categoryItems[index]);
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildCategoryItem(BuildContext context, Map<String, String> category) {
//     return GestureDetector(
//       onTap: () {
//         navigateToDoctorDetailsScreen(context, category['name']);
//       },
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               category['image']!,
//               width: 80,
//               height: 80,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 8),
//             Text(
//               category['name']!,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void navigateToDoctorDetailsScreen(BuildContext context, String? categoryName) {
//     switch (categoryName) {
//       case 'Medicine':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MedicineDoctorsDetailsScreen(),
//           ),
//         );
//         break;
//       case 'Surgery':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SurgeryDoctorsDetailsScreen(),
//           ),
//         );
//         break;
//       case 'Orthopedic':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OrthopedicDoctorsDetailsScreen(),
//           ),
//         );
//         break;
//       case 'Dental':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DentalDoctorsDetailsScreen(),
//           ),
//         );
//         break;
//       case 'Mental Health':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => MentalHealthDoctorsDetailsScreen(),
//           ),
//         );
//         break;
//       case 'Dermatology':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DermatologyDoctorDetailsScreen(),
//           ),
//         );
//         break;
//       default:
//       // Handle default case
//         break;
//     }
//   }
// }
//
// const List<Map<String, String>> categoryItems = [
//   {'name': 'Medicine', 'image': 'assets/images/Medicine.png'},
//   {'name': 'Surgery', 'image': 'assets/images/Surgery.png'},
//   {'name': 'Orthopedic', 'image': 'assets/images/Orthopedic.png'},
//   {'name': 'Dental', 'image': 'assets/images/Dental.png'},
//   {'name': 'Mental Health', 'image': 'assets/images/Mental_health.png'},
//   {'name': 'Dermatology', 'image': 'assets/images/Dermatology.png'},
// ];
import 'package:flutter/material.dart';
import 'package:medical/views/categoryview/surgery_doctors_list.dart';
import '../../conts/consts.dart';
import 'dental_list.dart';
import 'dermatologyList.dart';
import 'medicine_doctors_list.dart';
import 'mentalhealth_list.dart';
import 'orthopedic_list.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            return buildCategoryItem(context, categoryItems[index]);
          },
        ),
      ),
    );
  }

  Widget buildCategoryItem(BuildContext context, Map<String, String> category) {
    return GestureDetector(
      onTap: () {
        navigateToDoctorDetailsScreen(context, category['name']);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              category['image']!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              category['name']!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void navigateToDoctorDetailsScreen(BuildContext context, String? categoryName) {
    switch (categoryName) {
      case 'Medicine':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicineDoctorsDetailsScreen(),
          ),
        );
        break;
      case 'Surgery':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurgeryDoctorsDetailsScreen(),
          ),
        );
        break;
      case 'Orthopedic':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrthopedicDoctorsDetailsScreen(),
          ),
        );
        break;
      case 'Dental':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DentalDoctorsDetailsScreen(),
          ),
        );
        break;
      case 'Mental Health':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MentalHealthDoctorsDetailsScreen(),
          ),
        );
        break;
      case 'Dermatology':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DermatologyDoctorDetailsScreen(),
          ),
        );
        break;
      default:
      // Handle default case
        break;
    }
  }
}

const List<Map<String, String>> categoryItems = [
  {'name': 'Medicine', 'image': 'assets/images/Medicine.png'},
  {'name': 'Surgery', 'image': 'assets/images/Surgery.png'},
  {'name': 'Orthopedic', 'image': 'assets/images/Orthopedic.png'},
  {'name': 'Dental', 'image': 'assets/images/Dental.png'},
  {'name': 'Mental Health', 'image': 'assets/images/Mental_health.png'},
  {'name': 'Dermatology', 'image': 'assets/images/Dermatology.png'},
];
