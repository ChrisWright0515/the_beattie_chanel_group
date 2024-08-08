import 'package:flutter/material.dart';

import '../constants.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: radialPrimarySecondary,
      ),
      child: child,
    );
  }
}
