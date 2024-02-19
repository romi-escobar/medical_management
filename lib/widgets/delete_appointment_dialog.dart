import 'package:flutter/material.dart';

class DeleteAppointmentDialog extends StatelessWidget {
  final Function() onDelete;

  DeleteAppointmentDialog({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Cancellation'),
      content: Text('Are you sure you want to cancel this appointment?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
        ElevatedButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
