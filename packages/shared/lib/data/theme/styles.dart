library shared;

import 'package:shared/data/theme/colors.dart';
import 'package:shared/data/theme/fonts.dart';
import 'package:flutter/material.dart';

const TextStyle defaultToolbarTextStyle =
    TextStyle(color: defaultAppBarTextColor);

const TextStyle defaultSmallTextStyle = TextStyle(
    height: 2,
    fontSize: defaultSmallTextFontSize,
    fontFamily: defaultSmallTextFontFamily,
    fontWeight: defaultSmallTextFontWeight,
    decorationThickness: defaultTextSmallDecorationThickness);

const TextStyle defaultMediumTextStyle = TextStyle(
    fontSize: defaultMediumTextFontSize,
    fontFamily: defaultMediumTextFontFamily,
    fontWeight: defaultMediumTextFontWeight,
    decorationThickness: defaultTextMediumDecorationThickness);

const TextStyle defaultSignFieldTextStyle = TextStyle(
    fontSize: defaultSignFieldTextFontSize,
    height: defaultSignFieldTextLineHeight,
    fontWeight: defaultSignFieldFontWeight);

const TextStyle defaultSignButtonTextStyle = TextStyle(color: Colors.white);

const TextStyle defaultSignInputHintStyle =
    TextStyle(color: defaultSignInputHintTextColor);

const bool defaultAppBarCenterTitle = true;
