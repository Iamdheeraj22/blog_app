import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class UserProfileErrorView extends StatelessWidget {
  const UserProfileErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppPallete.borderColor,
        border: Border.all(color: AppPallete.backgroundColor),
      ),
      child: Icon(
        Icons.person,
        color: AppPallete.whiteColor,
        size: 30,
      ),
    );
  }
}
