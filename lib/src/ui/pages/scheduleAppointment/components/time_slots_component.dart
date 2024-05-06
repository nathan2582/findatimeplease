import 'package:findatimeplease/src/ui/pages/scheduleAppointment/viewModel/schedule_appointment_view_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/time_grid_with_list_of_dates_as_parameters.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/time_title_text.dart';
import 'package:flutter/material.dart';

class TimeSlotsComponent extends StatelessWidget {
  const TimeSlotsComponent(
    this.vm, {
    super.key,
  });

  final ScheduleAppointmentViewModel vm;

  @override
  Widget build(BuildContext context) {
    return vm.selectedDate == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Appointments must be scheduled at least 24 hours in advance',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
              const TimeTitleText('MORNING'),
              TimeGridWithListOfDatesAsParameters(
                dates: vm.morningTimeSlots,
                timeSelected: vm.chooseTime,
              ),
              const SizedBox(height: 16),
              const TimeTitleText('AFTERNOON'),
              TimeGridWithListOfDatesAsParameters(
                dates: vm.afternoonTimeSlots,
                timeSelected: vm.chooseTime,
              ),
              const SizedBox(height: 16),
              const TimeTitleText('EVENING'),
              TimeGridWithListOfDatesAsParameters(
                dates: vm.eveningTimeSlots,
                timeSelected: vm.chooseTime,
              ),
              const SizedBox(height: 16),
            ],
          );
  }
}
