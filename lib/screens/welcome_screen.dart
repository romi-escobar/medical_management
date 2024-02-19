// welcome_screen.dart

import 'package:flutter/material.dart';
import 'specialty_screen.dart'; // Import the SpecialtyScreen
import 'person_screen.dart'; // Import the PersonScreen
import 'appointment_screen.dart'; // Import the AppointmentScreen
import 'record_screen.dart'; // Import the RecordScreen

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpecialtyScreen()),
                );
              },
              child: Text('Specialties'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonScreen()),
                );
              },
              child: Text('People'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentScreen()),
                );
              },
              child: Text('Appointments'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordScreen()),
                );
              },
              child: Text('Records'),
            ),
          ],
        ),
      ),
    );
  }
}
