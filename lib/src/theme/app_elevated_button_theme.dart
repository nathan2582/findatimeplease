import 'package:findatimeplease/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

final appElevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appButtonRadius),
      ),
    ),
    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
    minimumSize: MaterialStateProperty.all(
      const Size(
        double.infinity,
        appButtonHeight,
      ),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
);
