import 'package:flutter/material.dart';
import 'package:todo_app_bloc/main.dart';
import 'package:todo_app_bloc/ui/views/login/login_screen.dart';
import 'package:todo_app_bloc/utils/colors.dart';
import 'package:todo_app_bloc/utils/functionality.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? userName = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var user = await getUserData();
      userName = user?.name;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(AppColors.colorPrimary),
            ),
            child: Center(child: Text(userName ?? "")),
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              setUserData(user: null);
              BuildContext? context = MyApp.navigatorKey.currentContext;
              Navigator.pushNamedAndRemoveUntil(
                  context!, LoginScreen.name, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
