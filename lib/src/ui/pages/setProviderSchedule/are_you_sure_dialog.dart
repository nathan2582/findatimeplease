import 'package:flutter/material.dart';

Future<bool?> showAreYouSureDialog(BuildContext context) async {
  return await showDialog<bool?>(
    context: context,
    useRootNavigator: false,
    builder: (_) {
      return const AreYouSureDialog();
    },
  );
}

class AreYouSureDialog extends StatelessWidget {
  const AreYouSureDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('You will lose all changes.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No, Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes, Discard'),
        ),
      ],
    );
  }
}
