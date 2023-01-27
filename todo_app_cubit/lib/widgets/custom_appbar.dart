import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';

class CustomAppBar extends AppBar {
  final String titleText;

  CustomAppBar({super.key, this.titleText = ""})
      : super(
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color(AppColors.colorWhite),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    title: Text(
      titleText,
      style: const TextStyle(
        color: Color(AppColors.colorBlack),
      ),
    ),
    backgroundColor: const Color(AppColors.colorTransparent),
    iconTheme: const IconThemeData(
      color: Color(AppColors.colorBlack),
    ),
  );
}
