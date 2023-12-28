import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';


class CustomText extends StatelessWidget {

  final String text;
  final int color;
  final FontWeight fontWeight;

  const CustomText({
    required this.text,
    this.color = AppColors.colorBlack,
    this.fontWeight = FontWeight.normal,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Color(color),
          fontSize: 16,
          fontWeight: fontWeight),
    );
  }
}
