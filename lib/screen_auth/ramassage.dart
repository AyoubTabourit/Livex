import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livex/screen_auth/NavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

var finalEmail;
class ramassage extends StatefulWidget {
  const ramassage({super.key});

  @override
  State<ramassage> createState() => _ramassageState();
}

class _ramassageState extends State<ramassage> {
  final _formKey = GlobalKey<FormState>();
  //String? userId;
  int finaluser =0 ;
  TextEditingController telephoneController = TextEditingController();

  TextEditingController _addressController = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController montantController = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  final TextEditingController date1Controller = TextEditingController(
      text: "${DateTime.now().toLocal()}".split(" ")[0],);
  @override
  void initState() {//fetchUserData();
    super.initState();
    getvalidationdata().whenComplete(() {
      fetcheid();
      fetchUserData();
      fetcheid();
      fetchUserData();// Call fetchData here

    });


  }

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



  Future getvalidationdata() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    var obtainedEmail = sharedpreferences.getString('share_email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  //List<Map<String, dynamic>> userData = [];


  Future<void> fetcheid() async {
    final response = await http.post(
        Uri.parse('http://20.20.1.245:82/api_store/user_id.php'),
        body: {'user_email': finalEmail});
    if (response.statusCode == 200) {
      setState(() {
        finaluser = int.parse(response.body);
      });
    } else {
      setState(() {
        finaluser = int.parse("No records found");
      });
    }
  }
  Future<void> fetchUserData() async {
    final response = await http.post(
      Uri.parse('http://20.20.1.245:82/api_store/afficheR.php'),
      body: {'user_email': finalEmail},
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      if (userData.isNotEmpty) {
        final user = userData[0];
        setState(() {
          _addressController.text = user['Adress'];
          telephoneController.text = user['phone'];

        });
      }
    } else {
      print('Failed to fetch user data');
    }
  }
  Future ramassage() async{//date1controller.text="${_selectedDate.toLocal()}".split(' ')[0];
    var url ="http://20.20.1.245:82/api_store/ramassage.php";
    final response = await http.post(Uri.parse(url),body:{


      'number': telephoneController.text,

      'adress_rmg': _addressController.text,
      'date_rmg' :  "${_selectedDate.toLocal()}".split(" ")[0],
      'dateR_now' : date1Controller.text,
      'user_id_vend' : finaluser.toString(),


    },
    );

    var data =json.decode(response.body);
    if(data!="sucess"){
      Fluttertoast.showToast(
          msg: "Veuillez vous ésseyer ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );


    }else{

      Fluttertoast.showToast(
          msg: "Votre demande Ramassage à été envoyer ",
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
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Demande Ramassage"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[

              TextFormField(readOnly: true,
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Adress Ramassage'),

              ),
              TextFormField(readOnly: true,
                controller: telephoneController,
                decoration: InputDecoration(labelText: 'Téléphone'),
                keyboardType: TextInputType.number,

              ),
              TextFormField(readOnly: true,
                controller:date1Controller ,

                decoration: InputDecoration(labelText: "${_selectedDate.toLocal()}".split(" ")[0]),
                //keyboardType: TextInputType.number,

              ),ListTile(
                title: TextFormField(readOnly: true,controller:datecontroller ,
                  decoration: InputDecoration(labelText: "Date Ramassage ", border: InputBorder.none, )),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${_selectedDate.toLocal()}".split(" ")[0],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
                onTap: () => _selectDate(context),
              ),SizedBox(height: 20,),



              ElevatedButton(
                onPressed: () {
                  ramassage();
                 // fetchUserData();
                 print('$finaluser');
                 print('$finalEmail');
                }, style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
              ),
                child: Text('Demande Ramassage'),
              ),
              SizedBox(height: 30,),
              Text('Si vous voulez changer vos informations acceder à votre profil ')
            ],
          ),
        ),
      ),



    );
  }
}
