import 'package:blog_app/core/common/widgets/button.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({
    super.key,
    required this.onLogout,
  });

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppPallete.backgroundColor,
      title: Center(
        child: Text(
          'See you soon!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            'You are about to logout from the app.\nAre you sure this is what\nyou want?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              Button(
                onPressed: onLogout,
                title: 'Confirm logout',
                color: AppPallete.gradient1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
