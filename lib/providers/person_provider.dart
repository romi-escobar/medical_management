import 'package:flutter/material.dart';
import 'package:medical_management/models/person.dart';

class PersonProvider extends ChangeNotifier {
  List<Person> _people = [];  // List of people (doctors and patients)

  List<Person> get people => _people;
  List<Person> get doctors => _people.where((person) => person.isDoctor).toList();
  List<Person> get patients => _people.where((person) => !person.isDoctor).toList();

  void addPerson(Person person) {
    _people.add(person);
    notifyListeners();
  }

  Person getPersonById(int id) {
    return _people.firstWhere((person) => person.id == id);
  }

  Person getPersonByName(String name) {
  return _people.firstWhere((person) => person.name == name);
  }

  List<Person> getPeopleByNameOrLastName(String query) {
    return _people
      .where((person) =>
          person.name.contains(query) || person.lastName.contains(query))
      .toList();
  }

  void editPerson(int id, String newName, String newLastName, String newTelephone, String newEmail, String newCedula, bool newIsDoctor) {
    final person = _people.firstWhere((p) => p.id == id);
    person.name = newName;
    person.lastName = newLastName;
    person.telephone = newTelephone;
    person.email = newEmail;
    person.cedula = newCedula;
    person.isDoctor = newIsDoctor;

    notifyListeners();
  }

  void deletePerson(int id) {
    _people.removeWhere((person) => person.id == id);
    notifyListeners();
  }
}
