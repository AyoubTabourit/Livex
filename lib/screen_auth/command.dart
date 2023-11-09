import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:livex/screen_auth/edit_command.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavBar.dart';

var finalEmail;
class command extends StatefulWidget {
  const command({Key? key});

  @override
  State<command> createState() => _TestState();
}

class _TestState extends State<command> {
  List<Map<String, dynamic>> jsD = [];
 // String? userId;
  String? id_livre;
  int finaluser = 0;
  @override
  void initState() {
    super.initState();
    getvalidationdata().whenComplete(() {
      fetcheid();
      fetchData(); // Call fetchData here
    });
  }


  Future getvalidationdata() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    var obtainedEmail = sharedpreferences.getString('share_email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

 // List<Map<String, dynamic>> userData = [];


  Future<void> fetcheid() async {
    final response = await http.post(
        Uri.parse('http://20.20.1.245:82/api_store/user_id.php'),
        body: {'user_email': finalEmail});
    if (response.statusCode == 200) {
      setState(() {
        String responseBody =response.body.toString();
        finaluser =int.parse(responseBody);
      });
    } else {
      setState(() {
        finaluser = int.parse("No records found");
      });
    }
  }
  Future<void> fetchData() async {
    final response = await http.post(Uri.parse('http://20.20.1.245:82/api_store/commande.php'), body: {
      'user_email': finalEmail
    });
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        jsD = List<Map<String, dynamic>>.from(responseData);

      });
    } else {
      print('Erreur de requête: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Mes Commande'),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: jsD.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      _showAddOptionDialog(context, index);
                    },
                    title: Text('Nom: ${jsD[index]["full_name_cl"]}'),
                    subtitle: Text('Ville: ${jsD[index]["ville"]}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Future<void> supp(String id_livre) async {
    final response = await http.post(
      Uri.parse('http://20.20.1.245:82/api_store/delete_colis.php'),
      body: {'id_livre': id_livre},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == 'valide') {
        // Deletion successful
        print('Record deleted successfully.');
      } else {
        // Deletion failed
        print('Error: Record deletion failed.');
      }
    } else {
      // HTTP request failed
      print('Error: HTTP request failed.');
    }
  }



  void _showAddOptionDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            constraints: BoxConstraints(
              minWidth: 350,
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  'Détails Colis',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Adress: ${jsD[index]["adress"]}',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  'Telephone: ${jsD[index]["numero_client"]}',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  'Prix: ${jsD[index]["prix"]}',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async { id_livre=jsD[index]["id_livre"];
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setInt('selectedId', int.parse(id_livre.toString()));
                        print('$id_livre');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>edit()));
                      },
                      child: Text(
                        'Modifier',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                       id_livre=jsD[index]["id_livre"];
                        supp('$id_livre');
                       print(id_livre);
                       setState(() {
                         fetchData();
                       });



                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Set the background color here
                      ),
                      child: Container(
                        color: Colors.red, // Set the background color here
                        child: Text(
                          'Supprime',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: command(),
  ));
}
