import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared/assetsGen/assets.gen.dart';
import 'package:path/path.dart' as path;
// import 'package:core/providers/localization_provider.dart';

class AppLocalizationService {
  String package;
  Locale locale;
  AppLocalizationService(
      {this.package = 'shared', this.locale = const Locale('en')});
  Map<String, String> _localizedString = {};

  // static AppLocalizationService get instance => AppLocalizationService(package: "packages/shared", locale: await );

  Future<bool> load(Locale locale) async {
    String jsonStr = await rootBundle.loadString(_switchLocale(locale));
    Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    _localizedString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String _switchLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        {
          locale = const Locale('en');
          return path.join(package, AppAssets.localization.appEn);
        }

      case 'hy':
        {
          locale = const Locale('hy');
          return path.join(package, AppAssets.localization.appHy);
        }
      case 'ru':
        {
          locale = const Locale('ru');
          return path.join(package, AppAssets.localization.appRu);
        }

      default:
        {
          locale = const Locale('en');
          return path.join(package, AppAssets.localization.appEn);
        }
    }
  }

  static AppLocalizationService? of(BuildContext context) {
    return Localizations.of<AppLocalizationService>(
        context, AppLocalizationService);
  }

  static AppLocalizationServiceDelegate get delegate =>
      const AppLocalizationServiceDelegate();

  String translate(String key) {
    return _localizedString[key] ?? key;
  }
}

class AppLocalizationServiceDelegate
    extends LocalizationsDelegate<AppLocalizationService> {
  const AppLocalizationServiceDelegate();
  // final

  // get current => _localizations;
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hy'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizationService> load(Locale locale) async {
    AppLocalizationService localizations =
        AppLocalizationService(package: "packages/shared", locale: locale);
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationServiceDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
