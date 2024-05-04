import 'package:findatimeplease/src/ui/pages/setProviderSchedule/set_schedule_modal.dart';
import 'package:flutter/material.dart';

Future<void> showSetScheduleModal(BuildContext context) async {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    useSafeArea: true,
    useRootNavigator: true,
    enableDrag: false,
    builder: (BuildContext context) {
      return const SetScheduleModal();
    },
  );
}
