import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocal {
  Locale locale;
  late Map<String, String> _loadedLocalizedValues;

  AppLocal(this.locale);

  static AppLocal of(BuildContext context) {
    return Localizations.of(context, AppLocal);
  }

  Future loadlanguage() async {
    String _langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');

    Map<String, dynamic> _loadedValue = jsonDecode(_langFile);

    _loadedLocalizedValues = _loadedValue.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslated(String key) {
    return _loadedLocalizedValues[key]!;
  }

  static const LocalizationsDelegate<AppLocal> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocal> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar","fr"].contains(locale.languageCode);
  }

  @override
  Future<AppLocal> load(Locale locale) async {
    AppLocal appLocal = AppLocal(locale);
    await appLocal.loadlanguage();
    return appLocal;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocal> old) {
    return false;
  }
}
