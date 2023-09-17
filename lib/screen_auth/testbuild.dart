import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:livex/screen_auth/NavBar.dart';
import 'package:livex/screen_auth/bare.dart';

import 'package:livex/screen_auth/livrer.dart';
import 'package:livex/screen_auth/ramassage.dart';
import 'package:livex/screen_auth/command.dart';
import 'package:livex/screen_auth/mon_compte.dart';
import 'package:livex/screen_auth/home.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class aa extends StatefulWidget {
  @override
  admin1State createState() => admin1State();
}

class admin1State extends State<aa> {
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
      drawer:Drawer(
        child: Column(
          children: [
            NavBare(),
            admin1(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Bienvenue sur LIVEX"),

      ),

        );
  }
}
