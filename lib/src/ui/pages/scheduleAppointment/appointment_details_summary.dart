import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentDetailsSummary extends StatelessWidget {
  const AppointmentDetailsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScheduleAppointmentViewModel>();
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your Request'),
        const SizedBox(height: 16),
        SizedBox(
          width: size.width,
          child: Text(
            vm.selectedProvider?.name ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          vm.selectedDate?.toLocal().toString() ?? '',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: greyColor,
              ),
        ),
      ],
    );
  }
}

// TODO: Put into Material color scheme
const greyColor = Color.fromARGB(255, 199, 199, 204);
