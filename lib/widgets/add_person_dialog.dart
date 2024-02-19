import 'package:flutter/material.dart';

class AddPersonDialog extends StatelessWidget {
  final Function(String, String, String, String, String, bool) onAdd;

  AddPersonDialog({required this.onAdd});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _isDoctorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Person'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: _telephoneController,
            decoration: InputDecoration(labelText: 'Telephone'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _cedulaController,
            decoration: InputDecoration(labelText: 'Cedula'),
          ),
          TextField(
            controller: _isDoctorController,
            decoration: InputDecoration(labelText: 'Is Doctor (true/false)'),
          ),
        ],
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
            final newLastName = _lastNameController.text;
            final newTelephone = _telephoneController.text;
            final newEmail = _emailController.text;
            final newCedula = _cedulaController.text;
            final newIsDoctor = _isDoctorController.text.toLowerCase() == 'true';

            if (newName.isNotEmpty) {
              onAdd(newName, newLastName, newTelephone, newEmail, newCedula, newIsDoctor); // Call the onAdd callback with the new person data.
            }
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
