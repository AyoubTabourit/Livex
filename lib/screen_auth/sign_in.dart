import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:livex/screen_auth/home.dart';
import 'package:livex/utilis/colors_utilis.dart';
import 'package:livex/reusable_widgets/reusable_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:livex/api_cnx/api_cnx.dart';
import 'package:mysql1/mysql1.dart';
import 'package:livex/screen_auth/sign_up.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:shared_preferences/shared_preferences.dart';



class singinscreen extends StatefulWidget {
  const singinscreen({Key? key}): super(key:key);

  @override
  State<singinscreen> createState() => _singinscreenState();
}

class _singinscreenState extends State<singinscreen> {
  TextEditingController passwordtextcontroller=TextEditingController();
  TextEditingController emailtextcontroller=TextEditingController();
  Future<void> loadSharedPreferences() async {
    final SharedPreferences sharedpreferences= await SharedPreferences.getInstance();
    sharedpreferences.setString('share_email', emailtextcontroller.text);
  }
  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Vous n'avez pas compte?"),
        GestureDetector(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SingUpScreen()));//redirection
        },
          child: const Text(
            " S'inscrire ",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
  Future login() async{
    var url ="http://192.168.1.4:82/api_store/login.php";
    final response = await http.post(Uri.parse(url),body:{
      'user_email': emailtextcontroller.text,
      'user_pass': passwordtextcontroller.text,
    },
    );

    var data =json.decode(response.body);
    if(data=="valide"){
      Fluttertoast.showToast(
          msg: "Connecté avec succès",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder:(context)=>admin1()));
  }else{
      Fluttertoast.showToast(
          msg: "Mail ou mot de passe incorrect ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      //Navigator.push(context, MaterialPageRoute(builder:(context)=>SingUpScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:
              [hexStringTocolor("1e90ff"),
              hexStringTocolor("1e90ff"),
              hexStringTocolor("1e90ff")
              ],begin:Alignment.topCenter,end:Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
           padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20, 0),
            child: Column(
              children: <Widget>[Image.asset('assets/images/capture.png', fit: BoxFit.contain,),

              SizedBox(height: 30,),reusableTextField("Adresse courrier", Icons.person_outline, false, emailtextcontroller),
              SizedBox(height: 30,),reusableTextField("Mot de passe", Icons.lock_outline, true, passwordtextcontroller),
                SizedBox(height: 30,),signInSignUpButton(context, true, (){
                  if(emailtextcontroller.text==""||passwordtextcontroller.text==""){ Fluttertoast.showToast(
                      msg: "Veuillez remplir les champs ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );}else{
                    loadSharedPreferences();


                    login();


                  }

                }),

                signUpOption()
              ],

            ),
          )),
        ),
    );
  }



}//class

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

