import 'package:findatimeplease/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

final appOutlinedButtonThemeLight = OutlinedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return null;
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.red;
        }
        return null;
      },
    ),
    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appButtonRadius),
        side: const BorderSide(width: 4.0),
      ),
    ),
    minimumSize: MaterialStateProperty.all(
      const Size(
        double.infinity,
        appButtonHeight,
      ),
    ),
  ),
);
