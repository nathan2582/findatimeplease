import 'package:findatimeplease/src/ui/pages/scheduleAppointment/appointment_details_summary.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/schedule_appointment_view_model.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/select_your_provider_component.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/select_time_component.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_primary_button.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleAppointmentFlow extends StatelessWidget {
  const ScheduleAppointmentFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScheduleAppointmentViewModel(),
      builder: (context, _) {
        final vm = context.watch<ScheduleAppointmentViewModel>();
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (vm.selectedProvider != null)
                  const AppointmentDetailsSummary(),
                Expanded(
                  child: PageView(
                    controller: vm.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (_) => vm.notifyListeners(),
                    children: const [
                      SelectYourProviderComponent(),
                      SelectTimeComponent(),
                      ScheduleAppointmentComponent(),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  text: 'Next',
                  analyticsName: 'next_button',
                  onPressed: vm.nextButtonEnabled ? vm.nextPage : null,
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
      },
    );
  }
}
