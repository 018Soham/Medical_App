import 'package:flutter/material.dart';
import '../../conts/consts.dart';

class CustomTextFieldWithHint extends StatelessWidget {
  final String hint;
  final TextEditingController textController;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const CustomTextFieldWithHint({
    Key? key,
    required this.hint,
    required this.textController,
    this.obscureText = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: AppColors.bgDarkColor, // Use the color from consts.dart
      ),
    );
  }
}
