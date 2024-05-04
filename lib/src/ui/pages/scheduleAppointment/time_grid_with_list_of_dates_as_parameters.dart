import 'package:findatimeplease/src/ui/pages/scheduleAppointment/select_time_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_cell.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_cell_model.dart';
import 'package:flutter/material.dart';

class TimeGridWithListOfDatesAsParameters extends StatelessWidget {
  const TimeGridWithListOfDatesAsParameters({
    super.key,
    required this.dates,
    required this.timeSelected,
  });

  final List<TimeCellModel> dates;
  final Function(TimeCellModel) timeSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 3,
      childAspectRatio: 2,
      children: dates
          .map(
            (date) => TimeCell(
              time: date.time,
              selected: date.selected,
              timeSelected: () => timeSelected(date),
            ),
          )
          .toList(),
    );
  }
}
