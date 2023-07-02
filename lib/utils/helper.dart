import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

class AppManager {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? get context => navigatorKey.currentContext;
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
