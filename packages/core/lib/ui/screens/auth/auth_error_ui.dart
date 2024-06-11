import 'package:flutter/material.dart';
import 'package:shared/services/app_localization.dart';
import 'package:shared/shared.dart';

class AuthErrorUI extends StatelessWidget {
  const AuthErrorUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(88),
            child: AppBar(
              toolbarTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
              // toolbarHeight: 88,
              centerTitle: true,
              title: Text(
                  AppLocalizationService.of(context)?.translate('title') ??
                      "title",
                  style: const TextStyle(color: defaultAppBarTextColor)),
            )),
        body: const Center(child: Text("Auth Error")));
  }
}
