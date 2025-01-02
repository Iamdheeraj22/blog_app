import 'package:flutter/material.dart';

class AuthFieldView extends StatelessWidget {
  const AuthFieldView({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText cannot be empty';
        }
        return null;
      },
    );
  }
}
