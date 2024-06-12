import 'package:core/domain/auth/bloc/auth.dart';
import 'package:core/domain/auth/bloc/auth_event.dart';
import 'package:core/domain/auth/bloc/auth_state.dart';
import 'package:core/presentation/ui/dialogs/dialog.dart';
import 'package:core/presentation/ui/signin/obsecure_text_field.dart';
import 'package:core/presentation/ui/signin/signin_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/data/theme/alignments.dart';
import 'package:shared/data/theme/colors.dart';
import 'package:shared/data/theme/sizes.dart';
import 'package:shared/data/theme/styles.dart';

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
              DialogService.showErrorDialog(context, state.message!);
            } else if (state.status == AuthStatus.manyTried) {
              DialogService.showErrorDialogWarning(context, state.message!);
            } else if (state.status == AuthStatus.authenticated) {
              Navigator.of(context).pushReplacementNamed('/');
            }
          });
          // do stuff here based on BlocA's state
        },
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: defaultSignFormFieldsColumnAlignment,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: defaultSignFormFieldsRowAlignment,
                          children: [
                            Text(
                              'Phone Number',
                              style: defaultSignFieldTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultSignFieldInputMarginTop),
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
                  const SizedBox(height: defaultSignFieldSpaceBetween),
                  const Row(
                    mainAxisAlignment: defaultSignFormFieldsRowAlignment,
                    children: [
                      Text('Password', style: defaultSignFieldTextStyle),
                    ],
                  ),
                  const SizedBox(height: defaultSignFieldInputMarginTop),
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
                  const SizedBox(height: defaultSignButtonMarginTop),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            defaultSignButtonColor),
                        minimumSize: WidgetStateProperty.all<Size>(
                            defaultSignButtonSize)),
                    onPressed: _isUsernameValid && _isPasswordValid
                        ? () {
                            provider.add(AuthLogin(
                                username: _usernameKey.currentState!.value,
                                password: _passwordKey.currentState!.value));
                          }
                        : null,
                    child: const Text(
                      "Sign In",
                      style: defaultSignButtonTextStyle,
                    ),
                  )
                ])));
  }
}
