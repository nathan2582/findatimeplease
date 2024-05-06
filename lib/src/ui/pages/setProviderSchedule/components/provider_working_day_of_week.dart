import 'package:findatimeplease/src/ui/pages/scheduleAppointment/datePicker/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';

class ProviderWorkingDayOfWeek {
  ProviderWorkingDayOfWeek({
    required this.dayOfWeek,
    required this.start,
    required this.end,
    required this.selected,
    required this.controller,
  });

  bool selected;
  final DayOfWeek dayOfWeek;
  TimeOfDay? start;
  TimeOfDay? end;
  final ExpansionTileController controller;
}
