import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AppBarPais extends StatefulWidget {
  String datoUt = "", nombre = "", plataforma;
  int snip;
  AppBarPais(
      {this.datoUt = "",
      this.nombre = "",
      this.snip = 0,
      this.plataforma = ''});
  @override
  _AppBarPaisState createState() => _AppBarPaisState();
}

class _AppBarPaisState extends State<AppBarPais> {
  Widget text() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.0,
                    height: 70.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/icons/icons8-male-user-100.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      if (widget.datoUt != "") ...[
                        SizedBox(
                          height: 15.0,
                          child: Text(
                            "UT : ${widget.datoUt}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                          child: Text(
                            "PLATAFORMA : ${widget.plataforma}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                      if (widget.nombre != "") ...[
                        SizedBox(
                          height: 15.0,
                          child: Text(
                            "USUARIO : ${widget.nombre}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double dRadiusTop = 0; //50;
    double dHeight = 300;
    double dTop = 150;

    Color bgColor = Colors.white;

    double z = dHeight - dTop;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        height: dHeight,
        decoration: const BoxDecoration(
          gradient: mainButton5,
        ),
        child: Stack(
          children: [
            if (text() != null) text(),
            Column(
              children: [
                Container(
                  height: z,
                  margin: EdgeInsets.only(top: dTop),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(dRadiusTop)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 0.2,
                        offset:
                            const Offset(0.5, -8), // changes position of shadow
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
