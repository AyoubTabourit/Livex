import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavBar.dart';

class edit extends StatefulWidget {
  const edit({super.key});

  @override
  State<edit> createState() => _editState();
}

int selectedId = 0;

class _editState extends State<edit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  @override
  void initState() {
    //fetchUserData();
    super.initState();
    email();
    loadPreferences().whenComplete(() {
      fetchUserData();});
  }

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? selectedIdValue = prefs.getInt('selectedId');
    selectedId = selectedIdValue ??
        1; // Utilisez 1 par défaut si selectedIdValue est null
  }

  Future<void> fetchUserData() async {
    final response = await http.post(
      Uri.parse('http://20.20.1.245:82/api_store/afficheC.php'),
      body: {'id_livre': selectedId.toString()},
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      if (userData.isNotEmpty) {
        final user = userData[0];
        userNameController.text = user['full_name_cl'];
        villeController.text = user['ville'];
        adressController.text = user['adress'];
        numController.text = user['numero_client'];
        prixController.text = user['prix'];
      }
    } else {
      print('Failed to fetch user data');
    }
  } Future email() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    var obtainedEmail = sharedpreferences.getString('share_email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  Future<void> saveData() async {
    final response = await http.post(Uri.parse('http://20.20.1.245:82/api_store/edit_com.php'), body: {
      'user_email': finalEmail,
      'full_name_cl': userNameController.text,
      'ville' : villeController.text,
      'adress' : adressController.text,
      'numero_client' : numController.text,
      'prix' :prixController.text,

    });
    var data = json.decode(response.body);
    if (data == "succes") {
      Fluttertoast.showToast(
          msg: "Votre information à été modifier",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print('Erreur de requête: ${response.statusCode}');
      Fluttertoast.showToast(
          msg: "Invalide",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBare(),
        appBar: AppBar(
          title: Text('Modifier colis'),
        ),

        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                        labelText: 'Nom et Prenom de Destinataire'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre nom Complet';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: villeController,
                    decoration: InputDecoration(labelText: 'ville'),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir Téléphone de Destinataire';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: adressController,
                    decoration: InputDecoration(labelText: 'adress'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez indiquer votre ville';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: numController,keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Numero client '),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre adresse';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: prixController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Prix'),

                    validator: (value) {
                      if (value == null ||
                          value.isEmpty) {
                        return 'Veuillez saisir le prix';
                      }
                      final double? number =
                      double.tryParse(value);
                      if (number == null || number <= 0) {
                        return 'Veuillez saisir un nombre supérieur à 0';
                      }
                      return null; // Return null to indicate no error
                    },
                  ),
                  ElevatedButton(onPressed: (){
                    saveData();
                    print('$selectedId');

                  }, child: Text('Validé')
                  )
                ],
              ),
            )
        )
    );
  }
}
