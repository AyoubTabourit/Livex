import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:livex/screen_auth/sign_in.dart';
import 'package:http/http.dart'as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livex/screen_auth/command.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:livex/screen_auth/testbuild.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavBar.dart';

class livrer extends StatefulWidget {
  const livrer({super.key});

  @override
  State<livrer> createState() => _livrerState();
}

class _livrerState extends State<livrer> {


  String? finalEmail;
  String? userId;

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  Future<void> getValidationData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final obtainedEmail = sharedPreferences.getString('share_email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
    if (finalEmail != null) {
      // Call the getUserId function if finalEmail is not null
      getUserId(finalEmail!);
    }
  }

  Future<void> getUserId(String userEmail) async {
    final response = await http.post(
      Uri.parse('http://20.20.1.245:82/api_store/user_id.php'),
      body: {'user_email': userEmail},
    );

    if (response.statusCode == 200) {
      setState(() {
        userId = response.body;
      });
      print('User ID: $userId');
    } else {
      print('Failed to retrieve user ID');
    }
  }
  Future<void> saveUserId(int userId) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('id', userId);
  }

  /*Future<void> loadSharedPreferences() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    sharedpreferences.setString('userid',finaluser.toString());

  }*/


  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController commController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Future envoyer() async{
    var url ="http://20.20.1.245:82/api_store/envoyer.php";
    final response = await http.post(Uri.parse(url),body:{
      'dmd_id':userId,
      'full_name_cl' : _nameController.text,
      'numero_client': telephoneController.text,
      'ville': _cityController.text,
      'adress': _addressController.text,
      'commentaire' : commController.text,
      'prix' : montantController.text,
      'data_liv' : "${_selectedDate.toLocal()}".split(' ')[0],

    },
    );

    var data =json.decode(response.body);
    if(data!="sucess"){
      Fluttertoast.showToast(
          msg: "Veillez vous ésseyer ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


    }else{

      Fluttertoast.showToast(
          msg: "Votre demande à été envoyer ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => admin1(initialPageIndex: 3,)));

    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.day,
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
                decoration: InputDecoration(labelText: 'Nom et Prenom de Destinataire'),
                validator: (value) {
                  if (value==null ||value.isEmpty) {
                    return 'Veuillez saisir votre nom Complet';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: telephoneController,
                decoration: InputDecoration(labelText: 'Téléphone'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value==null ||value.isEmpty) {
                    return 'Veuillez saisir Téléphone de Destinataire';
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
                controller: montantController,
                decoration: InputDecoration(labelText: 'Montant'),
                keyboardType: TextInputType.number,  validator: (value) {
                if (value==null ||value.isEmpty) {
                  return 'Veuillez saisir Votre Montant';
                }
                return null;
              },
              ),
              ListTile(
                title: Text("${_selectedDate.toLocal()}".split(" ")[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&_formKey.currentState!.validate()) {
                    // Le formulaire est valide, vous pouvez traiter les données ici.
                    // Vous pouvez accéder aux valeurs comme ceci :
                    // _nameController.text, _lastNameController.text, ...
                    envoyer();

                  }else{
                    Fluttertoast.showToast(
                        msg: "Veuillez vous ésseyer ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
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
