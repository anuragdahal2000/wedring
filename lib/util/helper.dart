import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wedring/models/user.dart';
import 'package:wedring/util/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? get context => navigatorKey.currentContext;

  static Future<void> setUserDetails(String userResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", userResponse);
  }

  static Future<User> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("user") == null) {
      throw Exception("User not found");
    }
    return User.fromJson(jsonDecode(prefs.getString("user")!));
  }

  static Future<void> clearUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }

  static Future<void> setTokens(String tokensResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tokens", tokensResponse);
  }

  static Future<Tokens> getTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("tokens") == null) {
      throw Exception("Tokens not found");
    }
    return Tokens.fromJson(jsonDecode(prefs.getString("tokens") ?? "{}"));
  }
}

enum SnackType { success, error, warning, info }

Color getSnackBarBgColor(SnackType? type) {
  switch (type) {
    case SnackType.success:
      return kStateColorCompleted;
    case SnackType.error:
      return kStateColorError;
    case SnackType.warning:
      return kStateColorWarning;
    case SnackType.info:
      return kStateColorInfo;
    default:
      return kTeritary1;
  }
}

void showSnackBar(String text, {SnackType? type}) {
  ScaffoldMessenger.of(AppManager.navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: getSnackBarBgColor(type),
    ),
  );
}
