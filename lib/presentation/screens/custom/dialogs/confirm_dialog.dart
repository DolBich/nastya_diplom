import 'package:flutter/material.dart';

Future<bool?> confirmDialog(BuildContext context, int count, int initialCount) {
  return showDialog(
    context: context,
    builder: (context) {
      return _ConfirmDialog(
        count: count,
        initialCount: initialCount,
      );
    },
  );
}

class _ConfirmDialog extends StatelessWidget {
  final int count;
  final int initialCount;

  const _ConfirmDialog({
    required this.count,
    required this.initialCount,
  });

  Widget _cancel(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, false);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _continue(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, true);
      },
      child: const Text(
        'Continue',
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('All unsaved changes will be discharged. Continue?'),
      content: Text('You have changed count from $initialCount to $count'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        _continue(context),
        _cancel(context),
      ],
    );
  }
}
