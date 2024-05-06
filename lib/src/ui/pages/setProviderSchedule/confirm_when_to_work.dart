import 'package:findatimeplease/src/ui/pages/setProviderSchedule/capitalize_string.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/set_provider_schedule_view_model.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/time_string_formatters.dart';
import 'package:flutter/material.dart';

class ConfirmWhenToWork extends StatelessWidget {
  const ConfirmWhenToWork(this.vm, {super.key});

  final SetProviderScheduleViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm your working hours',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Divider(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: vm.providerTimeRanges.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final providerWorkingDayOfWeek = vm.providerTimeRanges[index];
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${providerWorkingDayOfWeek.dayOfWeek.name.cap}s:',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    buildHoursToWork(providerWorkingDayOfWeek),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
