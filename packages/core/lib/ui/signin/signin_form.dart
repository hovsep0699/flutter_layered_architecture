import 'package:core/auth/bloc/auth_bloc.dart';
import 'package:core/auth/bloc/auth_event.dart';
import 'package:core/providers/form_provider.dart';
import 'package:core/ui/signin/obsecure_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});
  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _usernameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<ObscureTextFieldState> _usernameStateKey =
      GlobalKey<ObscureTextFieldState>();
  final GlobalKey<ObscureTextFieldState> _passwordStateKey =
      GlobalKey<ObscureTextFieldState>();

  String? errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    errorMessage = ModalRoute.of(context)?.settings.arguments as String?;
    if (errorMessage != null) {
      Future.microtask(() => _showErrorDialog(context, errorMessage!));
    }
  }

  void _showErrorDialog(BuildContext context, String errMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) {
                setState(() {
                  errorMessage = null;
                });
              }
            },
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              titleTextStyle: const TextStyle(
                  fontFamily: "Mardoto",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(43, 43, 56, 1)),
              title: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 270),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(top: 19),
                                  child: Text(
                                    'Սխալ Մուտքային Տվյալներ',
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(errMsg,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ],
                          )),
                      const Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Divider(thickness: 0.5)),
                    ],
                  )),
              actions: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 11, horizontal: 0.5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signin');
                      },
                      child: const Text('Փորձել կրկին',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.42,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(16, 112, 255, 1))),
                    ))
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final FormProvider provider = Provider.of<FormProvider>(context);
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.17,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ObscureTextField(
                    key: _usernameStateKey,
                    textKey: _usernameKey,
                    formKey: _formKey,
                    hintText: "Username")
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Password',
                  style: TextStyle(
                      fontSize: 16, height: 1.17, fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 6),
          ObscureTextField(
              key: _passwordStateKey,
              textKey: _passwordKey,
              formKey: _formKey,
              hintText: "Password",
              obscureText: true),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    const Color.fromARGB(255, 112, 169, 255)),
                minimumSize: WidgetStateProperty.all<Size>(
                    const Size(double.infinity, 50))),
            onPressed: provider.isValid
                ? () {
                    BlocProvider.of<AuthBloc>(context).add(LoggedIn(
                        _usernameKey.currentState?.value ?? "",
                        _passwordKey.currentState?.value ?? ""));
                    Navigator.of(context).pushReplacementNamed('/');
                  }
                : null,
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.white),
            ),
          )
        ]));
  }
}
