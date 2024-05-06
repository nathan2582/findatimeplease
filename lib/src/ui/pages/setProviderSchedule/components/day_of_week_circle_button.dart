import 'package:findatimeplease/src/ui/pages/scheduleAppointment/datePicker/date_time_picker_view_model.dart';
import 'package:findatimeplease/src/ui/pages/setProviderSchedule/components/days_of_week_schedule_dialog_view_model.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayOfWeekCircleButton extends StatelessWidget {
  const DayOfWeekCircleButton({
    super.key,
    required this.day,
    required this.size,
    required this.postId,
  });

  final DayOfWeek day;
  final Size size;
  final String? postId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppOutlinedButton(
        analyticsName: day.shortName,
        text: day.shortName,
        size: Size(size.width / 6, size.width / 6),
        isCircle: true,
        backgroundColor: context
                .watch<DaysOfWeekScheduleDialogViewModel>()
                .selectedDays
                .contains(day)
            ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
            : Colors.transparent,
        textColor: context
                .watch<DaysOfWeekScheduleDialogViewModel>()
                .selectedDays
                .contains(day)
            ? Colors.white
            : null,
        borderColor: context
                .watch<DaysOfWeekScheduleDialogViewModel>()
                .selectedDays
                .contains(day)
            ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
            : Colors.grey,
        onTap: () {
          context
              .read<DaysOfWeekScheduleDialogViewModel>()
              .toggleDayOfWeek(day);
        },
      ),
    );
  }
}
