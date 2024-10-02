// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    EdgeInsets padding = const EdgeInsets.only(left: 20),
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.visible = false,
    this.validator,
    this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final bool visible;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      validator: validator,
      obscureText: visible,
    );
  }
}
