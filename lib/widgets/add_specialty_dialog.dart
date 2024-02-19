import 'package:flutter/material.dart';

class AddSpecialtyDialog extends StatelessWidget {
  final Function(String) onAdd;

  AddSpecialtyDialog({required this.onAdd});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Specialty'),
      content: TextField(
        controller: _nameController,
        decoration: InputDecoration(labelText: 'Specialty Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newName = _nameController.text;
            if (newName.isNotEmpty) {
              onAdd(newName); // Call the onAdd callback with the new specialty name.
            }
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}


