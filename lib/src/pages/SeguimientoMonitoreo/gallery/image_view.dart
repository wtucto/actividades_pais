import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/detalleProyecto.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  ImageView({
    super.key,
    this.galleria,
    required this.datoProyecto,
  });
  Image? galleria;
  TramaProyectoModel datoProyecto;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.datoProyecto.tambo!),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetalleProyecto(datoProyecto: widget.datoProyecto),
                ));
          },
        ),
      ),
      body: Container(
        child: PhotoView(imageProvider: widget.galleria!.image),
      ),
    );
  }
}
