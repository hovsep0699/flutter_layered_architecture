import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  static final AppLocalizationProvider _instance = AppLocalizationProvider();

  static AppLocalizationProvider get instance => _instance;

  Future<void> loadLocaleFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _locale = Locale(prefs.getString('lang') ?? 'en');
  }

  Future<void> setLocaleToPrefs(Locale loc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', loc.languageCode);
    _locale = loc;
  }

  Future<void> loadLocale() async {
    await loadLocaleFromPrefs();
    notifyListeners();
  }

  Future<void> setLocale(Locale loc) async {
    await setLocaleToPrefs(loc);
    notifyListeners();
  }
}
