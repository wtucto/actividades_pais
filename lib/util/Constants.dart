import 'package:flutter/material.dart';

const Color lightBlue = Color(0xFF58ABF6);
const Color lightTeal = Color(0xFF2CDAB1);

const Color blue = Color.fromARGB(255, 0, 76, 255);
const Color yellow = Color(0xffFDC054);
const Color transparentYellow = Color.fromARGB(172, 110, 175, 187);
const Color transparentWite = Color.fromARGB(175, 255, 255, 255);
const Color darkGrey = Color(0xff202020);

const LinearGradient mainButton4 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF398AE5),
    Color(0xFF398AE5),
    Color(0xFF398AE5),
    Color(0xFF398AE5),
  ],
  stops: [0.1, 0.4, 0.7, 0.9],
);

const LinearGradient mainButton5 = LinearGradient(colors: [
  Color(0xFFa0d9f5),
  Color(0xFFa0d9f5),
]);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];
