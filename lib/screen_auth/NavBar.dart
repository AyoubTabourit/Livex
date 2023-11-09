import 'dart:convert';
import 'dart:async';
import 'package:livex/screen_auth/Reclamation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:livex/screen_auth/command.dart';
import 'package:livex/screen_auth/livrer.dart';
import 'package:livex/screen_auth/mon_compte.dart';
import 'package:livex/screen_auth/ramassage.dart';
import 'package:livex/screen_auth/sign_in.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var finalEmail;
var recup;
void main() {
  runApp(NavBar());
}

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavBare(),
    );
  }
}

class NavBare extends StatefulWidget {
  @override
  _MyNavBar createState() => _MyNavBar();
}

class _MyNavBar extends State<NavBare> {
  String finaluser = "";

  @override
  void initState() {
    getvalidationdata().whenComplete(() async {
      Timer(
          Duration(seconds: 2),
          () => Get.to(finalEmail == null
              ? singinscreen()
              : admin1(
                  initialPageIndex: 0,
                )));
      super.initState();
    });
    //super.initState();
    fetchUserName();
    //super.initState();
  }

  void _exitApp() {
    if (Platform.isAndroid) {
      exit(0); // This will exit the application on desktop platforms
    }
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

  List<Map<String, dynamic>> userData = [];


  Future<void> fetchUserName() async {
    final response = await http.post(
        Uri.parse('http://20.20.1.245:82/api_store/username.php'),
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
  Future<void> loadSharedPreferences() async {
    final SharedPreferences sharedpreferences =
    await SharedPreferences.getInstance();
    sharedpreferences.setString('share_user', finaluser);

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '$finaluser',
              style: TextStyle(
                color: Colors.black87, // Text color
                fontSize: 16.0, // Text size
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text('$finalEmail',
                style: TextStyle(
                  color: Colors.black87, // Text color
                  fontSize: 16.0, // Text size
                  fontWeight: FontWeight.bold,
                )),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/iconperso.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/capture.png')),
            ),
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Mon Compte'),
              onTap: () => {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => admin1(initialPageIndex: 4)))
                  }),
          ListTile(
            leading: Icon(Icons.add_box_rounded),
            title: Text('Envoyer un colis'),
            onTap: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => admin1(initialPageIndex: 1)))
            },
          ),
          Divider(),
          ListTile(
            //static const IconData delivery_dining_sharp = IconData(0xe8ba, fontFamily: 'MaterialIcons');
            leading: Icon(Icons.delivery_dining),
            title: Text('Ramassage'),
            onTap: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => admin1(initialPageIndex: 2)))
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Mes commandes'),
            onTap: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => admin1(initialPageIndex: 3)))
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.share),
              title: Text('Partager'),
              onTap: () => {
                    Share.share('com.example.livex'),
                  }),
          ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text('Réclamations'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => reclamation()));
            }
          ),
          Divider(),
          ListTile(
              title: Text('Déconnecter'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                //Navigator.pop(context);
                try {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('share_email');
                  SharedPreferences sharedPreferences1 =
                  await SharedPreferences.getInstance();
                  sharedPreferences1.remove('id');
                  SharedPreferences sharedPreferences2 =
                  await SharedPreferences.getInstance();
                  sharedPreferences.remove('email');
                  await SharedPreferences.getInstance();
                  sharedPreferences.remove('id_livre');
                  _exitApp();

                } catch (e) {
                  print('Error deleting key: $e');
                }
              }),
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
