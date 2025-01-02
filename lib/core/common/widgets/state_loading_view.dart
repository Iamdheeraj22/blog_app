import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:flutter/material.dart';

class StateLoadingView extends StatelessWidget {
  const StateLoadingView({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: child,
        ),
        if (isLoading) const Center(child: Loader()),
      ],
    );
  }
}
