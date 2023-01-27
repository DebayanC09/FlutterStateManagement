import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_bloc/ui/views/login/login_screen.dart';
import 'package:todo_app_bloc/ui/views/signup/signup_screen.dart';
import 'package:todo_app_bloc/ui/views/splash/splash_screen.dart';
import 'package:todo_app_bloc/ui/views/todo/add_edit_todo_screen.dart';
import 'package:todo_app_bloc/ui/views/todo/todo_list_screen.dart';
import 'package:todo_app_bloc/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.name,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(AppColors.colorWhite),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Colors.red,
          onBackground: Colors.red,
          primary: const Color(AppColors.colorPrimary),
          secondary: const Color(AppColors.colorPrimary), // accent color
        ),
      ),
      routes: {
        SplashScreen.name: (context) => const SplashScreen(),
        LoginScreen.name: (context) => const LoginScreen(),
        SignUpScreen.name: (context) => const SignUpScreen(),
        TodoListScreen.name: (context) => const TodoListScreen(),
        AddEditTodoScreen.name: (context) => const AddEditTodoScreen(),
      },
    );
  }
}
