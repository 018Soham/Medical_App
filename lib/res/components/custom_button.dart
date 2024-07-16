// import 'package:flutter/material.dart';
//
// class CustomButton extends StatelessWidget {
//   final VoidCallback? onTap;
//   final String buttonText;
//
//   const CustomButton({super.key, required this.buttonText, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 50,
//       margin: const EdgeInsets.only(top: 10),
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//
//           foregroundColor: Colors.white, shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Text(buttonText),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;

  const CustomButton({super.key, required this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: purpleColor, // Use purpleColor as the background color
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}

// Define the purpleColor constant
const Color purpleColor = Colors.deepPurple;
