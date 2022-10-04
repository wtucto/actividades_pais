import 'package:flutter/material.dart';

const Color wite = Color.fromARGB(255, 255, 255, 255);
const Color black = Color.fromARGB(255, 0, 0, 0);
const Color blackT1 = Color.fromARGB(255, 81, 80, 2);
const Color blackT2 = Color.fromRGBO(0, 0, 0, 0.16);
const Color blue = Color.fromARGB(255, 0, 76, 255);

const Color yellow = Color(0xffFDC054);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
const Color transparentYellow2 = Color.fromRGBO(253, 184, 70, 0.7);
const Color transparentYellow = Color.fromARGB(172, 110, 175, 187);
const Color transparentCeleste = Color.fromARGB(172, 110, 175, 187);
const Color transparentWite = Color.fromARGB(175, 255, 255, 255);
const Color darkGrey = Color(0xff202020);

const LinearGradient mainButton = LinearGradient(
  colors: [
    Color.fromRGBO(236, 60, 3, 1),
    Color.fromRGBO(234, 60, 3, 1),
    Color.fromRGBO(216, 78, 16, 1),
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);

const LinearGradient mainButton2 = LinearGradient(
  colors: [
    Color.fromARGB(236, 7, 150, 1),
    Color.fromARGB(234, 13, 162, 1),
    Color.fromARGB(216, 16, 166, 1),
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);

const LinearGradient mainButton3 = LinearGradient(
  colors: [
    Color.fromARGB(235, 55, 55, 52),
    Color.fromARGB(234, 64, 64, 1),
    Color.fromARGB(216, 55, 55, 1),
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);

const LinearGradient mainButton4 = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF73AEF5),
    Color(0xFF61A4F1),
    Color(0xFF478DE0),
    Color(0xFF398AE5),
  ],
  stops: [0.1, 0.4, 0.7, 0.9],
);

const LinearGradient mainButton5 = LinearGradient(colors: [
  Color.fromARGB(255, 41, 168, 138),
  Color.fromARGB(255, 41, 168, 138)
]);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
