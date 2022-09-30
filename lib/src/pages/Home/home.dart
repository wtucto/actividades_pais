import 'dart:async';
import 'package:actividades_pais/src/pages/Monitor/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Pias/ListaReportesPias.dart';
import 'package:actividades_pais/src/pages/configuracion/Asistencia.dart';
import 'package:actividades_pais/src/pages/configuracion/pantallainicio.dart';

import 'appbar/AppBar.dart';

class HomePagePais extends StatefulWidget {
  static String route = '/';

  @override
  _HomePagePais createState() => _HomePagePais();
}

class _HomePagePais extends State<HomePagePais> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  int currenIndex = 0;
  var cantidadDB = 0;
  Color changecolor = Colors.grey;
  bool _isVisible = true;
  var _nombrePersona = '';
  var _apellidosPersona = "";
  var unidadTerritorial = "";
  var variable = "";
  var snip = 0;
  var idPlataforma = 0;
  var tipoPlataforma = '';
  var campaniaCod = '';
  var modalidad = '';

  String long = '';
  String lat = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///ProviderDatos().   verificacionpesmiso();
    mostrarTmbo();
    traerdato();
    verificargps();
  }

  Future verificargps() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
      print("GPS service is enabled");
    } else {
      print("GPS service is disabled.");
    }
  }

  traerdato() async {
    await ProviderDatos().verificacionpesmiso();
  }

  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    if (abc.length > 0) {
      var idlp = abc[abc.length - 1].idLugarPrestacion;
      var iduo = abc[abc.length - 1].idUnidadesOrganicas;

      setState(() {
        mostrarNombre();
        if (abc.length >= 1) {
          mostrarNombre();
          cantidadDB = 1;
          changecolor = (Colors.blue[400])!;
          _isVisible = false;
          if (idlp == 1) {
            variable = abc[abc.length - 1].lugarPrestacion;
            unidadTerritorial = abc[abc.length - 1].unidTerritoriales;
            snip = abc[abc.length - 1].snip;
          } else if (idlp == 2) {
            variable = abc[abc.length - 1].nombreTambo;
            unidadTerritorial = abc[abc.length - 1].unidTerritoriales;
            snip = abc[abc.length - 1].snip;
            tipoPlataforma = abc[abc.length - 1].tipoPlataforma;
            idPlataforma = abc[abc.length - 1].idTambo;
            campaniaCod = abc[abc.length - 1].codCampania;
            modalidad = abc[abc.length - 1].modalidad;

            print("campaniaCod $campaniaCod");
          }
        }
      });
    }
  }

  Future mostrarNombre() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    if (abc.length > 0) {
      setState(() {
        _nombrePersona = abc[abc.length - 1].nombres.toUpperCase();
        _apellidosPersona = abc[abc.length - 1].apellidoPaterno.toUpperCase() +
            ' ' +
            abc[abc.length - 1].apellidoMaterno.toUpperCase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    botones(nombre, icono) {
      return InkWell(
        onTap: () async {
          if (cantidadDB == 1) {
            switch (nombre) {
              case 'REGISTAR BITACORA':
                var rspt = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Asistencia(long: long, lat: lat)),
                );
                if (rspt == 'ok') {}
                print(rspt);
                break;
              case 'INTERVENCIONES':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Intervenciones(snip, unidadTerritorial)),
                );
                break;
              case 'PIAS':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaReportesPias(
                          unidadTeritorial: unidadTerritorial,
                          plataforma: variable,
                          idPlataforma: idPlataforma,
                          long: long,
                          lat: lat,
                          campaniaCod: campaniaCod)),
                );
                break;
            }
          } else {
            Fluttertoast.showToast(
              msg: 'Registrarse en el App',
              gravity: ToastGravity.BOTTOM,
            );
          }

          switch (nombre) {
            case 'MONITOR PROY. TAMPO':
              var rspt = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MainPage()));

              /*Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => MainPage()),
                  (route) => false,
                );*/

              if (rspt == 'ok') {}
              print(rspt);
              break;
          }
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icono,
                    color: changecolor,
                    size: 60,
                  ),
                ],
              ),
              ListTile(
                title: Center(
                    child: Text("" + nombre,
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
              ),
            ],
          ),
        ),
      );
    }

    List listPages = [
      Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 220,
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 55, right: 55),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    shrinkWrap: false,
                    /*  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,*/
                    children: [
                      botones("REGISTAR BITACORA", Icons.app_registration),
                      botones("MONITOR PROY. TAMPO", Icons.monitor),
                      if (tipoPlataforma == 'TAMBO') ...[
                        botones(
                            "INTERVENCIONES", Icons.assignment_late_outlined)
                      ],
                      if (tipoPlataforma == 'PIAS' && modalidad == "1") ...[
                        botones("PIAS", Icons.directions_boat_outlined),
                      ],
                      if (tipoPlataforma == 'PIAS' && modalidad == "2") ...[
                        botones("PIAS", Icons.flight_takeoff),
                      ],
                      if (tipoPlataforma == 'PIAS' && modalidad == "3") ...[
                        botones("PIAS", Icons.account_balance_outlined),
                      ]
                    ],
                  ),
                ),
              )),
        ],
      )),
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarPegaso(
              datoUt: unidadTerritorial,
              plataforma: variable,
              nombre: _nombrePersona + " " + _apellidosPersona,
              snip: snip),
          listPages[currenIndex]
        ],
      ),
      floatingActionButton: new Visibility(
        visible: _isVisible,
        child: new FloatingActionButton(
          focusColor: Colors.amber,
          backgroundColor: Colors.orange,
          child: const Icon(Icons.manage_accounts),
          onPressed: () async {
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PantallaInicio(),
              ),
            );
          },
        ),
      ),
    );
  }
}
