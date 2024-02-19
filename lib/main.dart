import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the Provider package.
import 'package:medical_management/providers/specialty_provider.dart'; // Import the SpecialtyProvider.
import 'package:medical_management/providers/person_provider.dart'; // Import the PersonProvider.
import 'package:medical_management/providers/appointment_provider.dart'; // Import the AppointmentProvider.
import 'package:medical_management/providers/record_provider.dart'; // Import the RecordProvider.
import 'package:medical_management/screens/welcome_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpecialtyProvider()), // Provide the SpecialtyProvider.
        ChangeNotifierProvider(create: (_) => PersonProvider()), // Provide the PersonProvider.
        ChangeNotifierProvider(create: (_) => AppointmentProvider()), // Provide the AppoinmentProvider.
        ChangeNotifierProvider(create: (_) => RecordProvider()), // Provide the RecordProvider.
        // You can add more providers for other data as needed.
      ],
      child: MaterialApp(
        home: WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
