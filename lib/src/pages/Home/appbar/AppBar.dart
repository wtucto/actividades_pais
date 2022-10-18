import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AppBarPegaso extends StatefulWidget {
  String datoUt = "", nombre = "", plataforma;
  int snip;
  AppBarPegaso(
      {this.datoUt = "",
      this.nombre = "",
      this.snip = 0,
      this.plataforma = ''});
  @override
  _AppBarPegasoState createState() => _AppBarPegasoState();
}

class _AppBarPegasoState extends State<AppBarPegaso> {
  Widget text() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(
            top: 30,
          ),
          child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 180.0,
                      height: 120.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/paislogo.png',
                            width: 100.0,
                            height: 90.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 5.0,
                width: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.datoUt != "") ...[
                    SizedBox(
                      height: 40.0,
                      width: 170,
                      child: Text(
                        "UT : ${widget.datoUt} - Plataforma: ${widget.plataforma}",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                  SizedBox(
                    //  height: 15.0,
                    width: 30,
                  ),
                  if (widget.nombre != "") ...[
                    SizedBox(
                      height: 40.0,
                      width: 150,
                      child: Text(
                        widget.nombre == "" ? "Usuario : " + widget.nombre : "",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double dRadiusTop = 0; //50;
    double dHeight = 300;
    double dTop = 200;

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
                        offset: Offset(0.5, -8), // changes position of shadow
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
