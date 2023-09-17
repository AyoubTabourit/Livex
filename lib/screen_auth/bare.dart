import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:livex/screen_auth/livrer.dart';
import 'package:livex/screen_auth/NavBar.dart';
import 'package:livex/screen_auth/ramassage.dart';
import 'package:livex/screen_auth/command.dart';
import 'package:livex/screen_auth/mon_compte.dart';
import 'package:livex/screen_auth/home.dart';
import 'package:livex/screen_auth/sign_in.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class admin1 extends StatefulWidget {
  @override
  admin1State createState() => admin1State();
}

class admin1State extends State<admin1> {
  void initState(){


      super.initState();
      NavBare();

    }


  alo(int page) {
    if (page == 0) {
      return HomeScreen();
    }
    if (page == 1) {
      return livrer();
    }

    if (page == 2) {
      return ramassage();
    }

    if (page == 3) {
      return command();
    }

    if (page == 4) {
      return account();
    }

  }

  int page = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBare(),

        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.airplane_ticket, color: Colors.white),
            Icon(Icons.delivery_dining, color: Colors.white),
            Icon(Icons.shopping_cart, color: Colors.white),
            Icon(Icons.person, color: Colors.white),
          //  Icon(Icons.logout, color: Colors.white),
          ],
          color: Colors.blue,
          buttonBackgroundColor: Color(0xFF808080),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 1000),
          onTap: (index) {
            setState(() {
              page = index;

            });
          },
        ),
        body: alo(page));
  }
}
@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

