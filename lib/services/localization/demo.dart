import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'language_constants.dart';

class DemoLocalization {
  final Locale locale;

  DemoLocalization(this.locale);

  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  late Map<String, String> localizedValues;

  Future<dynamic> load() async {
    String jsonStringValues = await rootBundle
        .loadString('lib/app/translations/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return localizedValues[key];
  }

  static LocalizationsDelegate<DemoLocalization> delegate =
      DemoLocalizationsDelegate();
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  @override
  bool isSupported(Locale locale) {
    return languageList.contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) => false;
}
