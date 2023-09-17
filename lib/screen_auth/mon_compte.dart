
import 'package:flutter/material.dart';
import 'package:livex/screen_auth/NavBar.dart';
class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Mon Compte"),

      ),
        body: Container(
        child: Stack(
        children: [Text('WElcom to mon compte'),],
        ),
        )

    );
  }
}
