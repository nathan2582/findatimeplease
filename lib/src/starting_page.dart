import 'package:findatimeplease/src/schedule_appointment_modal.dart';
import 'package:findatimeplease/src/show_schedule_appointment_modal.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/show_set_schedule_modal.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_icon_button.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_outlined_button.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_primary_button.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Client Functionality',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppPrimaryButton(
                analyticsName: 'request_appointment_button',
                showLoadingSpinner: false,
                onPressed: () async {
                  final result = await showScheduleAppointmentModal(context);
                  if (result == true && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Appointment Booked!'),
                      ),
                    );
                  }
                },
                text: 'Request Appointment',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Provider Functionality',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppPrimaryButton(
                analyticsName: 'request_appointment_button',
                showLoadingSpinner: false,
                onPressed: () {
                  showSetScheduleModal(context);
                },
                text: 'Set Schedule',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
