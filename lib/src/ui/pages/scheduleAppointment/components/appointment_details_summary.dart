import 'package:findatimeplease/src/theme/app_theme.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/countdownTimer/countdown_timer.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/viewModel/schedule_appointment_view_model.dart';
import 'package:findatimeplease/src/extensions/selected_date_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentDetailsSummary extends StatelessWidget {
  const AppointmentDetailsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScheduleAppointmentViewModel>();
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO: could optimize by only calling notifyListeners when minutes
        // change until the seconds are visible
        Consumer<CountdownTimer>(builder: (context, countdown, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.timer, size: 14),
              const SizedBox(width: 4),
              Text(
                vm.fetchingProviders ? '-' : vm.remainingTimeText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        }),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(appBorderRadius),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('Your Appointment Details',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const Icon(Icons.person_outlined),
                        if (vm.selectedProvider != null)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('With:'),
                          ),
                        Text(
                          vm.selectedProvider?.name ?? '',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (vm.selectedDate != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded),
                          const SizedBox(width: 8),
                          const Text('When:'),
                          const SizedBox(width: 8),
                          Text(
                            vm.selectedDate?.toDisplayText ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (vm.selectedTime != null)
                            Row(
                              children: [
                                const Text(' at '),
                                Text(
                                  vm.selectedTime?.format(context) ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined),
                          const SizedBox(width: 8),
                          const Text('Duration:'),
                          const SizedBox(width: 8),
                          Text(
                            '15 minutes',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
