import 'package:chat360/Configs/app_constants.dart';
import 'package:flutter/services.dart';

setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness:
          isDarkIconsinStatusBar ? Brightness.dark : Brightness.light));
}
