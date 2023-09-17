import 'package:livex/screen_auth/command.dart';
import 'package:livex/screen_auth/home.dart';
import 'package:livex/screen_auth/livrer.dart';
import 'package:livex/screen_auth/mon_compte.dart';
import 'package:livex/screen_auth/ramassage.dart';
import 'package:flutter/material.dart';

class FabTabs extends StatefulWidget {
  int selectedIndex = 0;
  FabTabs({required this.selectedIndex});

  @override
  State<FabTabs> createState() => _FabTabsState();
}

class _FabTabsState extends State<FabTabs> {
  int currentIndex = 0;

  void onItemTapped(int index){
    setState(() {
      widget.selectedIndex = index;
      currentIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    onItemTapped(widget.selectedIndex);
    // TODO: implement initState
    super.initState();
  }

  final List<Widget> pages = [
    HomeScreen(),
    ramassage(),
    livrer(),
    account(),
    command()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    Widget currentScreen = currentIndex == 0 ? HomeScreen() : currentIndex == 1 ? livrer() :currentIndex == 2 ?ramassage() : currentIndex==3 ?command():account();
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: (){
                      setState(() {
                        currentScreen = HomeScreen();
                        currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: currentIndex == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(color: currentIndex == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: (){
                      setState(() {
                        currentScreen = livrer();
                        currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.airplane_ticket,
                          color: currentIndex == 1 ? Colors.blueAccent : Colors.grey,
                        ),
                        Text(
                          "Envoyer",
                          style: TextStyle(color: currentIndex == 1 ? Colors.blueAccent : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: (){
                      setState(() {
                        currentScreen = ramassage();
                        currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          color: currentIndex == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Ramassage",
                          style: TextStyle(color: currentIndex == 2 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: (){
                      setState(() {
                        currentScreen = command();
                        currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                      Icons.shopping_cart,
                      color: currentIndex == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Commande",
                          style: TextStyle(color: currentIndex == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: (){
                      setState(() {
                        currentScreen = account();
                        currentIndex = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentIndex == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Compte",
                          style: TextStyle(color: currentIndex == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}