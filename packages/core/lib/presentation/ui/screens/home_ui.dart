import 'package:core/data/mock_data/mock.dart';
import 'package:core/domain/auth/auth.dart';
import 'package:core/domain/auth/bloc/auth_event.dart';
import 'package:core/data/mock_data/mock_data.dart';
import 'package:core/domain/models/card_data/card_data.dart';
import 'package:core/presentation/ui/card/card.dart';
import 'package:core/presentation/ui/language_selector/language_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/data/services/app_localization.dart';
import 'package:shared/data/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  final String title;
  const HomeUI({super.key, required this.title});

  @override
  HomeUIState createState() => HomeUIState();
}

class HomeUIState extends State<HomeUI> {
  final MockData _mock = MockService.instance.mock;
  CardData _data = CardData(items: []);

  @override
  void initState() {
    _data = _mock.data;
    super.initState();
  }
  // HomeUI({super.key, required this.title});

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
                        TextButton(
                            onPressed: () async {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(const AuthLogout());
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context).pushReplacementNamed('/');
                              });
                            },
                            child: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ))
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
