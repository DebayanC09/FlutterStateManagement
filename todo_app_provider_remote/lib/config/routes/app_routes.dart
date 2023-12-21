import 'package:flutter/material.dart';
import '../../presentation/views/login/login_screen.dart';
import '../../presentation/views/signup/signup_screen.dart';
import '../../presentation/views/splash/splash_screen.dart';
import '../../presentation/views/todo/add_edit_todo_screen.dart';
import '../../presentation/views/todo/todo_list_screen.dart';

class AppRoutes{
  static Map<String, WidgetBuilder> routes() {
    return {
      SplashScreen.name: (context) => const SplashScreen(),
      LoginScreen.name: (context) => const LoginScreen(),
      SignUpScreen.name: (context) => const SignUpScreen(),
      TodoListScreen.name: (context) => const TodoListScreen(),
      AddEditTodoScreen.name: (context) => const AddEditTodoScreen(),
    };
  }
}