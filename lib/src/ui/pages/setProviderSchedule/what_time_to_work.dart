import 'package:collection/collection.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/date_time_picker_view_model.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/day_hours_selector.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/set_provider_schedule_view_model.dart';
import 'package:flutter/material.dart';

class WhatTimeToWork extends StatelessWidget {
  const WhatTimeToWork(this.vm, {super.key});

  final SetProviderScheduleViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When do you want to work?',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: DayOfWeek.values.map(
              (day) {
                var timeModel = vm.providerTimeRanges
                    .firstWhereOrNull((element) => element.dayOfWeek == day);
                return DayHoursSelector(
                  day,
                  onExpansionChanged: (expanded) {
                    if (expanded) {
                      vm.handleExpansionChanged(day, expanded);
                    }
                  },
                  pDayOfWeek: timeModel,
                  selectToggle: (selected) =>
                      vm.selectedDayOfWeek(day, selected),
                  startChanged: (start) => vm.startChanged(day, start),
                  endChanged: (end) => vm.endChanged(day, end),
                  controller: timeModel?.controller,
                );
              },
            ).toList(growable: false),
          ),
        ),
      ],
    );
  }
}
