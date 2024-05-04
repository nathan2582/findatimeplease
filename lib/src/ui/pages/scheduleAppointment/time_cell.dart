import 'package:findatimeplease/src/ui/pages/scheduleAppointment/appointment_details_summary.dart';
import 'package:findatimeplease/src/ui/pages/scheduleAppointment/selected_date_extension.dart';
import 'package:findatimeplease/src/ui/widgets/buttons/app_ink_well.dart';
import 'package:flutter/material.dart';

class TimeCell extends StatelessWidget {
  const TimeCell({
    super.key,
    required this.time,
    required this.selected,
    required this.timeSelected,
  });

  final TimeOfDay time;
  final bool selected;
  final VoidCallback timeSelected;

  @override
  Widget build(BuildContext context) {
    // TODO: use a different gesture recognizer so that the inkwell is circular and not rectangular
    return AppInkWell(
      analyticsName: 'time_cell_tapped',
      onTap: timeSelected,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary : greyColor,
          borderRadius: BorderRadius.circular(500),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            time.format(context),
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
