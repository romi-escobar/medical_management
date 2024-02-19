import 'package:flutter/material.dart';
import 'package:medical_management/models/person.dart';

class ReadPersonDialog extends StatelessWidget {
  final Person person;

  ReadPersonDialog({required this.person}) {
    print("Person details: $person");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Person Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${person.name}'),
          Text('Last Name: ${person.lastName}'),
          Text('Telephone: ${person.telephone}'),
          Text('Email: ${person.email}'),
          Text('Cedula: ${person.cedula}'),
          Text('Is Doctor: ${person.isDoctor ? 'Yes' : 'No'}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
