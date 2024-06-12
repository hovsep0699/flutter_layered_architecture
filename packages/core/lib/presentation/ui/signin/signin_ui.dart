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
            preferredSize: defaultSignInAppBarSize,
            child: AppBar(
              toolbarTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
              centerTitle: true,
              title: const Text("Sign In",
                  style: TextStyle(color: defaultAppBarTextColor)),
            )),
        body: SingleChildScrollView(
            child: Padding(
                padding: defaultSignInBodyPadding,
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: defaultSignInBodyAlignment,
                    children: [
                      MockAssets.images.loginCont.svg(
                        package: 'core',
                        width: defaultSignInContentSVGSize,
                        height: defaultSignInContentSVGSize,
                      )
                    ],
                  ),
                  const Padding(
                      padding: defaultSignInContainerPadding,
                      child: SignInForm()),
                ]))));
  }
}
