import 'package:findatimeplease/src/schedule_appointment_modal.dart';
import 'package:flutter/material.dart';

Future<void> showScheduleAppointmentModal(BuildContext context) async {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    useSafeArea: true,
    useRootNavigator: true,
    enableDrag: false,
    builder: (BuildContext context) {
      return const ScheduleAppointmentModal();
    },
  );
}
