// record_provider.dart

import 'package:flutter/material.dart';
import 'package:medical_management/models/person.dart';
import 'package:medical_management/models/record.dart';
import 'package:medical_management/models/specialty.dart';

class RecordProvider extends ChangeNotifier {
  List<Record> _records = [];

  List<Record> get records => _records;

  void addRecord(Record record) {
    _records.add(record);
    notifyListeners();
  }

  void editRecord(int id, {
    required Person patient,
    required Person doctor,
    required Specialty specialty,
    required String motiveOfConsultation,
    required String diagnostic,
    required DateTime consultationDate,
  }) {
    final record = _records.firstWhere((r) => r.id == id);
    record.patient = patient;
    record.doctor = doctor;
    record.specialty = specialty;
    record.motiveOfConsultation = motiveOfConsultation;
    record.diagnostic = diagnostic;
    record.consultationDate = consultationDate;

    notifyListeners();
  }

  void deleteRecord(int id) {
    _records.removeWhere((record) => record.id == id);
    notifyListeners();
  }
}
