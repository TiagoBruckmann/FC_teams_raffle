// import dos pacotes nativos do flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

// import dos pacotes
import 'package:flutter_i18n/flutter_i18n.dart';

const Iterable<Locale> supportedLocale = [
  Locale("en", "US"),
  Locale("pt", "BR"),
  Locale("pt", "PT"),
];

final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegate = [
  const MaterialLocalisationsDelegate(),
  const CupertinoLocalisationsDelegate(),
  FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      basePath: "assets/languages",
      fallbackFile: ( Platform.localeName == "pt_BR" )
          ? "pt_BR"
          : "en_US",
    ),
  ),
];

class MaterialLocalisationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const MaterialLocalisationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return true;
  }
  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return DefaultMaterialLocalizations.load(locale);
  }
  @override
  bool shouldReload(MaterialLocalisationsDelegate old) {
    return false;
  }
}

class CupertinoLocalisationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const CupertinoLocalisationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return true;
  }
  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(locale);
  }
  @override
  bool shouldReload(CupertinoLocalisationsDelegate old) {
    return false;
  }
}