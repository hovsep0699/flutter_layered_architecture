import 'package:core/assetsGen/assets.gen.dart';
import 'package:core/presentation/ui/signin/signin_form.dart';
import 'package:flutter/material.dart';
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
              title: const Text("Sign In",
                  style: TextStyle(color: defaultAppBarTextColor)),
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
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 35, horizontal: 16),
                          child: SignInForm()),
                    ]))));
  }
}
