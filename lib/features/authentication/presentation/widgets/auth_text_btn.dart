import 'package:flutter/material.dart';

class AuthTextBtn extends StatelessWidget {
  const AuthTextBtn({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
