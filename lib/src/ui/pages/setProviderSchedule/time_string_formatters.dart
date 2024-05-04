import 'package:findatimeplease/src/ui/pages/setProviderSchedule/provider_working_day_of_week.dart';
import 'package:flutter/material.dart';

String buildHoursToWork(ProviderWorkingDayOfWeek? pDayOfWeek) {
  final selected = pDayOfWeek?.selected == true;
  var start = timeFormat(pDayOfWeek?.start);
  var end = timeFormat(pDayOfWeek?.end);
  return selected ? '$start - $end' : 'Off';
}

String timeFormat(TimeOfDay? time) {
  final hour = time?.hourOfPeriod;
  final minute = time?.minute.toString().padLeft(2, '0');
  final period = time?.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}
