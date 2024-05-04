import 'package:findatimeplease/src/globals/app_env.dart';
import 'package:findatimeplease/src/locator/locator.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

Future<void> main() async {
  await setupLocator(AppEnv.prod);
  runApp(const App());
}
