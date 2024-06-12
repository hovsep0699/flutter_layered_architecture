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

const TextStyle defaultAlertTextStyle = TextStyle(
    fontFamily: defaultMediumTextFontFamily,
    fontSize: defaultAlertTextFontSize,
    fontWeight: defaultMediumTextFontWeight,
    color: defaultTextColor);

const TextStyle defaultSignFieldTextStyle = TextStyle(
    fontSize: defaultSignFieldTextFontSize,
    height: defaultSignFieldTextLineHeight,
    fontWeight: defaultSignFieldFontWeight);

const TextStyle defaultAlertButtonTextStyle = TextStyle(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(16, 112, 255, 1));

const TextStyle defaultSignButtonTextStyle = TextStyle(color: Colors.white);

const TextStyle defaultSignInputHintStyle =
    TextStyle(color: defaultSignInputHintTextColor);

const bool defaultAppBarCenterTitle = true;
