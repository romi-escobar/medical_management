// record_screen.dart

import 'package:flutter/material.dart';
import 'package:medical_management/providers/record_provider.dart';
import 'package:medical_management/widgets/add_edit_record_dialog.dart';
import 'package:medical_management/widgets/export_excel_dialog.dart';
import 'package:medical_management/widgets/export_pdf_dialog.dart';
import 'package:medical_management/widgets/record_search_dialog.dart';
import 'package:medical_management/widgets/record_list.dart'; // Import the new widget
import 'package:provider/provider.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Records'),
      ),
      body: RecordList(), // Use the RecordList widget
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddEditRecordDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
