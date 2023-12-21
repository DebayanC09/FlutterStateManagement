import 'package:flutter/material.dart';
import '../../config/themes/app_theme.dart';
import '../../core/utils/colors.dart';

class CustomAppBar extends AppBar {
  final String titleText;

  CustomAppBar({super.key, this.titleText = ""})
      : super(
          elevation: 0,
          systemOverlayStyle: AppTheme.appBarLight,
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
