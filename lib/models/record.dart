import 'package:medical_management/models/person.dart';
import 'package:medical_management/models/specialty.dart';

class Record {
  int id;
  Person patient;
  Person doctor;
  Specialty specialty;
  String motiveOfConsultation;
  String diagnostic;
  DateTime consultationDate; // Added field

  Record({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.specialty,
    required this.motiveOfConsultation,
    required this.diagnostic,
    required this.consultationDate,
  });
}
