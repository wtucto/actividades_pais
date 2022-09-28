import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/IncidentesNovedadesPias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

class Novedades extends StatefulWidget {
  String idUnicoReporte='';
  Novedades(this.idUnicoReporte);

  @override
  State<Novedades> createState() => _NovedadesState();
}

class _NovedadesState extends State<Novedades> {
  TextEditingController controllerIncidentes = TextEditingController();

  IncidentesNovedadesPias actividadesPias = IncidentesNovedadesPias();
/*  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () async {
          var a = await DatabasePias.db;
          showAlertDialogAgregar(context, titulo: 'Agregar Novedades',
              controllerIncidentes: controllerIncidentes,
              presse: () {
                if (controllerIncidentes.text == "") {
                  Util().showAlertDialog(
                      'Novedades', 'Ingresar detalle', context, () {
                    Navigator.pop(context);
                  });
                } else {
                  actividadesPias.incidentes = controllerIncidentes.text;
                  actividadesPias.idUnicoReporte = widget.idUnicoReporte;
                  actividadesPias.tipo = 2;
                  a.insertIncidentesNovedadesPias(actividadesPias);
                  listarIncidentes();
                  Navigator.pop(context);
                  controllerIncidentes.text = "";
                }
              },
              pressno: () {
                Navigator.pop(context);
              });
        },
        child: Icon(Icons.plus_one),
      ),
      body: FutureBuilder<List<IncidentesNovedadesPias>>(
        future: DatabasePias.db.ListarIncidentesNovedadesPias(widget.idUnicoReporte, 2),
        builder: (BuildContext context,
            AsyncSnapshot<List<IncidentesNovedadesPias>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;

              if (listaPersonalAux!.length == 0) {
                return Center(
                  child: Text("No hay informacion"),
                );
              } else {
                return Container(
                  child: RefreshIndicator(
                      child: ListView.builder(
                          itemCount: listaPersonalAux.length,
                          itemBuilder: (context, i) =>
                              Dismissible(
                                key: UniqueKey(),
                                child: Listas()
                                    .cardIncidentesPias(listaPersonalAux[i]),
                                background: Util().buildSwipeActionLeft(),
                                secondaryBackground:
                                Util().buildSwipeActionRigth(),
                                onDismissed: (direction) async {
                                  switch (direction) {
                                    case DismissDirection.endToStart:
                                      Util().showAlertDialogEliminar(
                                          'Novedades!!', context,
                                              () async {
                                            await DatabasePias.db
                                                .eliminarIncidentesNovedadesPiasid(
                                                listaPersonalAux[i].id);
                                            setState(() {});
                                            Navigator.pop(context);
                                          }, () async {
                                        await DatabasePias.db
                                            .ListarIncidentesNovedadesPias(widget.idUnicoReporte, 2);
                                        setState(() {});
                                        Navigator.pop(context);
                                      });

                                      break;
                                    case DismissDirection.startToEnd:
                                      Util().showAlertDialogEliminar(
                                          'Novedades!!', context,
                                              () async {
                                            await DatabasePias.db
                                                .eliminarIncidentesNovedadesPiasid(
                                                listaPersonalAux[i].id);
                                            setState(() {});
                                            Navigator.pop(context);
                                          }, () async {
                                        setState(() {});
                                        await DatabasePias.db
                                            .ListarIncidentesNovedadesPias(widget.idUnicoReporte, 2);
                                        Navigator.pop(context);
                                      });
                                      break;
                                  }
                                },
                              )),
                      onRefresh: listarIncidentes),
                );
              }
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<Null> listarIncidentes() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      DatabasePias.db.ListarIncidentesNovedadesPias(widget.idUnicoReporte, 2);
    });
  }

  showAlertDialogAgregar(BuildContext context,
      {titulo, presse, pressno, controllerIncidentes}) {
    Widget okButton = TextButton(child: Text("Guardar"), onPressed: presse);
    Widget moButton = TextButton(child: Text("Cancelar"), onPressed: pressno);
    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: controllerIncidentes,
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
