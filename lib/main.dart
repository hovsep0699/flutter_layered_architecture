import 'package:app/app.dart';
import 'package:core/assetsGen/assets.gen.dart';
import 'package:core/core.dart';
import 'package:core/providers/localization_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MockService.instance.loadMockData(MockAssets.json.aCardData);
  await AppLocalizationProvider.instance.loadLocale();
  // MockService.instance
  // await checkBiometrics();
  // await AppLocalization.delegate.load(const Locale('en'));
  runApp(const App());
}
