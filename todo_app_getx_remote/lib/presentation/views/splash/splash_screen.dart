import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/asset_path.dart';
import '../../../core/utils/functionality.dart';
import '../login/login_screen.dart';
import '../todo/todo_list_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String name = "/SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      getUserData().then(
        (value) => {
          if (value != null) {
            Get.offAllNamed(TodoListScreen.name)
          } else {
            Get.offAllNamed(LoginScreen.name)
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetPaths.logo,
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
