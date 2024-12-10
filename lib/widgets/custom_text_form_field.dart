import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.obscureText = false,
    super.key,
    this.validator,
    required this.onChanged,
    required this.labelText,
  });
  final Function(String) onChanged;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 155, 165, 244)),
          ),
          border: const OutlineInputBorder(),
          labelText: labelText,
          focusColor: const Color.fromARGB(8, 255, 255, 255),
          labelStyle: const TextStyle(color: Colors.white)),
    );
  }
}
