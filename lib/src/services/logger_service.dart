// import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/foundation.dart';

class LoggerService {
  logPageView(String pageName) {
    if (kDebugMode) {
      debugPrint('Log Page View. $pageName');
    } else {
      debugPrint('yeah, we gotta shove this into the database');
    }
  }

  logButtonTap({
    required String currentRoutePath,
    required String buttonText,
  }) {
    if (kDebugMode) {
      debugPrint('Log Button Tap. $buttonText. $currentRoutePath');
    } else {
      debugPrint('yeah, we gotta shove this into the database');
    }
  }

  logApiCall() {}

  logError(Object e) async {
    if (kDebugMode) {
      debugPrint('ERROR IN LOGGER SERVICE!    ${e.toString()}');
    } else {
      debugPrint('shove this into a database');
    }
  }

  logInfo(Object e) {
    if (kDebugMode) {
      debugPrint('Log info.    ${e.toString()}');
    }
  }

  logLogin() {
    if (!kDebugMode) {
      debugPrint('shove it into a database');
    }
  }
}
