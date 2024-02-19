import 'person.dart';

class Appointment {
  final int id;
  final DateTime appointmentDateTime;
  final Person patient;
  final Person doctor;

  Appointment({
    required this.id,
    required this.appointmentDateTime,
    required this.patient,
    required this.doctor,
  });
}
