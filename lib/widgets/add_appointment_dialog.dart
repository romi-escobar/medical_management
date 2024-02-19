import 'package:flutter/material.dart';
import 'package:medical_management/models/appointment.dart';
import 'package:medical_management/models/person.dart';
import 'package:medical_management/providers/appointment_provider.dart';
import 'package:medical_management/providers/person_provider.dart';
import 'package:provider/provider.dart';

class AddAppointmentDialog extends StatefulWidget {
  @override
  _AddAppointmentDialogState createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  Person? selectedDoctor;
  Person? selectedPatient; 
  DateTime selectedDateTime = DateTime.now();
  late AppointmentProvider appointmentProvider; // Define the appointmentProvider variable

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<PersonProvider>(context);
    final patientProvider = Provider.of<PersonProvider>(context);

    return AlertDialog(
      title: Text('Add Appointment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<Person>(
            value: selectedDoctor,
            items: doctorProvider.doctors.map((Person doctor) {
              return DropdownMenuItem<Person>(
                value: doctor,
                child: Text(doctor.name), // Display the name of the doctor.
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedDoctor = value!;
              });
            },
          ),
          DropdownButton<Person>(
            value: selectedPatient,
            items: patientProvider.patients.map((Person patient) {
              return DropdownMenuItem<Person>(
                value: patient,
                child: Text(patient.name), // Display the name of the patient.
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedPatient = value!;
              });
            },
          ),
          Text('Select Date and Time:'),
          ElevatedButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: selectedDateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 30)),
              );

              if (selectedDate != null) {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                );

                if (selectedTime != null) {
                  setState(() {
                    selectedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                  });
                }
              }
            },
            child: Text('Pick Date and Time'),
          ),
        ],
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
            if (selectedDoctor != null && selectedPatient != null) {
              final selectedDoctorPerson = doctorProvider.getPersonByName(selectedDoctor!.name!);
              final selectedPatientPerson = patientProvider.getPersonByName(selectedPatient!.name!);

              final newAppointment = Appointment(
                id: appointmentProvider.appointments.length + 1,
                doctor: selectedDoctorPerson,
                patient: selectedPatientPerson,
                appointmentDateTime: selectedDateTime,
              );

              appointmentProvider.addAppointment(newAppointment);
              Navigator.pop(context);
            } else {
              // Handle the case where either doctor or patient is null.
              // You might want to show an error message or take appropriate action.
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
