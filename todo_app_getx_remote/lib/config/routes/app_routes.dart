import 'package:get/get.dart';
import 'package:todo_app_getx/presentation/binding/add_edit_todo_binding.dart';
import 'package:todo_app_getx/presentation/binding/login_binding.dart';
import 'package:todo_app_getx/presentation/binding/sign_up_binding.dart';
import 'package:todo_app_getx/presentation/binding/todo_list_binding.dart';

import '../../presentation/views/login/login_screen.dart';
import '../../presentation/views/signup/signup_screen.dart';
import '../../presentation/views/splash/splash_screen.dart';
import '../../presentation/views/todo/add_edit_todo_screen.dart';
import '../../presentation/views/todo/todo_list_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> pages() {
    return [
      GetPage(
        name: SplashScreen.name,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: LoginScreen.name,
        page: () => const LoginScreen(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: SignUpScreen.name,
        page: () => const SignUpScreen(),
        binding: SignUpBinding(),
      ),
      GetPage(
        name: TodoListScreen.name,
        page: () => const TodoListScreen(),
        binding: TodoListBinding(),
      ),
      GetPage(
        name: AddEditTodoScreen.name,
        page: () => const AddEditTodoScreen(),
        binding: AddEditTodoBinding(),
      ),
    ];
  }
}
