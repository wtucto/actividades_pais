import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:flutter/material.dart';

class DetalleProyecto extends StatefulWidget {
  const DetalleProyecto({super.key, required this.datoProyecto});
  final TramaProyectoModel datoProyecto;
  @override
  State<DetalleProyecto> createState() => _DetalleProyectoState();
}

class _DetalleProyectoState extends State<DetalleProyecto> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold();
  }
}
