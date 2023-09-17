import 'package:flutter/material.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:livex/screen_auth/sign_in.dart';
import 'package:livex/screen_auth/sign_up.dart';
import 'package:livex/screen_auth/home.dart';
import 'package:livex/screen_auth/bare.dart';
import 'package:livex/screen_auth/testbuild.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  singinscreen(),
    );
  }
}

