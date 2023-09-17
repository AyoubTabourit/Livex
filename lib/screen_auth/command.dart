import 'package:flutter/material.dart';
import 'package:livex/screen_auth/NavBar.dart';
class command extends StatefulWidget {
  const command({super.key});

  @override
  State<command> createState() => _commandState();
}

class _commandState extends State<command> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Mes Commandes"),

        ),
        body: Container(
          child: Stack(
            children: [Text('WElcom to command'),],
          ),
        )

    );
  }
}
