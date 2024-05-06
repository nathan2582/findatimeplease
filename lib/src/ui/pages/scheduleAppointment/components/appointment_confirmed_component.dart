import 'package:findatimeplease/src/ui/widgets/buttons/app_outlined_button.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmedComponent extends StatelessWidget {
  const AppointmentConfirmedComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 56),
        Text(
          'Appointment Confirmed!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        AppOutlinedButton(
          analyticsName: 'add_to_calendar_button',
          text: 'Add to Calendar',
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('There is a package for this'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Dismiss'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
