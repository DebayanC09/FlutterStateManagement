import 'package:flutter/material.dart';
import 'package:todo_app_provider/di/injector.dart';

import 'app.dart';

void main() async{
  await AppInjector.setup();
  runApp(const MyApp());
}
