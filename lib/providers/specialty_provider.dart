import 'package:flutter/material.dart';
import 'package:medical_management/models/specialty.dart';

class SpecialtyProvider extends ChangeNotifier {
  List<Specialty> _specialties = [];

  List<Specialty> get specialties => _specialties;

  void addSpecialty(Specialty specialty) {
    _specialties.add(specialty);
    notifyListeners();
  }

  void editSpecialty(int id, String newName) {
    final specialty = _specialties.firstWhere((s) => s.id == id);
    specialty.name = newName;
    notifyListeners();
  }

  void deleteSpecialty(int id) {
    _specialties.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
