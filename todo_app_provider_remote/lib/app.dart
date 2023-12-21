import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'di/injector.dart';
import 'presentation/providers/todo/todo_list_provider.dart';
import 'presentation/views/splash/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppInjector.getIt<TodoListProvider>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.name,
        theme: AppTheme.light,
        routes: AppRoutes.routes(),
      ),
    );
  }
}
