import 'dart:async';

import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/appointment_confirmed_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/appointment_details_summary.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/schedule_appointment_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/viewModel/schedule_appointment_view_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/select_time_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/components/select_your_provider_component.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_primary_button.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleAppointmentFlow extends StatefulWidget {
  const ScheduleAppointmentFlow({super.key});

  @override
  State<ScheduleAppointmentFlow> createState() =>
      _ScheduleAppointmentFlowState();
}

class _ScheduleAppointmentFlowState extends State<ScheduleAppointmentFlow> {
  StreamSubscription? expiredStreamSub;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<ScheduleAppointmentViewModel>();
      expiredStreamSub = vm.expiredStream.listen((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Session Expired'),
              content: const Text(
                  'Your session has expired. Please start over to book an appointment.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    expiredStreamSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    final vm = context.watch<ScheduleAppointmentViewModel>();
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(
                  top: vm.onConfirmPage ? size.height * 0.25 : 0),
              child: const AppointmentDetailsSummary(),
            ),
            Expanded(
              child: PageView(
                controller: vm.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: vm.onPageChanged,
                children: const [
                  SelectYourProviderComponent(),
                  SelectTimeComponent(),
                  ConfirmAppointmentComponent(),
                  AppointmentConfirmedComponent(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppPrimaryButton(
              text: vm.primaryButtonText,
              analyticsName: 'next_button',
              onPressed: vm.primaryButtonEnabled
                  ? vm.appointmentBooked
                      ? () {
                          Navigator.pop(context, true);
                        }
                      : vm.handlePrimaryButtonTapped
                  : null,
              showLoadingSpinner: vm.bookingAppointment,
            ),
            const SizedBox(height: 8),
            Center(
              child: AppTextButton(
                analyticsName: 'back_button',
                text: 'Back',
                onPressed: vm.previousPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
