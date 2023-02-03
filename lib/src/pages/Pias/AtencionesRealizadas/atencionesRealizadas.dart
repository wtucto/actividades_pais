import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Atencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Clima.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Pias/AtencionesRealizadas/CrearAtenciones.dart';
import 'package:intl/intl.dart';

import '../../../../util/app-config.dart';

class AtencionesRealizadas extends StatefulWidget {
  String idUnicoReporte = '';

  AtencionesRealizadas(this.idUnicoReporte);

  @override
  State<AtencionesRealizadas> createState() => _AtencionesRealizadasState();
}

class _AtencionesRealizadasState extends State<AtencionesRealizadas> {
  String seleccionarClima = '';

/*  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');*/
  TextEditingController controllerAtendidos = TextEditingController();
  TextEditingController controllerAtenciones = TextEditingController();
  var sumaAtendidos = 0;
  var sumAtenciones = 0;

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 0));
    var ar = await DatabasePias.db.sumaAtenAtenc(widget.idUnicoReporte);
    sumaAtendidos = ar[0]["sumaAtendidos"] ?? 0;
    sumAtenciones = ar[0]["sumAtenciones"] ?? 0;
    await DatabasePias.db.listarAtencion(widget.idUnicoReporte);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "ATENCIONES REALIZADAS",
            style: TextStyle(
              color: Colors.black, // 2
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: FutureBuilder<List<Atencion>>(
            future: DatabasePias.db.listarAtencion(widget.idUnicoReporte),
            builder:
                (BuildContext context, AsyncSnapshot<List<Atencion>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final preguntas = snapshot.data;
              if (preguntas!.length == 0) {
                return Center(
                  child: Text("sin dato"),
                );
              } else {
                return Container(
                  child: ListView(
                    children: [
                      Container(
                        height: 420,
                        child: ListView.builder(
                          itemCount: preguntas.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) => _bandTile(preguntas[i]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: 280,
                                child: Text(
                                  "En este punto se logró atender un total \nde $sumAtenciones atenciones a través de $sumaAtendidos \npersonas atendidas.",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: AppConfig.primaryColor,
        onPressed: () async {
          final respuesta = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CrearAtenciones(widget.idUnicoReporte)),
          );
           if (respuesta == "atencion") {
            refresh();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _bandTile(Atencion band) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direccion) {
        DatabasePias.db.eliminarAtencionid(band.id);
        refresh();
      },
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Borrar Atencion',
              style: TextStyle(color: Colors.white),
            ),
          )),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "${band.tipoDescripcion}",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: 100, child: Text("Atendidos : ${band.atendidos}")),
                SizedBox(
                  width: 100,
                  child: Text("Atenciones : ${band.atenciones}"),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  /* Widget _bandTile(Atencion band) {
    return
  }*/

  showAlertDialogAgregar(
      titulo, BuildContext context, presse, pressno, controllerNovedad) {
    Widget okButton = TextButton(child: Text("Guardar"), onPressed: presse);
    Widget moButton = TextButton(child: Text("Cancelar"), onPressed: pressno);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: TextField(
        controller: controllerNovedad,
        maxLines: 5, //or null
        decoration: InputDecoration.collapsed(hintText: "Insertar detalle"),
      ),
      actions: [okButton, moButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
