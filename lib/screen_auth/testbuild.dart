import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

var finaluser;

class test extends StatefulWidget {
  const test({Key? key});

  @override
  State<test> createState() => _TestState();
}

class _TestState extends State<test> {
  List<Map<String, dynamic>> jsD = [];

  @override
  void initState() {
    super.initState();
    getuserdata().whenComplete(() async {
      fetchData();
    });
    fetchidName();
  }

  Future getuserdata() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    var obtainedEmail = sharedpreferences.getString('email');
    setState(() {
      finaluser = obtainedEmail;
    });
    print(finaluser);
  }

  Future<void> fetchidName() async {
    var url = "http://127.0.0.1:82/api_store/user_id.php";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_email': finaluser,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        finaluser = response.body;
      });
    } else {
      setState(() {
        finaluser = "No records found";
        print(finaluser);
      });
    }
  }

  Future<void> fetchData() async {
    final response = await http.post(Uri.parse('http://20.20.1.245:82/api_store/commande.php'), body: {
      'user_id': finaluser
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Annuler',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 10),
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
    home: test(),
  ));
}
