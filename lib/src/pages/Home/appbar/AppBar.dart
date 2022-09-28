import 'package:flutter/material.dart';
import 'package:decorative_app_bar/decorative_app_bar.dart';

// ignore: use_key_in_widget_constructors
class AppBarPegaso extends StatefulWidget {
  String datoUt = "", nombre = "", plataforma;
  int snip;
  AppBarPegaso({this.datoUt = "", this.nombre = "", this.snip = 0, this.plataforma = ''});
  @override
  _AppBarPegasoState createState() => _AppBarPegasoState();
}

const datoUt = "";
const nombre = "JUANITO";

class _AppBarPegasoState extends State<AppBarPegaso> {
  Widget text() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.only(top: 20, left: 30),
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
                              width: 110.0,
                              height: 100.0,
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
                          "Usuario : " + widget.nombre,
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ]
                  ],
                )
              ],
            )),
        /*  Padding(
            padding: EdgeInsets.only(top: 0, right: 20),
            child: Container(
              child: InkWell(
                onTap: () async {
                   await DatabasePr.db.eliminarTokn();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );  
                },
                child: Icon(
                  Icons.login,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            )), */
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: DecorativeAppBar(
          barHeight: 300,
          barPad: 200,
          radii: 50,
          background: Colors.white,
          gradient1: Colors.green[900],
          gradient2: Colors.green[600],
          extra: text(),
        ));
  }
}
