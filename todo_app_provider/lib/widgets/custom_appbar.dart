import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';

AppBar customAppBar({String title = ""}) {
  return AppBar(
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
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
