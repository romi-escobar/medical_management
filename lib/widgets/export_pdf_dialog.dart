import 'package:flutter/material.dart';
import 'package:medical_management/models/record.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ExportPdfDialog extends StatelessWidget {
  final List<Record> records;

  const ExportPdfDialog({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Export to PDF'),
      content: Text('Do you want to export records to PDF?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            await _exportToPdf(context);
            Navigator.pop(context);
          },
          child: Text('Export'),
        ),
      ],
    );
  }

  Future<void> _exportToPdf(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Table.fromTextArray(context: context, data: _getTableData()),
        ],
      ),
    );

    // Allow the user to choose a directory for saving the file
    final String? directoryPath = await _getDirectoryPath();

    if (directoryPath != null) {
      // Save the PDF file in the chosen directory
      final filePath = path.join(directoryPath, 'medical_records.pdf');
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

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

  List<List<String>> _getTableData() {
    // Format your data accordingly
    return records.map((record) => [
      record.id.toString(),
      '${record.patient.name} ${record.patient.lastName}',
      '${record.doctor.name} ${record.doctor.lastName}',
      record.specialty.name,
      record.motiveOfConsultation,
      record.diagnostic,
      record.consultationDate.toLocal().toString(),
    ]).toList();
  }

  Future<String?> _getDirectoryPath() async {
    final result = await FilePicker.platform.getDirectoryPath();
    return result;
  }
}
