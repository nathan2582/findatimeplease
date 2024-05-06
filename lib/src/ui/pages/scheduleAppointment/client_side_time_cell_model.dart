import 'package:flutter/material.dart';

class ClientSideTimeCellModel {
  ClientSideTimeCellModel({
    required this.time,
    required this.selected,
    required this.minutes,
    required this.enabled,
  });

  final TimeOfDay time;
  final int minutes;
  bool selected;
  bool enabled;
}
