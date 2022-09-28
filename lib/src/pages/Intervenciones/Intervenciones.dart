import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabaseParticipantes.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Intervenciones/EjecucionProgramacion.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/listaParaSincronizar/pendienteSincronizar.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

// ignore: must_be_immutable
class Intervenciones extends StatefulWidget {
  int snip;
  String unidadTerritorial;
  bool anterior = false;

  Intervenciones(this.snip, this.unidadTerritorial);

  @override
  State<Intervenciones> createState() => _IntervencionesState();
}

class _IntervencionesState extends State<Intervenciones> {
  ProviderDatos provider = ProviderDatos();
  Listas listas = Listas();

  bool anterior = false;
  bool _isloading = false;
  bool loadPart = false;
  bool cargardialog = false;
  var todoParticiw = 0;
  var cargarBarra = 0;

  @override
  void initState() {
    super.initState();
    CalcularParticipantes();
  }

  CalcularParticipantes() async {
    var todoPartici = await DatabaseParticipantes.db.listarTodoParicipantes();
    todoParticiw = todoPartici.length;
    setState(() {});
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));

    setState(() {
      DatabasePr.db.listarInterciones(widget.snip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: systemBackButtonPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          leading: Util().iconbuton(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePagePais()),
              )),
          title: Text("Intervenciones"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                loadPart
                    ? Image.asset(
                        "assets/loaderios.gif",
                        height: 40.0,
                        width: 50.0,
                        //color: Colors.transparent,
                      )
                    : new Container(),
                if (todoParticiw <= 0) ...[
                  InkWell(
                    child: Icon(
                      Icons.vpn_lock,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      //   CalcularParticipantes();

                      var ar = [];
                      showAlertDialogBarra(context, titulo: 'Participantes',
                          presse: () async {
                        loadPart = true;
                        Navigator.pop(context);
                        setState(() {
                          cargardialog = true;
                        });

                        ar = await ProviderDatos()
                            .getInsertParticipantesIntervencionesMovil(
                                widget.unidadTerritorial);
                        Navigator.pop(context);
                        loadPart = false;
                      }, pressno: () {
                        Navigator.pop(context);
                      },
                          texto:
                              '¿Estas seguro de eliminar los datos existentes para sincronizar nuevos participantes',
                          a: cargardialog);
                      setState(() {});
                      if (ar.length > 1) {
                        loadPart = false;
                      }
                    },
                  )
                ] else ...[
                  InkWell(
                    child: Icon(
                      Icons.vpn_lock,
                      color: Colors.green,
                    ),
                    onTap: () async {
                      var ar = [];
                      showAlertDialogBarra(context, titulo: 'Participantes',
                          presse: () async {
                            loadPart = true;
                            Navigator.pop(context);
                            setState(() {

                            });
                        // Navigator.pop(context);
                        ar = await ProviderDatos()
                            .getInsertParticipantesIntervencionesMovil(
                                widget.unidadTerritorial);
                            setState(() {
                              cargardialog = false;
                            });
                        loadPart = false;
                      }, pressno: () {
                        Navigator.pop(context);
                      },
                          texto:
                              '¿Estas seguro de eliminar los datos existentes para sincronizar nuevos participantes',
                          a: cargardialog);
                      setState(() {});
                      if (ar.length > 1) {
                        loadPart = false;
                      }
                      //setState(() {});
                    },
                  ),
                ],
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  child: Icon(Icons.delete),
                  onTap: () async {
                    await DatabasePr.db.deleteIntervenciones();
                    await DatabasePr.db.eliminarTodoEntidadFuncionario();
                    await DatabasePr.db.eliminarTodoParticipanteEjecucion();

                    refreshList();
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  child: Icon(Icons.cloud_download_sharp),
                  onTap: () async {
                    //    await DatabaseParticipantes.db.DeleteAllParticitantesInterv();
                    setState(() {
                      _isloading = true;
                    });
                    await DatabasePr.db.deleteIntervenciones();
                    await DatabasePr.db.eliminarTodoEntidadFuncionario();
                    await DatabasePr.db.eliminarTodoParticipanteEjecucion();
                    var a =
                        await provider.getListaTramaIntervencion(widget.snip);
                    if (a.length == 0) {
                      _isloading = false;
                      setState(() {});
                    }
                    if (a.length > 0) {
                      var r2 =
                          await DatabasePr.db.listarInterciones(widget.snip);

                      setState(() {});
                      _isloading = false;
                    }
                    // refreshList();
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: Icon(Icons.cloud_upload),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PendienteSincronizar(widget.snip)),
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
        body: FutureBuilder<List<TramaIntervencion>>(
          future: DatabasePr.db.listarInterciones(widget.snip),
          builder: (BuildContext context,
              AsyncSnapshot<List<TramaIntervencion>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData == false) {
                return Center(
                  child: Text("¡No existen registros"),
                );
              } else {
                final listaPersonalAux = snapshot.data;

                if (listaPersonalAux!.length == 0) {
                  return Center(
                    child: _isloading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/loading_icon.gif",
                                height: 125.0,
                                width: 200.0,
                                //color: Colors.transparent,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 10, left: 10),
                                    height: 100,
                                    width: 250,
                                    child: Text(
                                      'Espere un momento... \nEl aplicativo esta recuperando las '
                                      'intervenciones de su tambo...',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : Text(
                            'No hay informacion',
                            style: TextStyle(fontSize: 19),
                          ),
                    //Text("No hay informacion"),
                  );
                  /* _isloading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Text(
                              'Espere...',
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        )
                      : Text(
                          'Guardar',
                          style: TextStyle(fontSize: 19),
                        ),*/
                } else {
                  return Container(
                    child: RefreshIndicator(
                        child: ListView.builder(
                          itemCount: listaPersonalAux.length,
                          itemBuilder: (context, i) => Dismissible(
                              key: UniqueKey(),
                              child: listas.cardIntervenciones(
                                listaPersonalAux[i],
                                () async {
                                  final respt = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EjecucionProgramacionPage(
                                                idProgramacion:
                                                    int.parse(listaPersonalAux[i]
                                                        .codigoIntervencion!),
                                                descripcionEvento:
                                                    listaPersonalAux[i]
                                                        .descripcionEvento!,
                                                snip: widget.snip,
                                                programa: listaPersonalAux[i]
                                                    .programa!,
                                                tramaIntervencion:
                                                    listaPersonalAux[i])),
                                  );
                                  if (respt == 'ok') {
                                    print("aqioioo");
                                    refreshList();
                                  }
                                },
                              ),
                              background: buildSwipeActionLeft(),
                              secondaryBackground: buildSwipeActionRigth(),
                              onDismissed: (direction) async {
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    break;
                                  case DismissDirection.startToEnd:
                                    break;
                                }
                              }),
                          /*   itemBuilder: (context, i) =>
                              _banTitle(listaPersonalAux[i]), */
                        ),
                        onRefresh: refreshList),
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

  showAlertDialogBarra(BuildContext context,
      {titulo, presse, pressno, texto, bool a = false}) {
    Widget okButton = TextButton(child: Text("SI"), onPressed: presse);
    Widget moButton = TextButton(child: Text("NO"), onPressed: pressno);
    AlertDialog alert = AlertDialog(
      title: Text("$titulo "),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text("$texto."),
            a
                ? Image.asset(
                    "assets/loaderios.gif",
                    height: 40.0,
                    width: 50.0,
                    //color: Colors.transparent,
                  )
                : new Container(),
          ],
        ),
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

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.delete,
        color: Colors.red[600],
        size: 32,
      ));

  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.delete,
        color: Colors.red[600],
        size: 32,
      ));

  Future<bool?> _onWillPopScope() {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePagePais()),
    );
  }

  Future<bool> systemBackButtonPressed() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePagePais()));
    return true;
  }
}
