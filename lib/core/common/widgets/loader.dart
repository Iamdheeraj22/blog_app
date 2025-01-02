import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
      child: const Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: CircularProgressIndicator(
            color: AppPallete.gradient1,
          ),
        ),
      ),
    );
  }
}
