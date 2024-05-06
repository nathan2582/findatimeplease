import 'package:flutter/cupertino.dart';

class DateTimePickerViewModel extends ChangeNotifier {
  DateTimePickerViewModel();

  // You can use this list to store other information related to selected days
  List<DayOfWeek> selectedDays = [];

  void toggleDayOfWeek(DayOfWeek dayOfWeek) {
    if (selectedDays.contains(dayOfWeek)) {
      selectedDays.remove(dayOfWeek);
    } else {
      selectedDays.add(dayOfWeek);
    }
    notifyListeners();
  }
}

enum DayOfWeek {
  sunday('Su', 'SUNDAY'),
  monday('Mo', 'MONDAY'),
  tuesday('Tu', 'TUESDAY'),
  wednesday('We', 'WEDNESDAY'),
  thursday('Th', 'THURSDAY'),
  friday('Fr', 'FRIDAY'),
  saturday('Sa', 'SATURDAY');

  const DayOfWeek(this.shortName, this.dbName);

  final String shortName;
  final String dbName;
}
