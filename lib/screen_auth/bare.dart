import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:livex/screen_auth/afficher_detaille_colislivrer.dart';
import 'package:livex/screen_auth/home.dart';
import 'package:livex/screen_auth/livrer.dart';
import 'package:livex/screen_auth/ramassage.dart';
import 'package:livex/screen_auth/command.dart';
import 'package:livex/screen_auth/mon_compte.dart';
import 'package:livex/screen_auth/NavBar.dart';
import 'package:livex/screen_auth/testbuild.dart';

class admin1 extends StatefulWidget {
  final int initialPageIndex; // Initial page index

  admin1({required this.initialPageIndex});

  @override
  _Admin1State createState() => _Admin1State();
}

class _Admin1State extends State<admin1> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPageIndex; // Set the initial page index
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index; // Update the current page index
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentPage,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.airplane_ticket, color: Colors.white),
          Icon(Icons.delivery_dining, color: Colors.white),
          Icon(Icons.shopping_cart, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        color: Colors.blue,
        buttonBackgroundColor: Color(0xFF808080),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 1000),
        onTap: (index) {
          setState(() {
            _currentPage = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }

  String getPageTitle(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return "Bienvenue sur Livex";
      case 1:
        return "Envoyer Colis";
      case 2:
        return "Demande Ramassage";
      case 3:
        return "Mes Commandes";
      case 4:
        return "Mon Compte";
      case 5:
        return "Détails colis Livre";
      default:
        return "Unknown Page";
    }
  }

  final List<Widget> _pages = [
    HomeScreen(),
    livrer(),
    ramassage(),
    command(),
    account(),
    afficher_detaille_colislivrer(),
  ];
}
