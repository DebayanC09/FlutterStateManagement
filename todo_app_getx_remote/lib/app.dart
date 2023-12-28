import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/config/routes/app_routes.dart';
import 'package:todo_app_getx/presentation/binding/all_bindings.dart';

import 'config/themes/app_theme.dart';
import 'presentation/views/splash/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppTheme.statusBarLight();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AllBindings(),
      initialRoute: SplashScreen.name,
      theme: AppTheme.light,
      getPages: AppRoutes.pages(),
    );
  }
}
