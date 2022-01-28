import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
);

class StaticValues {
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets fullPadding = EdgeInsets.symmetric(horizontal: 24);
  static BorderRadius circularBorderRadius = BorderRadius.circular(8);
  static Color greyedWhite = Colors.white24;
}