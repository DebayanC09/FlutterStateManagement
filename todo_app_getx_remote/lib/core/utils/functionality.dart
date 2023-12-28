import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entity/user_entity.dart';
import 'constants.dart';
import '../../data/models/user_model.dart';

void showToast({required String? message}) {
  Fluttertoast.showToast(msg: message ?? "");
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Map<String, dynamic> getArguments({required BuildContext context}) {
  return ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
}

setUserData({required UserEntity? user}) async {
  final prefs = await SharedPreferences.getInstance();
  if (user != null) {
    String data = jsonEncode(user);
    prefs.setString(Constants.user, data);
  } else {
    prefs.setString(Constants.user, "");
  }
}

Future<UserEntity?> getUserData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(Constants.user);
    if (value != null) {
      Map<String, dynamic> map = jsonDecode(value) as Map<String, dynamic>;
      UserEntity user = UserModel.fromJson(map);
      return user;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<bool> updateToken({required String token}) async {
  UserEntity? user = await getUserData();
  if (user != null) {
    user.token = token;
    await setUserData(user: user);
    return true;
  } else {
    return false;
  }
}
