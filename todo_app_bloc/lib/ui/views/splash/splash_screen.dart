import 'package:flutter/material.dart';
import 'package:todo_app_bloc/ui/views/login/login_screen.dart';
import 'package:todo_app_bloc/ui/views/todo/todo_list_screen.dart';
import 'package:todo_app_bloc/utils/asset_path.dart';
import 'package:todo_app_bloc/utils/functionality.dart';

class SplashScreen extends StatefulWidget {
  static const String name = "SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      getUserData().then((value) => {
            if (value != null)
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, TodoListScreen.name, (route) => false)
              }
            else
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.name, (route) => false)
              }
          });
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
