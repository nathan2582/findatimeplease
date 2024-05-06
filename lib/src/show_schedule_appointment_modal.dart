import 'package:findatimeplease/src/schedule_appointment_modal.dart';
import 'package:flutter/material.dart';

Future<bool?> showScheduleAppointmentModal(BuildContext context) async {
  return showModalBottomSheet<bool?>(
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
