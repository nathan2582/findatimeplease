import 'package:findatimeplease/src/locator/locator.dart';
import 'package:findatimeplease/src/services/logger_service.dart';
import 'package:flutter/material.dart';

mixin BaseLogic {
  final logger = locator<LoggerService>();
}

abstract class BaseRepo with BaseLogic {}

class BaseService extends ChangeNotifier with BaseLogic {}

abstract class BaseState extends BaseService {
  bool get busy => _busy;
  bool _busy = false;

  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (disposed) return;
    super.notifyListeners();
  }

  setBusy(bool value, {bool notify = true}) {
    _busy = value;
    if (notify) {
      notifyListeners();
    }
  }
}
