import 'package:flutter/material.dart';

class ConfirmAppointmentComponent extends StatelessWidget {
  const ConfirmAppointmentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 56),
        Text(
          'Ready to Book?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
