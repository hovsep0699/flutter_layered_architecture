import 'package:core/auth/service/auth_service.dart';
import 'package:core/ui/screens/home_ui.dart';
import 'package:core/auth/bloc/auth_bloc.dart';
import 'package:core/auth/bloc/auth_event.dart';
import 'package:core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared/services/app_localization.dart';
import 'package:shared/shared.dart';
import 'package:core/core.dart';
import 'package:core/providers/localization_provider.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
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
  } // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService(baseUrl: Config.baseURL);
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppLocalizationProvider.instance,
      child: Consumer<AppLocalizationProvider>(
        builder: (context, localizationProvider, child) {
          return BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(authService: authService)
                ..add(const AuthEvent.started()),
              child: MaterialApp(
                onGenerateRoute: _onGenerateRoute,
                locale: localizationProvider.locale,
                localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                  AppLocalizationService.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                  // GlobalL
                ],
                supportedLocales:
                    AppLocalizationService.delegate.supportedLocales,
                localeResolutionCallback: (locale, supportedLocales) {
                  // Check if the device locale is supported, if not, default to English
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                title: 'Flutter Demo',
                theme: ThemeData(
                    cardTheme: CardTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                defaultCardShapeBorderRadius),
                            side: defaultCardBorderSide),
                        color: defaultCardColor,
                        surfaceTintColor: defaultCardSurfaceTintColor),
                    textTheme: defaultTextTheme,
                    searchBarTheme: defaultSearchBarTheme,
                    appBarTheme: defaultAppBarTheme),
                // home: ,
              ));
        },
      ),
    );
  }
}
