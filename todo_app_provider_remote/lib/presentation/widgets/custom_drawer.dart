import 'package:flutter/material.dart';

import '../../app.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/functionality.dart';
import '../views/login/login_screen.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

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
