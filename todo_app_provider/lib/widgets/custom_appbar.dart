import 'package:flutter/material.dart';
import '../utils/colors.dart';

AppBar customAppBar({String title = ""}) {
  return AppBar(
    elevation: 0,
    backgroundColor: const Color(AppColors.colorTransparent),
    title: Text(
      title,
      style: const TextStyle(
        color: Color(AppColors.colorBlack),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(AppColors.colorBlack)),
  );
}
