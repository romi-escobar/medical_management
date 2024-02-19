import 'package:flutter/material.dart';
import 'package:medical_management/models/record.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ExportExcelDialog extends StatelessWidget {
  final List<Record> records;

  const ExportExcelDialog({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Export to Excel'),
      content: Text('Do you want to export records to Excel?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await _exportToExcel(context);
            Navigator.pop(context);
          },
          child: Text('Export'),
        ),
      ],
    );
  }

  Future<void> _exportToExcel(BuildContext context) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    // Headers
    sheet.appendRow(['ID', 'Patient', 'Doctor', 'Specialty', 'Motive', 'Diagnostic', 'Date']);

    // Data
    for (final record in records) {
      sheet.appendRow([
        record.id,
        '${record.patient.name} ${record.patient.lastName}',
        '${record.doctor.name} ${record.doctor.lastName}',
        record.specialty.name,
        record.motiveOfConsultation,
        record.diagnostic,
        record.consultationDate.toLocal().toString(),
      ]);
    }

    // Allow the user to choose a directory for saving the file
    final String? directoryPath = await _getDirectoryPath();

    if (directoryPath != null) {
      // Save the Excel file in the chosen directory
      final filePath = path.join(directoryPath, 'medical_records.xlsx');
      final fileBytes = excel.encode();
      final file = File(filePath);
      await file.writeAsBytes(fileBytes!);

      // Provide feedback to the user
      final snackBar = SnackBar(
        content: Text('File exported successfully!'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            // Open the file or provide an appropriate action
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<String?> _getDirectoryPath() async {
    final result = await FilePicker.platform.getDirectoryPath();
    return result;
  }
}
