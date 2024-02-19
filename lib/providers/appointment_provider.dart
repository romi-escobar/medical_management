import 'package:flutter/material.dart';
import 'package:medical_management/models/appointment.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void deleteAppointment(int id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners();
  }

  List<Appointment> getAppointmentsByDate(DateTime date) {
    return _appointments
        .where((appointment) =>
            appointment.appointmentDateTime.year == date.year &&
            appointment.appointmentDateTime.month == date.month &&
            appointment.appointmentDateTime.day == date.day)
        .toList();
  }

    List<Appointment> getAppointmentsByDoctor(String doctorName) {
    return _appointments.where((appointment) => appointment.doctor.name.toLowerCase() == doctorName.toLowerCase()).toList();
  }

  List<Appointment> getAppointmentsByPatient(String patientName) {
    return _appointments.where((appointment) => appointment.patient.name.toLowerCase() == patientName.toLowerCase()).toList();
  }
}
