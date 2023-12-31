import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:livex/utilis/colors_utilis.dart';
import 'package:livex/reusable_widgets/reusable_widget.dart';
import 'package:livex/screen_auth/sign_in.dart';
import 'package:livex/screen_auth/home.dart';
import 'package:http/http.dart' as http;
import 'package:livex/api_cnx/api_cnx.dart';
import 'package:mysql1/mysql1.dart';


class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}): super(key:key);

  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController passwordtextcontroller = TextEditingController();
  TextEditingController emailtextcontroller = TextEditingController();
  TextEditingController usertextcontroller = TextEditingController();
  TextEditingController telcontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  TextEditingController txtobli = TextEditingController();
  TextEditingController ee = TextEditingController();



  Future register() async{
    var url ="http://20.20.1.245:82/api_store/register.php";
    final response = await http.post(Uri.parse(url),body:{
      'user_name' : usertextcontroller.text,
      'user_email': emailtextcontroller.text,
      'user_pass': passwordtextcontroller.text,
      'phone': telcontroller.text,
      'Adress' : adresscontroller.text,
      'user_role': "client",

    },
    );

    var data =json.decode(response.body);
    if(data=="error"){
      Fluttertoast.showToast(
          msg: "Ce compte déja éxiste",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Votre compte à été crée avec succer",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => singinscreen()));
    }
  }

  Future verifier()async{
  var url ="http://20.20.1.245:82/api_store/user/validate_email.php";
  final response = await http.post(Uri.parse(url),body:{

  'user_email': emailtextcontroller.text,


  });
  var data =json.decode(response.body);
  if(data=="kyn"){
    Fluttertoast.showToast(
        msg: "Veuillez vous saisir un autre Email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
  else{
  register();
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:const Text("Création de compte",
        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:  [hexStringTocolor("1e90ff"),
            hexStringTocolor("1e90ff"),
            hexStringTocolor("1e90ff")
          ],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
            children: <Widget>[

              const SizedBox(
                height: 20,
              ),
              reusableTextField("Votre nom d'utilisateur*",Icons.person_outline, false, usertextcontroller,),
              const SizedBox(
                height: 20,
              ),TextField(
              controller: emailtextcontroller,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white.withOpacity(0.9)),
              decoration: InputDecoration(prefixIcon:Icon(Icons.numbers_outlined, color: Colors.white70,) ,
                labelText: "Votre adresse électronique*",
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
              ),
              keyboardType: TextInputType.emailAddress

          ),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Votre mot de passe*", Icons.lock_outline, true, passwordtextcontroller,),

              const SizedBox(
                height: 20,
              ),

              //reusableTextField("Votre numéro de téléphone*", Icons.numbers_outlined, false, telcontroller,),
TextField(
  controller: telcontroller,
  cursorColor: Colors.white,
  style: TextStyle(color: Colors.white.withOpacity(0.9)),
  decoration: InputDecoration(prefixIcon:Icon(Icons.numbers_outlined, color: Colors.white70,) ,
    labelText: "Votre numéro de téléphone*",
    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.white.withOpacity(0.3),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
  ),
  keyboardType: TextInputType.number

),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Votre adresse*", Icons.edit_location, false, adresscontroller),
              const SizedBox(
                height: 30,
              ),
              signInSignUpButton(context, false,(){
              if(emailtextcontroller.text==""||passwordtextcontroller.text==""||telcontroller.text==""||adresscontroller.text==""||usertextcontroller.text==""){
                Fluttertoast.showToast(
                    msg: "Veuillez remplir les champs",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }else{
                verifier();
              }




              }),SizedBox(height: 20,),
               //txtsimple("*Champs obligatoires", txtobli),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 1.0),
                  child: Text(
                    '*Champs obligatoires',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        color: Colors.black87),
                  ),
                ),
              ),



             


            ],
        ),
          ),
        ),
      ),
      );

  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

