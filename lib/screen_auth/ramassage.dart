import 'package:flutter/material.dart';
import 'package:livex/screen_auth/NavBar.dart';
class ramassage extends StatefulWidget {
  const ramassage({super.key});

  @override
  State<ramassage> createState() => _ramassageState();
}

class _ramassageState extends State<ramassage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Demande ramassage"),

        ),
        body: Container(
          child: Stack(
            children: [Text(' WElcom to mon compte'),],
          ),
        )

    );
  }
}
