import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends ChangeNotifier {
  Timer? _timer;
  final int _totalSeconds;
  CountdownTimer(this._totalSeconds);

  int _currentSeconds = 0;

  String get displayTime {
    if (_currentSeconds >= 300) {
      int minutes = _currentSeconds ~/ 60;
      return 'Spot reserved: $minutes min remaining';
    } else {
      int minutes = _currentSeconds ~/ 60;
      int seconds = _currentSeconds % 60;
      return 'Spot reserved: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  bool get isActive => _timer?.isActive ?? false;

  void startCountdown() {
    _currentSeconds = _totalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds == 0) {
        timer.cancel();
      } else {
        _currentSeconds--;
        notifyListeners();
      }
    });
  }

  void stopCountdown() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
