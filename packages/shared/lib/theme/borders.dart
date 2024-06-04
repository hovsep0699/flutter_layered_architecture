library shared;

import 'package:shared/theme/colors.dart';
import 'package:flutter/material.dart';


const BorderRadiusGeometry defaultAppBarBorderRadius = BorderRadius.vertical(
    top: defaultAppBarTopBorderRadius,
    bottom: defaultAppBarBottomBorderRadius
);

const ShapeBorder defaultAppBarShape = ContinuousRectangleBorder(
    borderRadius: defaultAppBarBorderRadius
);

const BorderSide defaultCardBorderSide = BorderSide(
  color: defaultCardBorderSideColor,
);

const List<BoxShadow> defaultInfoShadows = <BoxShadow>[
  BoxShadow(
      offset: defaultInfoShadowsOffset,
      color: defaultInfoShadowsColor,
      blurRadius: defaultInfoShadowsBlurRadius)
];

const Radius defaultSearchBarRadius = Radius.circular(25);

const Radius defaultAppBarTopBorderRadius = Radius.zero;

const Radius defaultAppBarBottomBorderRadius = Radius.circular(24);

const Offset defaultInfoShadowsOffset =  Offset(0, 15);

const double defaultInfoShadowsBlurRadius = 8;

const double defaultCardItemBorderRadius = 8;

const double defaultInfoListBorderRadius = 8;

const double defaultCardItemBlurRadius = 8;

const double defaultCardShapeBorderRadius = 8;
