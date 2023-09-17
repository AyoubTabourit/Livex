import 'package:flutter/material.dart';
import 'package:livex/screen_auth/NavBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
class livrer extends StatefulWidget {
  const livrer({super.key});

  @override
  State<livrer> createState() => _livrerState();
}

class _livrerState extends State<livrer> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Envoyer colis"),

        ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value==null ||value.isEmpty) {
                    return 'Veuillez saisir votre nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value==null ||value.isEmpty) {
                    return 'Veuillez saisir votre prénom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Ville'),
                validator: (value) {
                  if (value==null ||value.isEmpty) {
                    return 'Veuillez indiquer votre ville';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  if (value==null ||value.isEmpty) {
                    return 'Veuillez saisir votre adresse';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                if (value==null ||value.isEmpty) {
                  return 'Veuillez saisir votre Description ';
                }
                return null;
              },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantité'),
                keyboardType: TextInputType.number,  validator: (value) {
                if (value==null ||value.isEmpty) {
                  return 'Veuillez saisir la Quantite';
                }
                return null;
              },
              ),
              ListTile(
                title: Text("Date de sélection: ${_selectedDate.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&_formKey.currentState!.validate()) {
                    // Le formulaire est valide, vous pouvez traiter les données ici.
                    // Vous pouvez accéder aux valeurs comme ceci :
                    // _nameController.text, _lastNameController.text, ...
                    Fluttertoast.showToast(
                        msg: "Succes donne",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),



    );
  }
}
