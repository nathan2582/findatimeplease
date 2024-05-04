import 'package:findatimeplease/src/ui/pages/scheduleAppointment/date_time_picker_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    this.initialDates,
    this.initialTime,
    required this.blockedDates,
    required this.dateSelected,
  });

  final List<DateTime>? initialDates;
  final DateTime? initialTime;
  final List<DateTime> blockedDates;
  final Function(DateTime) dateSelected;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  List<DateTime> _selectedDays = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final theDaysButOnUtcMidnight = widget.initialDates
          ?.map((e) => DateTime.utc(e.year, e.month, e.day))
          .toList();
      setState(() {
        _selectedDays = theDaysButOnUtcMidnight ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => DateTimePickerViewModel(),
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * .4,
              width: size.width,
              child: TableCalendar(
                shouldFillViewport: true,
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                ),
                firstDay: DateTime.now(),
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                rowHeight: 32,
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _selectedDays.isEmpty == true
                    ? DateTime.now()
                    : _selectedDays.last,
                calendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                  weekendTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  selectedTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  outsideDaysVisible: false,
                  cellPadding: const EdgeInsets.all(0),
                  cellMargin: const EdgeInsets.all(0),
                  withinRangeTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
                selectedDayPredicate: (day) {
                  return _selectedDays
                      .any((selectedDay) => isSameDay(selectedDay, day));
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // final dateIsBlocked = widget.blockedDates.any(
                  //     (blockedDate) => isSameDay(blockedDate, selectedDay));

                  setState(() {
                    if (_selectedDays.contains(selectedDay)) {
                      _selectedDays.remove(selectedDay);
                    } else {
                      _selectedDays.add(selectedDay);
                    }
                  });

                  widget.dateSelected(selectedDay);
                },
                headerVisible: true,
                weekNumbersVisible: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
