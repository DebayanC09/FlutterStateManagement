import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/colors.dart';

class AppTheme {
  static SystemUiOverlayStyle get appBarLight {
    return const SystemUiOverlayStyle(
      statusBarColor: Color(
        AppColors.colorWhite,
      ),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );
  }

  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: const Color(
        AppColors.colorWhite,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(
          AppColors.colorPrimary,
        ),
        secondary: const Color(
          AppColors.colorPrimary,
        ), // accent color
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Color(AppColors.colorPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(AppColors.colorPrimary),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(AppColors.colorPrimary),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(AppColors.colorPrimary),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor: Color(
            AppColors.colorPrimary,
          )),
      dialogTheme: const DialogTheme(
        backgroundColor: Color(AppColors.colorWhite)
      )
    );
  }

  static void statusBarLight() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(
          AppColors.colorWhite,
        ),
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
