import 'package:flutter/material.dart';

class RecordSearchDialog extends StatelessWidget {
  final String initialQuery;

  const RecordSearchDialog({Key? key, required this.initialQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _searchQuery = initialQuery;

    return AlertDialog(
      title: Text('Search Records'),
      content: TextField(
        controller: TextEditingController(text: initialQuery),
        onChanged: (value) {
          _searchQuery = value;
        },
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
            Navigator.pop(context, _searchQuery);
          },
          child: Text('Search'),
        ),
      ],
    );
  }
}
