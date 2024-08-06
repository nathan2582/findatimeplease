import 'package:findatimeplease/src/ui/widgets/buttons/app_ink_well.dart';
import 'package:flutter/material.dart';

class TimeCell extends StatelessWidget {
  const TimeCell({
    super.key,
    required this.time,
    required this.selected,
    required this.timeSelected,
    required this.enabled,
  });

  final TimeOfDay time;
  final bool selected;
  final VoidCallback timeSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // TODO: use a different gesture recognizer so that the inkwell is circular and not rectangular
    return GestureDetector(
      onTap: enabled ? timeSelected : null,
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : const Color.fromARGB(255, 199, 199, 204),
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
