import 'package:flutter/material.dart';

class EditPersonDialog extends StatefulWidget {
  final String currentName;
  final String currentLastName;
  final String currentTelephone;
  final String currentEmail;
  final String currentCedula;
  final bool currentIsDoctor;
  final Function(String, String, String, String, String, bool) onEdit;

  EditPersonDialog({
    required this.currentName,
    required this.currentLastName,
    required this.currentTelephone,
    required this.currentEmail,
    required this.currentCedula,
    required this.currentIsDoctor,
    required this.onEdit,
  });

  @override
  _EditPersonDialogState createState() => _EditPersonDialogState();
}

class _EditPersonDialogState extends State<EditPersonDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  late bool _isDoctor;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentName;
    _lastNameController.text = widget.currentLastName;
    _telephoneController.text = widget.currentTelephone;
    _emailController.text = widget.currentEmail;
    _cedulaController.text = widget.currentCedula;
    _isDoctor = widget.currentIsDoctor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Person'),
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
          CheckboxListTile(
            title: Text('Is Doctor'),
            value: _isDoctor,
            onChanged: (value) {
              setState(() {
                _isDoctor = value!;
              });
            },
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

            widget.onEdit(newName, newLastName, newTelephone, newEmail, newCedula, _isDoctor);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
