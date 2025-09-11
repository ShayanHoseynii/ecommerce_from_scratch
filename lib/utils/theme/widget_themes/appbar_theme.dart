import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TAppBarTheme{
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.black, size: 18.0),
    actionsIconTheme: IconThemeData(color: TColors.black, size: 18.0),
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: TColors.black),

  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.white, size: 18.0),
    actionsIconTheme: IconThemeData(color: TColors.white, size: 18.0),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: TColors.white),
  );
}