import 'package:flutter/material.dart';
import 'package:medical_management/providers/specialty_provider.dart'; // Import the SpecialtyProvider.
import 'package:medical_management/models/specialty.dart';
import 'package:medical_management/widgets/add_specialty_dialog.dart';
import 'package:medical_management/widgets/edit_specialty_dialog.dart';
import 'package:provider/provider.dart';

class SpecialtyScreen extends StatefulWidget {
  @override
  _SpecialtyScreenState createState() => _SpecialtyScreenState();
}

class _SpecialtyScreenState extends State<SpecialtyScreen> {
  void _showAddSpecialtyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddSpecialtyDialog(
          onAdd: (String newName) {
            // Access the SpecialtyProvider using Provider.of.
            final specialtyProvider = Provider.of<SpecialtyProvider>(context, listen: false);

            // Generate a unique id for the new specialty
            final newSpecialty = Specialty(
              id: specialtyProvider.specialties.length + 1, 
              name: newName,
            );

            // Call the addSpecialty method from the provider.
            specialtyProvider.addSpecialty(newSpecialty);

            // No need to manually refresh the UI; Provider handles that for you.
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Specialties')),
      body: ListView.builder(
        itemCount: Provider.of<SpecialtyProvider>(context).specialties.length,
        itemBuilder: (context, index) {
          final specialty = Provider.of<SpecialtyProvider>(context).specialties[index];
          return ListTile(
            title: Text(specialty.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Show an edit dialog and call editSpecialty from the provider.
                    // You can use a TextEditingController to edit the name.
                    // Provider will automatically update the UI.
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditSpecialtyDialog(
                          currentName: specialty.name, // Provide the current name to the dialog.
                          onEdit: (String newName) {
                            final specialtyProvider = Provider.of<SpecialtyProvider>(context, listen: false);

                            // Call the editSpecialty method from the provider.
                            specialtyProvider.editSpecialty(specialty.id, newName);

                            // No need to manually refresh the UI; Provider handles that for you.
                          },
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Show a confirmation dialog and call deleteSpecialty from the provider.
                    final specialtyProvider = Provider.of<SpecialtyProvider>(context, listen: false);

                    // Call the deleteSpecialty method from the provider.
                    specialtyProvider.deleteSpecialty(specialty.id);

                    // No need to manually refresh the UI; Provider handles that for you.
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSpecialtyDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
