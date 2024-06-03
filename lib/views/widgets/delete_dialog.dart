import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  VoidCallback onDeleted;
  DeleteDialog({required this.onDeleted, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade300,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: const Text("Are you sure to delete the plan?"),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            onDeleted();
            Navigator.pop(context);
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}