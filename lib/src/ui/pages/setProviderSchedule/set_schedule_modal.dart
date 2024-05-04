import 'package:findatimeplease/src/ui/pages/setProviderSchedule/set_provider_schedule.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';

class SetScheduleModal extends StatelessWidget {
  const SetScheduleModal({super.key});

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
                      'Set Provider Schedule',
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            const SetProviderScheduleComponent(),
          ],
        ),
      ),
    );
  }
}