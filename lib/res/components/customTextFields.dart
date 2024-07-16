import '../../conts/consts.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textController;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.hint,
    required this.textController,
    this.obscureText = false,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}



