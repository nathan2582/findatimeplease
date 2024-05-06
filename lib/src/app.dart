import 'package:findatimeplease/src/ui/components/mobile_app_pretend_wrapper.dart';
import 'package:findatimeplease/src/ui/pages/starting_page.dart';
import 'package:findatimeplease/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return PretendMobileAppWrapper(
      child: MaterialApp(
        title: 'Provider Schedule/Request Appointment',
        theme: appThemeLight,
        home: const StartingPage(),
      ),
    );
  }
}
