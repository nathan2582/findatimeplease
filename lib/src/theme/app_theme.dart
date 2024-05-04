import 'package:findatimeplease/src/theme/app_elevated_button_theme.dart';
import 'package:findatimeplease/src/theme/app_outlined_button_theme.dart';
import 'package:flutter/material.dart';

const double appBorderRadius = 12;
const double appButtonRadius = 8;
const double appButtonHeight = 56;
final appThemeLight = ThemeData(
  brightness: Brightness.light,
  elevatedButtonTheme: appElevatedButtonTheme,
  outlinedButtonTheme: appOutlinedButtonThemeLight,
  colorSchemeSeed: const Color(0xFF39816D),
);

const primarySwatch = MaterialColor(
  0xFF39816D,
  <int, Color>{
    50: Color(0xFFE0F4F0),
    100: Color(0xFFB3E3D9),
    200: Color(0xFF80D2C1),
    300: Color(0xFF4DB1A8),
    400: Color(0xFF269B94),
    500: Color(0xFF39816D),
    600: Color(0xFF2D6A54),
    700: Color(0xFF21533B),
    800: Color(0xFF153C22),
    900: Color(0xFF09250A),
  },
);
