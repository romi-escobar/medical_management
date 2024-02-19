import 'package:flutter/material.dart';
import 'package:medical_management/providers/person_provider.dart';
import 'package:medical_management/models/person.dart';
import 'package:medical_management/widgets/read_person_dialog.dart';
import 'package:provider/provider.dart';
import 'package:medical_management/widgets/add_person_dialog.dart';
import 'package:medical_management/widgets/edit_person_dialog.dart';

class PersonScreen extends StatefulWidget {
  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  String filterType = '';

  void _showAddPersonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddPersonDialog(
          onAdd: (String newName, String newLastName, String newTelephone, String newEmail, String newCedula, bool newIsDoctor) {
            final personProvider = Provider.of<PersonProvider>(context, listen: false);

            final newPerson = Person(
              id: personProvider.people.length + 1,
              name: newName,
              lastName: newLastName,
              telephone: newTelephone,
              email: newEmail,
              cedula: newCedula,
              isDoctor: newIsDoctor,
            );

            personProvider.addPerson(newPerson);
          },
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter by Name'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                filterType = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter name or last name',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
    final personProvider = Provider.of<PersonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('People Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                filterType = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'all',
                child: Text('All'),
              ),
              PopupMenuItem<String>(
                value: 'doctors',
                child: Text('Doctors'),
              ),
              PopupMenuItem<String>(
                value: 'patients',
                child: Text('Patients'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: personProvider.people.length,
        itemBuilder: (context, index) {
          final person = personProvider.people[index];

          if ((filterType.isEmpty ||
                  (filterType == 'doctors' && person.isDoctor) ||
                  (filterType == 'patients' && !person.isDoctor) ||
                  (person.name.toLowerCase().contains(filterType.toLowerCase()) ||
                      person.lastName.toLowerCase().contains(filterType.toLowerCase())))) {
            return ListTile(
              title: Text(person.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      final selectedPerson = personProvider.getPersonById(person.id);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ReadPersonDialog(person: selectedPerson);
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return EditPersonDialog(
                            currentName: person.name,
                            currentLastName: person.lastName,
                            currentTelephone: person.telephone,
                            currentEmail: person.email,
                            currentCedula: person.cedula,
                            currentIsDoctor: person.isDoctor,
                            onEdit: (String newName, String newLastName, String newTelephone, String newEmail, String newCedula, bool newIsDoctor) {
                              final personProvider = Provider.of<PersonProvider>(context, listen: false);

                              personProvider.editPerson(
                                person.id,
                                newName,
                                newLastName,
                                newTelephone,
                                newEmail,
                                newCedula,
                                newIsDoctor,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      personProvider.deletePerson(person.id);
                    },
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPersonDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

