library shared;


import 'package:shared/theme/colors.dart';
import 'package:shared/theme/fonts.dart';
import 'package:flutter/material.dart';

const TextStyle defaultToolbarTextStyle = TextStyle(
    color: defaultAppBarTextColor
);

const TextStyle defaultSmallTextStyle = TextStyle(
    height: 2,
    fontSize: defaultSmallTextFontSize,
    fontFamily: defaultSmallTextFontFamily,
    fontWeight: defaultSmallTextFontWeight,
    decorationThickness: defaultTextSmallDecorationThickness
);

const TextStyle defaultMediumTextStyle = TextStyle(
    fontSize: defaultMediumTextFontSize,
    fontFamily: defaultMediumTextFontFamily,
    fontWeight: defaultMediumTextFontWeight,
    decorationThickness: defaultTextMediumDecorationThickness
);

const CrossAxisAlignment defaultCardContentAlignment = CrossAxisAlignment.start;

const bool defaultAppBarCenterTitle = true;