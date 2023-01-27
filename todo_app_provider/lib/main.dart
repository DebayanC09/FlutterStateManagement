import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/ui/providers/todo/todo_list_provider.dart';
import 'package:todo_app_provider/ui/views/login/login_screen.dart';
import 'package:todo_app_provider/ui/views/signup/signup_screen.dart';
import 'package:todo_app_provider/ui/views/splash/splash_screen.dart';
import 'package:todo_app_provider/ui/views/todo/add_edit_todo_screen.dart';
import 'package:todo_app_provider/ui/views/todo/todo_list_screen.dart';
import 'package:todo_app_provider/utils/colors.dart';

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
          statusBarColor: Color(AppColors.colorWhite),
          statusBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoListProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
