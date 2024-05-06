import 'package:findatimeplease/src/ui/pages/scheduleAppointment/select_time_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_cell.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/client_side_time_cell_model.dart';
import 'package:flutter/material.dart';

class TimeGridWithListOfDatesAsParameters extends StatelessWidget {
  const TimeGridWithListOfDatesAsParameters({
    super.key,
    required this.dates,
    required this.timeSelected,
  });

  final List<ClientSideTimeCellModel> dates;
  final Function(ClientSideTimeCellModel) timeSelected;

  @override
  Widget build(BuildContext context) {
    return dates.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Nothing Available'),
          )
        : GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
            ),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              return TimeCell(
                time: date.time,
                selected: date.selected,
                enabled: date.enabled,
                timeSelected: () => timeSelected(date),
              );
            },
          );
  }
}
