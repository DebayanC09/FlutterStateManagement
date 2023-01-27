import 'package:flutter/material.dart';
import 'package:todo_app_cubit/utils/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final int color;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.all(0.0),
    this.color = AppColors.colorBlack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: TextStyle(
            color: Color(color),
          ),
        ),
      ),
    );
  }
}
