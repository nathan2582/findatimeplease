import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_flow.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/are_you_sure_dialog.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';

class ScheduleAppointmentModal extends StatelessWidget {
  const ScheduleAppointmentModal({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Schedule an Appointment',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppIconButton(
                    analyticsName: 'close_schedule_appointment_modal_button',
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      final result = await showAreYouSureDialog(context);

                      if (result == true && context.mounted) {
                        Navigator.of(context).pop(false);
                      }
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            const ScheduleAppointmentFlow(),
          ],
        ),
      ),
    );
  }
}
