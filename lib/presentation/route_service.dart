import 'package:core/core.dart';
import 'package:core/domain/auth/auth.dart';
import 'package:core/domain/auth/bloc/auth_state.dart';
import 'package:core/presentation/ui/screens/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteService {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name!);
    String route = uri.path;
    switch (route) {
      case "/signin":
        return MaterialPageRoute(
            builder: (_) => const SignInUI(), settings: settings);
      case "/register":
        return MaterialPageRoute(
            builder: (_) => const RegisterUI(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) =>
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  switch (state.status) {
                    case AuthStatus.initial:
                      return const AuthInitialUI();
                    case AuthStatus.loading:
                      return const AuthInitialUI();
                    case AuthStatus.authenticated:
                      return const HomeUI(title: "ss");
                    case AuthStatus.unauthenticated:
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacementNamed('/signin',
                            arguments: state.copyWith());
                      });
                      return const AuthUnauthorizedUI();
                    case AuthStatus.error:
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacementNamed('/signin',
                            arguments: state.copyWith());
                      });
                      return const AuthErrorUI();
                    case AuthStatus.manyTried:
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacementNamed('/signin',
                            arguments: state.copyWith());
                      });
                      return const AuthErrorUI();
                    default:
                      return const Scaffold();
                  }
                }));
    }
  }
}
