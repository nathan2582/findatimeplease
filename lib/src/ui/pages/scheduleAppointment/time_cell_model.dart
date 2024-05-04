import 'package:flutter/material.dart';

class TimeCellModel {
  TimeCellModel({
    required this.time,
    required this.selected,
  });

  final TimeOfDay time;
  bool selected;
}
