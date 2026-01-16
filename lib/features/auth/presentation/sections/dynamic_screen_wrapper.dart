import 'package:flutter/material.dart';

class DynamicScreenWrapper extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;

  const DynamicScreenWrapper({
    super.key,
    required this.child,
    this.horizontalPadding = 16,
    this.verticalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
