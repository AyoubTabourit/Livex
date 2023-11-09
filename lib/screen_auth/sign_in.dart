import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:livex/screen_auth/home.dart';
import 'package:livex/screen_auth/testbuild.dart';
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
  const singinscreen({Key? key}) : super(key: key);

  @override
  State<singinscreen> createState() => _singinscreenState();
}

class _singinscreenState extends State<singinscreen> {

  Future<void> setEmailPreference(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('share_email',email);
  }

  TextEditingController passwordtextcontroller = TextEditingController();
  TextEditingController emailtextcontroller = TextEditingController();


  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Vous n'avez pas compte?"),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SingUpScreen())); //redirection
          },
          child: const Text(
            " S'inscrire ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Future login() async {
    var url = "http://20.20.1.245:82/api_store/login.php";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_email': emailtextcontroller.text,
        'user_pass': passwordtextcontroller.text,
      },
    );

    var data = json.decode(response.body);
    if (data == "valide") {
      setEmailPreference(emailtextcontroller.text);
      Fluttertoast.showToast(
          msg: "Connecté avec succès",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => admin1(initialPageIndex: 0,)));



    } else {
      Fluttertoast.showToast(
          msg: "Mail ou mot de passe incorrect ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
            gradient: LinearGradient(colors: [
          hexStringTocolor("1e90ff"),
          hexStringTocolor("1e90ff"),
          hexStringTocolor("1e90ff")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/capture.png',
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 30,
              ),TextField(
                  controller: emailtextcontroller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  decoration: InputDecoration(prefixIcon:Icon(Icons.numbers_outlined, color: Colors.white70,) ,
                    labelText: "Adresse courrier",
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
                  ),
                  keyboardType: TextInputType.emailAddress

              ),
              SizedBox(
                height: 30,
              ),
              reusableTextField("Mot de passe", Icons.lock_outline, true,
                  passwordtextcontroller),
              SizedBox(
                height: 30,
              ),
              signInSignUpButton(context, true, () {
                if (emailtextcontroller.text == "" ||
                    passwordtextcontroller.text == "") {
                  Fluttertoast.showToast(
                      msg: "Veuillez remplir les champs ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {

//loademail();


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
} //class

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
