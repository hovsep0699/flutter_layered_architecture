import 'package:core/providers/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/services/app_localization.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late Locale _currentLocale;

  @override
  void initState() {
    _currentLocale = AppLocalizationProvider.instance.locale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizationProvider languageLoader =
        Provider.of<AppLocalizationProvider>(context);
    _currentLocale = languageLoader.locale;
    return DropdownButton<Locale>(
        // value: _currentLocale,
        alignment: AlignmentDirectional.bottomEnd,
        padding: const EdgeInsets.only(right: 5),
        icon: Icon(
          Icons.language,
          color: _currentLocale.languageCode == 'en'
              ? Colors.white
              : _currentLocale.languageCode == 'ru'
                  ? Colors.red
                  : Colors.blue,
        ),
        iconSize: 30,
        onChanged: (Locale? loc) {},
        items: AppLocalizationService.delegate.supportedLocales
            .map<DropdownMenuItem<Locale>>((Locale loc) {
          return DropdownMenuItem(
              value: loc,
              onTap: () async {
                await languageLoader.setLocale(loc);
                if (context.mounted) {
                  await AppLocalizationService.of(context)?.load(loc);
                }
                setState(() {
                  _currentLocale = loc;
                });
              },
              enabled: true,
              child: Text(loc.toString()));
        }).toList());
  }
}
