import 'package:findatimeplease/src/ui/pages/scheduleAppointment/countdownTimer/countdown_timer.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_flow.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/viewModel/schedule_appointment_view_model.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/components/are_you_sure_dialog.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleAppointmentModal extends StatelessWidget {
  const ScheduleAppointmentModal({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          //
          ChangeNotifierProvider(create: (context) => CountdownTimer(30 * 60)),
          ChangeNotifierProxyProvider<CountdownTimer,
              ScheduleAppointmentViewModel>(
            create: (context) => ScheduleAppointmentViewModel(
              Provider.of<CountdownTimer>(context, listen: false),
            ),
            update: (context, timer, viewModel) {
              viewModel!.countdownTimer = timer;
              return viewModel;
            },
          ),
        ],
        builder: (context, _) {
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
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppIconButton(
                          analyticsName:
                              'close_schedule_appointment_modal_button',
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
        });
  }
}
