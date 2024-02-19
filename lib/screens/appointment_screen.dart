import 'package:flutter/material.dart';
import 'package:medical_management/providers/appointment_provider.dart';
import 'package:medical_management/widgets/add_appointment_dialog.dart';
import 'package:provider/provider.dart';
import 'package:medical_management/models/appointment.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String searchQuery = '';
  String filterType = '';

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Name'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(labelText: 'Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Trigger a rebuild with the new filter.
                setState(() {});
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final appointments = appointmentProvider.appointments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filterType = value;
                if (filterType == 'doctor' || filterType == 'patient') {
                  _showFilterDialog(context);
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'all',
                child: Text('All'),
              ),
              PopupMenuItem<String>(
                value: 'doctor',
                child: Text('Doctor'),
              ),
              PopupMenuItem<String>(
                value: 'patient',
                child: Text('Patient'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddAppointmentDialog(); // Show the AddAppointmentDialog.
                },
              );
            },
            child: Text('Add Appointment'),
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('Doctor')),
              DataColumn(label: Text('Patient')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Time')),
              DataColumn(label: Text('Action')),
            ],
            rows: appointments
                .where((appointment) {
                  switch (filterType) {
                    case 'doctor':
                      return appointment.doctor.name.toLowerCase() == searchQuery.toLowerCase();
                    case 'patient':
                      return appointment.patient.name.toLowerCase() == searchQuery.toLowerCase();
                    default:
                      return true;
                  }
                })
                .map(
                  (appointment) => DataRow(
                    cells: [
                      DataCell(Text(appointment.doctor.name)),
                      DataCell(Text(appointment.patient.name)),
                      DataCell(Text(appointment.appointmentDateTime.toString().split(' ')[0])),
                      DataCell(Text(appointment.appointmentDateTime.toString().split(' ')[1].substring(0, 5))),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            appointmentProvider.deleteAppointment(appointment.id);
                          },
                          child: Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
