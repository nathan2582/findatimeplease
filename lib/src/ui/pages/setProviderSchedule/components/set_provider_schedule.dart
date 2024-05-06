import 'package:findatimeplease/src/ui/pages/setProviderSchedule/components/confirm_when_to_work.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/viewModel/set_provider_schedule_view_model.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/components/what_time_to_work.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_primary_button.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetProviderScheduleComponent extends StatelessWidget {
  const SetProviderScheduleComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SetProviderScheduleViewModel(),
      builder: (context, _) {
        final vm = context.watch<SetProviderScheduleViewModel>();
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView(
                    controller: vm.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (_) => vm.notifyListeners(),
                    children: [
                      WhatTimeToWork(vm),
                      ConfirmWhenToWork(vm),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  text: vm.primaryText,
                  analyticsName: 'next_button',
                  onPressed:
                      vm.primaryButtonEnabled ? vm.handlePrimaryButton : null,
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
