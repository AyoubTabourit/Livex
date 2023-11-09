import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:livex/screen_auth/NavBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:shared_preferences/shared_preferences.dart';
var finalEmail;
class reclamation extends StatefulWidget {
  const reclamation({super.key});

  @override
  State<reclamation> createState() => _reclamationState();
}

class _reclamationState extends State<reclamation> {
  final _formKey = GlobalKey<FormState>();
 // String? userId;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController objectcontroller = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
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
  String finaluser = "";
  @override
  void initState() {
    super.initState();
    getvalidationdata().whenComplete(() {
      fetcheid();

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
        finaluser = response.body;
      });
    } else {
      setState(() {
        finaluser = "No records found";
      });
    }
  }

  Future envoyer() async{
    var url ="http://20.20.1.245:82/api_store/reclamation.php";
    final response = await http.post(Uri.parse(url),body:{
       'date' : "${_selectedDate.toLocal()}".split(" ")[0],
      'message' : _descriptionController.text,
      'objet': objectcontroller.text,
      'user': finaluser,



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



    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
drawer: NavBare(),
      appBar: AppBar(
      title: Text('Reclamation'),
    ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
            TextFormField(readOnly: true,
            controller:datecontroller ,
            decoration: InputDecoration(labelText: "${_selectedDate.toLocal()}".split(" ")[0]),
            ),

              TextFormField(
                controller: objectcontroller,
                decoration: InputDecoration(labelText: 'Objectif'),
                validator: (value) {
                  if (value==null ||value.isEmpty) {
                    return 'Veuillez saisir votre Objectif';
                  }
                  return null;
                },
              ),SizedBox(height:20,),
              Container(
                height: 80, // Set the desired height here
                child: TextFormField(minLines: 2,maxLines: 6,keyboardType: TextInputType.multiline,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Votre Réclamation',
                    border: OutlineInputBorder(),
                  ), //maxLength: null,
                 // keyboardType: TextInputType.multiline,// Set the maximum number of characters here
               //   maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre Réclamation';
                    }
                    return null;
                  },
                ),
              ),



              ElevatedButton(
                onPressed: () {
                  if(_descriptionController.text==""||objectcontroller.text==""){
                    Fluttertoast.showToast(
                        msg: "Veillez vous saisir les information  ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );

                  }else{
                    envoyer();
                  }

                //  envoyer();
                  print('$finaluser');
                  },
                child: Text('Poster'),
              ),
            ],
          ),
        ),
      ),



    );
  }
}
