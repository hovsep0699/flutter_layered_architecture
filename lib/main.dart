import 'package:core/assetsGen/assets.gen.dart';
import 'package:core/auth/bloc/auth_bloc.dart';
import 'package:core/auth/bloc/auth_event.dart';
import 'package:core/auth/bloc/auth_state.dart';
import 'package:core/core.dart';
import 'package:core/mock_data/mock_data.dart';
import 'package:core/providers/localization_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared/services/app_localization.dart';
import 'package:shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// final LocalAuthentication _localAuthentication = LocalAuthentication();
//
// Future<void> checkBiometrics() async {
//   bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
//   List<BiometricType> availableBiometrics = await _localAuthentication.getAvailableBiometrics();
//
//   // Check if biometric authentication is available
//   if (canCheckBiometrics) {
//     print('Available biometrics: $availableBiometrics');
//   } else {
//     print('Biometrics are not available.');
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MockService.instance.loadMockData(MockAssets.json.aCardData);
  await AppLocalizationProvider.instance.loadLocale();
  // MockService.instance
  // await checkBiometrics();
  // await AppLocalization.delegate.load(const Locale('en'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                  if (state is AuthInitial || state is AuthLoading) {
                    return Scaffold(
                      resizeToAvoidBottomInset: true,
                      appBar: PreferredSize(
                          preferredSize: const Size.fromHeight(88),
                          child: AppBar(
                            toolbarTextStyle:
                                Theme.of(context).appBarTheme.titleTextStyle,
                            // toolbarHeight: 88,
                            centerTitle: true,
                            title: Text(
                                AppLocalizationService.of(context)
                                        ?.translate('title') ??
                                    "title",
                                style: const TextStyle(
                                    color: defaultAppBarTextColor)),
                          )),
                      body: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is AuthAuthenticated) {
                    return const MyHomePage(title: "ss");
                  } else if (state is AuthUnauthenticated) {
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).pushReplacementNamed('/signin');
                    });
                    return Scaffold(
                        resizeToAvoidBottomInset: true,
                        appBar: PreferredSize(
                            preferredSize: const Size.fromHeight(88),
                            child: AppBar(
                              toolbarTextStyle:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                              // toolbarHeight: 88,
                              centerTitle: true,
                              title: Text(
                                  AppLocalizationService.of(context)
                                          ?.translate('title') ??
                                      "title",
                                  style: const TextStyle(
                                      color: defaultAppBarTextColor)),
                            )),
                        body: const Center(child: Text("Unauthorized")));
                  } else if (state is AuthError) {
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context).pushReplacementNamed('/signin',
                          arguments: state.message);
                    });
                    return Scaffold(
                        resizeToAvoidBottomInset: true,
                        appBar: PreferredSize(
                            preferredSize: const Size.fromHeight(88),
                            child: AppBar(
                              toolbarTextStyle:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                              // toolbarHeight: 88,
                              centerTitle: true,
                              title: Text(
                                  AppLocalizationService.of(context)
                                          ?.translate('title') ??
                                      "title",
                                  style: const TextStyle(
                                      color: defaultAppBarTextColor)),
                            )),
                        body: const Center(child: Text("Auth Error")));
                  }
                  return const Scaffold();
                }));
    }
  } // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppLocalizationProvider.instance,
      child: Consumer<AppLocalizationProvider>(
        builder: (context, localizationProvider, child) {
          return BlocProvider(
              create: (context) => AuthBloc()..add(AppStarted()),
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

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final MockData _mock = MockService.instance.mock;
  CardData _data = CardData(items: []);

  @override
  void initState() {
    _data = _mock.data;
    super.initState();
  }
  // MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            toolbarTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
            toolbarHeight:
                Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
            pinned: true,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            shape: Theme.of(context).appBarTheme.shape,
            title: FlexibleSpaceBar(
                centerTitle: defaultAppBarCenterTitle,
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 30),
                        Text(
                            AppLocalizationService.of(context)
                                    ?.translate('title') ??
                                "title",
                            style:
                                const TextStyle(color: defaultAppBarTextColor)),
                        const LanguageSelector(),
                      ],
                    ),
                    const SizedBox(height: defaultColumnItemHeight),
                    SearchBar(
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              _data = _mock.data;
                            } else {
                              _data = CardData(
                                  items: _mock.data.items
                                      .where((item) => item.bankName
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList());
                            }
                          });
                        },
                        padding: Theme.of(context).searchBarTheme.padding,
                        backgroundColor:
                            Theme.of(context).searchBarTheme.backgroundColor,
                        textStyle: Theme.of(context).searchBarTheme.textStyle,
                        hintStyle: Theme.of(context).searchBarTheme.hintStyle,
                        shape: Theme.of(context).searchBarTheme.shape,
                        // constraints: Theme.of(context).searchBarTheme.constraints,
                        leading: const Icon(Icons.search,
                            color: defaultSearchIconColor),
                        hintText: AppLocalizationService.of(context)
                                ?.translate('search') ??
                            'Search'),
                  ],
                ))),
        SliverList.builder(
            itemBuilder: (BuildContext cont, int index) {
              return CardUI(item: _data.items[index]);
            },
            itemCount: _data.items.length)
      ],
    ));
  }
}
