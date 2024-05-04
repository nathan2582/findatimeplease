import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HourRangeWidget extends StatelessWidget {
  const HourRangeWidget({
    super.key,
    required this.startChanged,
    required this.endChanged,
    required this.initialStart,
    required this.initialEnd,
  });

  final Function(TimeOfDay) startChanged;
  final Function(TimeOfDay) endChanged;
  final TimeOfDay? initialStart;
  final TimeOfDay? initialEnd;

  @override
  Widget build(BuildContext context) {
    // TODO: implement start time cannot be after end time and such.
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: SizedBox(
              height: 100,
              child: CupertinoDatePicker(
                minuteInterval: 15,
                initialDateTime: initialStart?.toDateTime(),
                onDateTimeChanged: (date) =>
                    startChanged(TimeOfDay.fromDateTime(date)),
                mode: CupertinoDatePickerMode.time,
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 100,
              child: CupertinoDatePicker(
                minuteInterval: 15,
                initialDateTime: initialEnd?.toDateTime(),
                onDateTimeChanged: (date) =>
                    endChanged(TimeOfDay.fromDateTime(date)),
                mode: CupertinoDatePickerMode.time,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension ToDateTime on TimeOfDay {
  DateTime toDateTime() {
    return DateTime(1, 1, 1, hour, minute);
  }
}
