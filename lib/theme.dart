import 'package:flutter/material.dart';
import 'utils/constants.dart';

final appTheme = ThemeData(
  primaryColor: kPrimaryColor,

  appBarTheme: const AppBarTheme(
    color: kPrimaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
    ),
  ),
);
extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
  SizedBox get phw => SizedBox(height: toDouble(), width: toDouble());
}