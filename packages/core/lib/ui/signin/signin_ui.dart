import 'package:core/assetsGen/assets.gen.dart';
import 'package:core/providers/form_provider.dart';
import 'package:core/ui/signin/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/services/app_localization.dart';
import 'package:shared/shared.dart';

class SignInUI extends StatelessWidget {
  const SignInUI({super.key});

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
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 43),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MockAssets.images.loginCont.svg(
                            package: 'core',
                            width: 150,
                            height: 150,
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 35, horizontal: 16),
                          child: ChangeNotifierProvider(
                              create: (BuildContext context) => FormProvider(),
                              child: Consumer<FormProvider>(
                                builder: (context, provider, child) {
                                  return const SignInForm();
                                },
                              ))),
                    ]))));
  }
}
