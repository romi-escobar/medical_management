// record_list.dart

import 'package:flutter/material.dart';
import 'package:medical_management/models/record.dart';
import 'package:medical_management/providers/record_provider.dart';
import 'package:medical_management/widgets/add_edit_record_dialog.dart';
import 'package:medical_management/widgets/export_excel_dialog.dart';
import 'package:medical_management/widgets/export_pdf_dialog.dart';
import 'package:medical_management/widgets/record_search_dialog.dart';
import 'package:provider/provider.dart';

class RecordList extends StatefulWidget {
  @override
  _RecordListState createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  String _searchQuery = '';
  String _sortBy = 'Date'; // Default sorting by date

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordProvider>(context);
    final records = recordProvider.records;

    // Apply sorting based on the selected option
    records.sort((a, b) {
      switch (_sortBy) {
        case 'Date':
          return b.consultationDate.compareTo(a.consultationDate); // Sort by date in descending order
        case 'Doctor':
          return a.doctor.name.compareTo(b.doctor.name); // Sort by doctor's name
        case 'Patient':
          return a.patient.name.compareTo(b.patient.name); // Sort by patient's name
        case 'Specialty':
          return a.specialty.name.compareTo(b.specialty.name); // Sort by specialty
        default:
          return b.consultationDate.compareTo(a.consultationDate);
      }
    });

    // Apply filtering based on the search query
    final filteredRecords = records.where((record) {
      final doctorName = record.doctor.name.toLowerCase();
      final patientName = record.patient.name.toLowerCase();
      final specialtyName = record.specialty.name.toLowerCase();

      return doctorName.contains(_searchQuery) ||
          patientName.contains(_searchQuery) ||
          specialtyName.contains(_searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Records'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final searchQuery = await showDialog<String>(
                context: context,
                builder: (context) => RecordSearchDialog(initialQuery: _searchQuery),
              );

              if (searchQuery != null) {
                setState(() {
                  _searchQuery = searchQuery.toLowerCase();
                });
              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _sortBy = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Date', child: Text('Sort by Date')),
              PopupMenuItem(value: 'Doctor', child: Text('Sort by Doctor')),
              PopupMenuItem(value: 'Patient', child: Text('Sort by Patient')),
              PopupMenuItem(value: 'Specialty', child: Text('Sort by Specialty')),
            ],
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddEditRecordDialog(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => ExportPdfDialog(records: filteredRecords),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.table_chart),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => ExportExcelDialog(records: filteredRecords),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredRecords.length,
        itemBuilder: (context, index) {
          final record = filteredRecords[index];
          return ListTile(
            title: Text(record.patient.name),
            subtitle: Text(record.doctor.name),
            onTap: () {
              // Handle tapping on a record (if needed)
            },
          );
        },
      ),
    );
  }
}
