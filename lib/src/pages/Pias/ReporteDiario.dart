import 'package:actividades_pais/src/Utils/add_home_icons.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderDataJson.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/Pias/Actividades/listaActividades.dart';
import 'package:actividades_pais/src/pages/Pias/AtencionesRealizadas/atencionesRealizadas.dart';
import 'package:actividades_pais/src/pages/Pias/Incidentes_Actividades/incidentesNovedades.dart';
import 'package:actividades_pais/src/pages/Pias/Nacimientos/nacimientos.dart';
import 'package:actividades_pais/src/pages/Pias/Parte/parte.dart';

class ReporteDiario extends StatefulWidget {
  String plataforma = "", unidadTeritorial = "", idUnicoReporte = '';
  int idPlataforma = 0;
  String long = '';
  String lat = '';
  String campaniaCod = '';

  ReporteDiario({
    this.plataforma = "",
    this.unidadTeritorial = "",
    this.idPlataforma = 0,
    this.idUnicoReporte = '',
    this.lat = '',
    this.long = '',
    this.campaniaCod = '',
  });

  @override
  State<ReporteDiario> createState() => _ReporteDiarioState();
}

class _ReporteDiarioState extends State<ReporteDiario> {
  var seleccionarPuesto = 'Seleccionar';
  int currenIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    traerdato();
  }

  traerdato() async {
    var art = await ProviderDatos().verificacionpesmiso();
    widget.lat = art[0].latitude.toString();
    widget.long = art[0].longitude.toString();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    List listPages = [
      Parte(
          unidadTerritorial: widget.unidadTeritorial,
          plataforma: widget.plataforma,
          idPlataforma: widget.idPlataforma,
          idUnicoReporte: widget.idUnicoReporte,
          long: widget.long,
          lat: widget.lat,
          campaniaCod: widget.campaniaCod),
      ListaActividades(widget.idUnicoReporte),
      AtencionesRealizadas(widget.idUnicoReporte),
      IncidentesNovedades(widget.idUnicoReporte),
      Nacimientos(widget.idUnicoReporte)
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(67.0),
          child: AppBar(
            leading: Util().iconbuton(() => Navigator.of(context).pop()),
            backgroundColor: Colors.indigo,
            title: Container(
              child: Text("Reporte diario equipo de \ncampaña"),
            ),
            actions: [
              InkWell(
                  child: Icon(Icons.check),
                  onTap: () {
                    Navigator.pop(context, "OK");
                  }),
              SizedBox(
                width: 10,
              )
            
            ],
          )),
      body: listPages[currenIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currenIndex,
        onItemSelected: (index) {
          setState(() {
            currenIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.pending_actions_rounded),
              title: Text("Parte"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.home_rounded),
              title: Text("Actividades"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Add_home.hand_holding_medical),
              title: Text("Atenciones Realizadas"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.handyman),
              title: Text("Incidentes"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.child_friendly),
              title: Text("Nacimientos"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
        ],
      ),
    );
  }
}
