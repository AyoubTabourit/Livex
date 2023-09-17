import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:livex/screen_auth/sign_in.dart';
import 'package:livex/screen_auth/FabTabs.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
var finalEmail;
var recup;
void main() {
  runApp(NavBar ());
}

class NavBar  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavBare (),
    );
  }
}

class NavBare  extends StatefulWidget {
  @override
  _MyNavBar  createState() => _MyNavBar ();
}

class _MyNavBar  extends State<NavBare> {
  String finaluser="";
  @override
  void initState(){

    getvalidationdata().whenComplete(() async{
      Timer(Duration(seconds: 2),()=> Get.to(finalEmail==null ? singinscreen(): admin1()));
      super.initState();

    });
    super.initState();
    fetchUserName();
    super.initState();
  }
  void _exitApp() {
    if (Platform.isAndroid) {
      exit(0); // This will exit the application on desktop platforms
    }
  }
  Future getvalidationdata() async{
    final SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    var obtainedEmail= sharedpreferences.getString('share_email');
    setState((){
      finalEmail=obtainedEmail;
    });
print(finalEmail);
  }
  List<Map<String, dynamic>> userData = [];

  Future<void> fetchUserName() async {
    final response = await http.post(Uri.parse('http://192.168.1.4:82/api_store/username.php'),body: {'user_email':finalEmail});
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('$finaluser'),
            accountEmail: Text('$finalEmail'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
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
                  image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),ListTile(
            leading: Icon(Icons.person),
            title: Text('Mon Compte'),
            onTap: () =>
              {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FabTabs(selectedIndex:4)))}

          ),
          ListTile(
            leading: Icon(Icons.add_box_rounded),
            title: Text('Envoyer un colis'),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FabTabs(selectedIndex:1)))
            },
          ),  Divider(),
          ListTile(
            //static const IconData delivery_dining_sharp = IconData(0xe8ba, fontFamily: 'MaterialIcons');
            leading: Icon(Icons.delivery_dining),
            title: Text('Ramassage'),
            onTap: () => {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FabTabs(selectedIndex:2)))},
          ),Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Mes commandes'),
            onTap: () => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FabTabs(selectedIndex:3)))
            },
          ),Divider(),
          ListTile(
              leading: Icon(Icons.share),
              title: Text('Partager'),
              onTap: () => {
                null,
              }),ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text('Réclamations'),
            onTap: () => null,
          ), Divider(),
          ListTile(
              title: Text('Quitter'),
              leading: Icon(Icons.exit_to_app),
              onTap: () => {_exitApp()








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

