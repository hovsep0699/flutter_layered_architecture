import 'package:app/presentation/route_service.dart';
import 'package:core/domain/auth/service/auth_service.dart';
import 'package:core/domain/auth/bloc/auth_bloc.dart';
import 'package:core/domain/auth/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared/data/services/app_localization.dart';
import 'package:shared/shared.dart';
import 'package:core/presentation/providers/localization_provider.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

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
                onGenerateRoute: RouteService.onGenerateRoute,
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
