import 'package:findatimeplease/src/ui/pages/scheduleAppointment/datePicker/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';

class DaysOfWeekScheduleDialogViewModel extends ChangeNotifier {
  // TODO: pass in the selected days of the week if in edit mode.
  DaysOfWeekScheduleDialogViewModel();

  List<DayOfWeek> get selectedDays => _selectedDays;
  final List<DayOfWeek> _selectedDays = [];

  void toggleDayOfWeek(DayOfWeek dayOfWeek) {
    if (_selectedDays.contains(dayOfWeek)) {
      _selectedDays.remove(dayOfWeek);
    } else {
      _selectedDays.add(dayOfWeek);
    }

    _selectedDays.sort((a, b) => a.index.compareTo(b.index));
    notifyListeners();
  }
}
