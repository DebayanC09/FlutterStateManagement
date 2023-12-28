import 'package:flutter/material.dart';

class CustomFab extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onPressed;

  const CustomFab({
    super.key,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
