library shared;

import 'package:shared/data/theme/borders.dart';
import 'package:shared/data/theme/colors.dart';
import 'package:shared/data/theme/paddings.dart';
import 'package:shared/data/theme/sizes.dart';
import 'package:shared/data/theme/styles.dart';
import 'package:flutter/material.dart';

const SearchBarThemeData defaultSearchBarTheme = SearchBarThemeData(
    constraints: defaultSearchBoxConstraints,
    padding: WidgetStatePropertyAll(defaultSearchPadding),
    backgroundColor: WidgetStatePropertyAll(defaultSearchBarColor),
    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
        borderRadius: BorderRadiusDirectional.all(defaultSearchBarRadius))),
    hintStyle: WidgetStatePropertyAll(TextStyle(color: defaultSearchHintColor)),
    textStyle:
        WidgetStatePropertyAll(TextStyle(color: defaultSearchBarTextColor)));

const AppBarTheme defaultAppBarTheme = AppBarTheme(
    toolbarTextStyle: defaultToolbarTextStyle,
    toolbarHeight: defaultAppBarToolbarHeight,
    backgroundColor: defaultAppBarColor,
    shape: defaultAppBarShape);

const TextTheme defaultTextTheme = TextTheme(
    bodyMedium: defaultMediumTextStyle, bodySmall: defaultSmallTextStyle);

// class DefaultTheme extends
