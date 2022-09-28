import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/actividadesPias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:intl/intl.dart';

class ListaActividades extends StatefulWidget {
  String idUnicoReporte = '';
  ListaActividades(this.idUnicoReporte);
  @override
  State<ListaActividades> createState() => _ListaActividadesState();
}

class _ListaActividadesState extends State<ListaActividades> {
  TextEditingController controllerActividad = TextEditingController();
  ActividadesPias actividadesPias = ActividadesPias();
  var a = DatabasePias.db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[600],
          onPressed: () async {
            Util().showAlertDialogAgregar('Agregar Actividad', context,
                () async {
              if (controllerActividad.text == "") {
                Util().showAlertDialog(
                    'Agregar Actividad', 'Ingresar detalle', context, () {
                  Navigator.pop(context);
                });
              } else {
                actividadesPias.descripcion = controllerActividad.text;
                actividadesPias.idUnicoReporte = widget.idUnicoReporte;
                a.insertActividadesPias(actividadesPias);
                await listarActividadesPias();
                Navigator.pop(context);
                controllerActividad.text = "";
              }
            }, () {
              Navigator.pop(context);
            }, controllerActividad);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: Util().iconbuton(() => Navigator.of(context).pop()),
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Actividades",
                style: TextStyle(
                  color: Colors.black, // 2
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<ActividadesPias>>(
          future: a.listarActividadesPias(widget.idUnicoReporte),
          builder: (BuildContext context,
              AsyncSnapshot<List<ActividadesPias>> snapshot) {
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
                            itemBuilder: (context, i) => Dismissible(
                                  key: UniqueKey(),
                                  child: Listas()
                                      .cardActividadesPias(listaPersonalAux[i]),
                                  background: Util().buildSwipeActionLeft(),
                                  secondaryBackground:
                                      Util().buildSwipeActionRigth(),
                                  onDismissed: (direction) async {
                                    switch (direction) {
                                      case DismissDirection.endToStart:
                                        Util().showAlertDialogEliminar(
                                            'Actividades!!', context, () async {
                                          await a.eliminarActividadesPiasid(
                                              listaPersonalAux[i].id);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, () async {
                                          await a.listarActividadesPias(
                                              widget.idUnicoReporte);
                                          setState(() {});
                                          Navigator.pop(context);
                                        });

                                        break;
                                      case DismissDirection.startToEnd:
                                        Util().showAlertDialogEliminar(
                                            'Actividades!!', context, () async {
                                          await a.eliminarActividadesPiasid(
                                              listaPersonalAux[i].id);
                                          setState(() {});
                                          Navigator.pop(context);
                                        }, () async {
                                          setState(() {});
                                          await a.listarActividadesPias(
                                              widget.idUnicoReporte);
                                          Navigator.pop(context);
                                        });
                                        break;
                                    }
                                  },
                                )),
                        onRefresh: listarActividadesPias),
                  );
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<Null> listarActividadesPias() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      a.listarActividadesPias(widget.idUnicoReporte);
    });
  }
}
