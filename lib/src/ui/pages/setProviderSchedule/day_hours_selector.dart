import 'package:findatimeplease/src/ui/pages/scheduleAppointment/date_time_picker_view_model.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/capitalize_string.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/hour_range_widget.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/provider_working_day_of_week.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/time_string_formatters.dart';
import 'package:flutter/material.dart';

class DayHoursSelector extends StatefulWidget {
  const DayHoursSelector(
    this.dayOfWeek, {
    super.key,
    required this.selectToggle,
    required this.startChanged,
    required this.endChanged,
    required this.pDayOfWeek,
    required this.controller,
    required this.onExpansionChanged,
  });

  final DayOfWeek dayOfWeek;
  final ProviderWorkingDayOfWeek? pDayOfWeek;
  final Function(bool?) selectToggle;
  final Function(bool) onExpansionChanged;
  final Function(TimeOfDay) startChanged;
  final Function(TimeOfDay) endChanged;
  final ExpansionTileController? controller;

  @override
  State<DayHoursSelector> createState() => _DayHoursSelectorState();
}

class _DayHoursSelectorState extends State<DayHoursSelector> {
  @override
  Widget build(BuildContext context) {
    final selected = widget.pDayOfWeek?.selected == true;
    var dayHoursText =
        '${widget.dayOfWeek.name.cap}s ${buildHoursToWork(widget.pDayOfWeek)}';
    return ExpansionTile(
      controller: widget.controller,
      onExpansionChanged: widget.onExpansionChanged,
      dense: true,
      tilePadding: EdgeInsets.zero,
      leading: Checkbox(
        value: selected,
        onChanged: widget.selectToggle,
      ),
      title: Text(dayHoursText),
      children: [
        HourRangeWidget(
          startChanged: widget.startChanged,
          endChanged: widget.endChanged,
          initialStart: widget.pDayOfWeek?.start,
          initialEnd: widget.pDayOfWeek?.end,
        ),
      ],
    );
  }
}
