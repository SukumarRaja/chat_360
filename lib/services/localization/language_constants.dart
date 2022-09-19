import 'package:flutter/material.dart';

import 'demo.dart';
const String english = "en";

List languageList = [english];
String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.translate(key) ?? '';
}