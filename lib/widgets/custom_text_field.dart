import 'package:chatting_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.obscureText = false,
    super.key,
    required this.onSubmitted,
    this.hintText,
  });
  final TextEditingController fieldText = TextEditingController();
  final Function(String) onSubmitted;
  final String? hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: fieldText,
      onSubmitted: (value) {
        if (fieldText.text.isNotEmpty) {
          onSubmitted(fieldText.text);
          fieldText.clear();
        }
      },
      style: const TextStyle(color: kPrimaryColor),
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (fieldText.text.isNotEmpty) {
                onSubmitted(fieldText.text);
                fieldText.clear();
              }
            },
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          border: const OutlineInputBorder(),
          hintText: hintText,
          focusColor: kPrimaryColor,
          hintStyle: const TextStyle(color: kPrimaryColor)),
    );
  }
}
