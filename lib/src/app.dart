import 'package:findatimeplease/src/starting_page.dart';
import 'package:findatimeplease/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appThemeLight,
      home: const StartingPage(),
    );
  }
}
