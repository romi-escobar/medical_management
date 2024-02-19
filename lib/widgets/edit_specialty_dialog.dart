import 'package:flutter/material.dart';

class EditSpecialtyDialog extends StatelessWidget {
  final String currentName;
  final Function(String) onEdit;
  final TextEditingController _controller = TextEditingController();

  EditSpecialtyDialog({
    required this.currentName,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Specialty'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Current Name: $currentName'),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'New Name'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newName = _controller.text;
            onEdit(newName);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

