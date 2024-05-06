import 'package:findatimeplease/src/ui/pages/scheduleAppointment/date_picker.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_view_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/selected_date_extension.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/time_slots_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectTimeComponent extends StatefulWidget {
  const SelectTimeComponent({super.key});

  @override
  State<SelectTimeComponent> createState() => _SelectTimeComponentState();
}

class _SelectTimeComponentState extends State<SelectTimeComponent> {
  ExpansionTileController expansionController = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScheduleAppointmentViewModel>();
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        ExpansionTile(
          controller: expansionController,
          leading: const Icon(Icons.calendar_month),
          title: Text(vm.selectedDate?.toDisplayText ?? 'Select a Date'),
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: vm.selectedDate == null,
          children: [
            DatePicker(
              initialDate: vm.selectedDate,
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
                  Text(
                    'Checking ${vm.selectedProvider?.name}\'s schedule for ${vm.selectedDate?.toMonthDay}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(),
                ],
              ))
            : TimeSlotsComponent(vm),
      ],
    );
  }
}
