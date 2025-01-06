import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ProfileItemView extends StatelessWidget {
  const ProfileItemView({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
