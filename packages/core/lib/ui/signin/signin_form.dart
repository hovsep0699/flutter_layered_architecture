import 'package:core/auth/bloc/auth.dart';
import 'package:core/auth/bloc/auth_event.dart';
import 'package:core/auth/bloc/auth_state.dart';
import 'package:core/ui/signin/obsecure_text_field.dart';
import 'package:core/ui/signin/signin_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatefulWidget {
  final void Function(BuildContext, String)? dialog;
  final String? errorMessage;
  const SignInForm({super.key, this.dialog, this.errorMessage});
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
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;

  late AuthBloc provider;
  void _showErrorDialogWarning(BuildContext context, String errMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Center(child: Icon(Icons.warning)),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 0.5),
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(const AuthStarted());
                    Navigator.of(context).pop();
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
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errMsg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 0.5),
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(const AuthStarted());
                    Navigator.of(context).pop();
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
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }
  // void validate

  @override
  Widget build(BuildContext context) {
    provider = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          return true;
        },
        listener: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (kDebugMode) {
              print("state: $state");
            }

            if (state.status == AuthStatus.error) {
              _showErrorDialog(context, state.message!);
            } else if (state.status == AuthStatus.manyTried) {
              _showErrorDialogWarning(context, state.message!);
            } else if (state.status == AuthStatus.authenticated) {
              Navigator.of(context).pushReplacementNamed('/');
            }
          });
          // do stuff here based on BlocA's state
        },
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                            validator: SignInService.validateUsername,
                            isValid: _isUsernameValid,
                            onFocusChanged: (bool hasFocus) {
                              if (!hasFocus) {
                                _usernameKey.currentState?.validate();
                                setState(() {
                                  _isUsernameValid =
                                      _usernameKey.currentState!.errorText ==
                                          null;
                                });
                              }
                            },
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
                              fontSize: 16,
                              height: 1.17,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ObscureTextField(
                      validator: SignInService.validatePassword,
                      key: _passwordStateKey,
                      isValid: _isPasswordValid,
                      textKey: _passwordKey,
                      formKey: _formKey,
                      onFocusChanged: (bool hasFocus) {
                        if (!hasFocus) {
                          _passwordKey.currentState?.validate();
                          // _passwordKey.currentState?.save();
                          setState(() {
                            _isPasswordValid =
                                _passwordKey.currentState!.errorText == null;
                          });
                        }
                      },
                      hintText: "Password",
                      obscureText: true),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 112, 169, 255)),
                        minimumSize: WidgetStateProperty.all<Size>(
                            const Size(double.infinity, 50))),
                    onPressed: _isUsernameValid && _isPasswordValid
                        ? () {
                            provider.add(AuthLogin(
                                username: _usernameKey.currentState!.value,
                                password: _passwordKey.currentState!.value));
                          }
                        : null,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ])));
  }
}
