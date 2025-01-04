import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    this.radius = 6,
    required this.title,
    this.color = AppPallete.backgroundColor,
    this.textColor = AppPallete.whiteColor,
  });

  final VoidCallback onPressed;
  final double radius;
  final String title;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: 35, maxHeight: 40, minWidth: 100, maxWidth: 120),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: color,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: FittedBox(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: AppPallete.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
