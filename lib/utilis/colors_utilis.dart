import 'package:flutter/material.dart';
hexStringTocolor(String hexcolor){
  hexcolor=hexcolor.toUpperCase().replaceAll("#", "");
  if(hexcolor.length==6){
    hexcolor="ff"+hexcolor;
  }
  return Color(int.parse(hexcolor,radix: 16));
}