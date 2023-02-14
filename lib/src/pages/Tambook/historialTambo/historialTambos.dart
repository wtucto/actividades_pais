import 'package:actividades_pais/src/Utils/add_home_icons.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/Tambook/historialTambo/intervemcionesHistora.dart';
import 'package:actividades_pais/src/pages/Tambook/historialTambo/mapa.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class HistorialTambos extends StatefulWidget {
  const HistorialTambos({Key? key}) : super(key: key);

  @override
  State<HistorialTambos> createState() => _HistorialTambosState();
}

int currenIndex = 0;
var titulo = "";

class _HistorialTambosState extends State<HistorialTambos> {
  @override
  Widget build(BuildContext context) {
    List listPages = [
      intervencionesHistoria(),
      MapaTambook(),
      Container(),
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            leading: Util().iconbuton(() => Navigator.of(context).pop()),
            backgroundColor: AppConfig.primaryColor,
            title: Container(
              child: Text(
                "$titulo",
                style:
                    TextStyle(fontSize: 16, color: AppConfig.letrasColorAppBar),
              ),
            ),
          )),
      body: listPages[currenIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black,
        selectedIndex: currenIndex,
        onItemSelected: (index) {
          setState(() {
            currenIndex = index;
            switch (currenIndex) {
              case 0:
                titulo = "INTERVENCIONES";
                break;
              case 1:
                titulo = "MAPA";
                break;
              case 2:
                titulo = "INTERVENCIONES";
                break;
            }
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.pending_actions_rounded),
              title: Text(
                "INTERVENCIONES",
                style: TextStyle(color: Colors.white, fontSize: 9),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Icons.map),
              title: Text(
                "Actividades",
                style: TextStyle(color: Colors.white, fontSize: 9),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.white),
          BottomNavyBarItem(
              icon: Icon(Add_home.hand_holding_medical),
              title: Text(
                "Atenciones Realizadas",
                style: TextStyle(color: Colors.white, fontSize: 9),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.white),
        ],
      ),
    );
    /*return Scaffold(appBar: AppBar(backgroundColor: AppConfig.primaryColor,title: Text("HISTORIAL TAMBOS", style: TextStyle(color: AppConfig.letrasColor),)),

      body: );*/
  }
}
