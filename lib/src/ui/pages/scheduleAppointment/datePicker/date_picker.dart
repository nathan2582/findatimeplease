import 'package:findatimeplease/src/ui/pages/scheduleAppointment/datePicker/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.initialDate,
    required this.dateSelected,
  });

  final DateTime? initialDate;
  final Function(DateTime) dateSelected;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDay;
  final twentyFourHoursFromNow = DateTime.now().add(const Duration(days: 1));
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final initialDate = widget.initialDate ?? twentyFourHoursFromNow;
      final theDaysButOnUtcMidnight =
          DateTime.utc(initialDate.year, initialDate.month, initialDate.day);

      setState(() {
        _selectedDay = theDaysButOnUtcMidnight;
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
                headerStyle: const HeaderStyle(titleCentered: true),
                firstDay: twentyFourHoursFromNow,
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                rowHeight: 32,
                lastDay: twentyFourHoursFromNow.add(const Duration(days: 365)),
                focusedDay: _selectedDay ?? twentyFourHoursFromNow,
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
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
                selectedDayPredicate: (day) {
                  print('${DateTime.now().millisecondsSinceEpoch}: $day');
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
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
