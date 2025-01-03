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
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppPallete.borderColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppPallete.whiteColor,
                fontSize: 14,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppPallete.whiteColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/*
* ListTile(
      onTap: onTap,
      tileColor: AppPallete.borderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.only(right: 10, left: 10),
      title: Text(
        title,
        style: TextStyle(
          color: AppPallete.whiteColor,
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppPallete.whiteColor,
      ),
    );
* */
