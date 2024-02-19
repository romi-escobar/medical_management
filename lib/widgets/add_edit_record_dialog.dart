import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_management/models/person.dart';
import 'package:medical_management/models/specialty.dart';
import 'package:medical_management/models/record.dart';
import 'package:medical_management/providers/record_provider.dart';
import 'package:medical_management/providers/person_provider.dart';
import 'package:medical_management/providers/specialty_provider.dart';

class AddEditRecordDialog extends StatefulWidget {
  final Record? record;

  const AddEditRecordDialog({Key? key, this.record}) : super(key: key);

  @override
  _AddEditRecordDialogState createState() => _AddEditRecordDialogState();
}

class _AddEditRecordDialogState extends State<AddEditRecordDialog> {
  final TextEditingController _motiveController = TextEditingController();
  final TextEditingController _diagnosticController = TextEditingController();
  final TextEditingController _consultationDateController = TextEditingController();
  Person? selectedPatient;
  Person? selectedDoctor;
  Specialty? selectedSpecialty;

  @override
  void initState() {
    super.initState();

    if (widget.record != null) {
      _motiveController.text = widget.record!.motiveOfConsultation;
      _diagnosticController.text = widget.record!.diagnostic;
      _consultationDateController.text = widget.record!.consultationDate.toString();
      selectedPatient = widget.record!.patient;
      selectedDoctor = widget.record!.doctor;
      selectedSpecialty = widget.record!.specialty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PersonProvider>(context);
    final doctorProvider = Provider.of<PersonProvider>(context);
    final specialtyProvider = Provider.of<SpecialtyProvider>(context);

    return AlertDialog(
      title: Text(widget.record == null ? 'Add Record' : 'Edit Record'),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dropdown for Patient
            DropdownButton<Person>(
              value: selectedPatient,
              items: patientProvider.patients.map((Person patient) {
                return DropdownMenuItem<Person>(
                  value: patient,
                  child: Text(patient.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPatient = value;
                });
              },
            ),
            // Dropdown for Doctor
            DropdownButton<Person>(
              value: selectedDoctor,
              items: doctorProvider.doctors.map((Person doctor) {
                return DropdownMenuItem<Person>(
                  value: doctor,
                  child: Text(doctor.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDoctor = value;
                });
              },
            ),
            // Dropdown for Specialty
            DropdownButton<Specialty>(
              value: selectedSpecialty,
              items: specialtyProvider.specialties.map((Specialty specialty) {
                return DropdownMenuItem<Specialty>(
                  value: specialty,
                  child: Text(specialty.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSpecialty = value;
                });
              },
            ),
            TextField(
              controller: _motiveController,
              decoration: InputDecoration(labelText: 'Motive of Consultation'),
            ),
            TextField(
              controller: _diagnosticController,
              decoration: InputDecoration(labelText: 'Diagnostic'),
            ),
            TextField(
              controller: _consultationDateController,
              decoration: InputDecoration(labelText: 'Consultation Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null && pickedDate != DateTime.now()) {
                  _consultationDateController.text = pickedDate.toString();
                }
              },
            ),
          ],
        ),
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
            _saveRecord(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  void _saveRecord(BuildContext context) {
    final recordProvider = Provider.of<RecordProvider>(context, listen: false);

    if (widget.record == null) {
      // Adding a new record
      final newRecord = Record(
        id: recordProvider.records.length + 1,
        patient: selectedPatient!,
        doctor: selectedDoctor!,
        specialty: selectedSpecialty!,
        motiveOfConsultation: _motiveController.text,
        diagnostic: _diagnosticController.text,
        consultationDate: DateTime.parse(_consultationDateController.text),
      );
      recordProvider.addRecord(newRecord);
    } else {
      // Editing an existing record
      recordProvider.editRecord(
        widget.record!.id,
        patient: selectedPatient!,
        doctor: selectedDoctor!,
        specialty: selectedSpecialty!,
        motiveOfConsultation: _motiveController.text,
        diagnostic: _diagnosticController.text,
        consultationDate: DateTime.parse(_consultationDateController.text),
      );
    }

    Navigator.pop(context);
  }
}
