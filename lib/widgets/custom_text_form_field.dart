import 'package:chatting_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.obscureText = false,
    super.key,
    this.validator,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.controller,
  });
  final Function(String)? onChanged;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: kCardColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: kHelperTextColor, size: 22)
            : null,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBorderColor),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kAccentColor, width: 1.5),
          borderRadius: BorderRadius.circular(24),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          borderRadius: BorderRadius.circular(24),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: kHelperTextColor, fontSize: 14),
        hintText: hintText,
        hintStyle: const TextStyle(color: kHelperTextColor, fontSize: 14),
      ),
    );
  }
}
