import 'package:flutter/material.dart';

class ReporteEquipoInformatico extends StatefulWidget {
  const ReporteEquipoInformatico({Key? key}) : super(key: key);

  @override
  State<ReporteEquipoInformatico> createState() => _ReporteEquipoInformaticoState();
}

class _ReporteEquipoInformaticoState extends State<ReporteEquipoInformatico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("REPORTE EQUIPO INFORMATICO"),),);
  }
}
