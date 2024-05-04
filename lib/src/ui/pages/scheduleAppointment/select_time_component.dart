import 'package:findatimeplease/src/ui/pages/scheduleAppointment/date_time_picker.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_view_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/selected_date_extension.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_cell.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_grid_with_list_of_dates_as_parameters.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_slots_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectTimeComponent extends StatefulWidget {
  const SelectTimeComponent({super.key});

  @override
  State<SelectTimeComponent> createState() => _SelectTimeComponentState();
}

class _SelectTimeComponentState extends State<SelectTimeComponent> {
  ExpansionTileController expansionController = ExpansionTileController();

  List<Widget> _buildTimeCellsEveryThirtyMinutesFromTimeRange(
    DateTime start,
    DateTime end,
  ) {
    final List<Widget> timeCells = [];
    for (var i = start;
        i.isBefore(end);
        i = i.add(const Duration(minutes: 30))) {
      timeCells.add(
        TimeCell(
          time: TimeOfDay.fromDateTime(i),
          selected: false,
          timeSelected: () {
            print('selected ${i.hourMinuteText}');
          },
        ),
      );
    }
    return timeCells;
  }

  List<DateTime> buildListOfDates(DateTime start, DateTime end) {
    final List<DateTime> dates = [];
    for (var i = start; i.isBefore(end); i = i.add(const Duration(days: 1))) {
      dates.add(i);
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScheduleAppointmentViewModel>();
    return ListView(
      children: [
        ExpansionTile(
          controller: expansionController,
          title: Text(vm.selectedDate?.toDisplayText ?? 'test'),
          tilePadding: EdgeInsets.zero,
          children: [
            DateTimePicker(
              blockedDates: const [],
              dateSelected: (date) {
                vm.handleDateSelected(date);
                expansionController.collapse();
              },
            ),
          ],
        ),
        const SizedBox(height: 32),
        vm.fetchingDates
            ? Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Getting available times...',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                          )),
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(),
                ],
              ))
            : TimeSlotsComponent(vm),
      ],
    );
  }
}
