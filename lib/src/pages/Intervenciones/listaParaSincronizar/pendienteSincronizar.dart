import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/Provider/connection_status_model.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/listaParaSincronizar/listasParaEnvio.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

class PendienteSincronizar extends StatefulWidget {
  int snip;
  PendienteSincronizar(this.snip);
  @override
  State<PendienteSincronizar> createState() => _PendienteSincronizarState();
}

class _PendienteSincronizarState extends State<PendienteSincronizar> {
  ProviderDatos provider = ProviderDatos();
  late FToast fToast;
  bool status = false;
  bool _isOnline = true;
  final Connectivity _connectivity = Connectivity();
  Listas listas = Listas();
   @override
  void initState() {
    super.initState();
     _checkInternetConnection();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
     super.dispose();
  }


  Future<void> _checkInternetConnection() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});

       final result = await InternetAddress.lookup('www.google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
       } else {
        _isOnline = false;
       }
    } on SocketException catch (_) {
      _isOnline = false;
    }
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
     // _checkInternetConnection();
    });

    return WillPopScope(
      onWillPop: systemBackButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text("Pendientes Envio"),
          leading: Util().iconbuton(() =>       Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => Intervenciones(widget.snip, '')),

          )),
          actions: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (_isOnline == true) ...[
                Icon(
                  Icons.wifi,
                  color: Colors.green,
                ),
              ] else ...[
                (Icon(Icons.wifi_off, color: Colors.red[900]))
              ]
            ]), SizedBox(width: 15,)
          ],
        ),
        body: FutureBuilder<List<TramaIntervencion>>(
          future: DatabasePr.db.listarIntervencionesPs(widget.snip),
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
                    child: Text("No hay informacion"),
                  );
                } else {
                  return Container(
                    child: RefreshIndicator(
                        child: ListView.builder(
                          itemCount: listaPersonalAux.length,
                          itemBuilder: (context, i) => Dismissible(
                              key: Key(listaPersonalAux[i]
                                  .codigoIntervencion
                                  .toString()),
                              child: listas.cardIntervenciones(
                                listaPersonalAux[i],
                                () async {
                                  _checkInternetConnection();
                                  if (_isOnline == false) {
                                    Util().showAlertDialog(
                                        'Pendientes Envio',
                                        'No tiene red de internet para sincronizar estos registros.',
                                        context, () {
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    final respt = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListasParaEnvio(
                                              listaPersonalAux[i]
                                                  .codigoIntervencion
                                                  .toString(),
                                              listaPersonalAux[i]
                                                  .tambo
                                                  .toString())),
                                    );
                                    if (respt == 'ok') {
                                       refreshList();
                                    }
                                  }
                                },

                              ),
                              background: buildSwipeActionLeft(),
                              secondaryBackground: buildSwipeActionRigth(),
                              onDismissed: (direction) async {
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    await DatabasePr.db
                                        .eliminarTramaIntervencionesUsPorid(
                                            listaPersonalAux[i]
                                                .codigoIntervencion);

                                    break;
                                  case DismissDirection.startToEnd:
                                    await DatabasePr.db
                                        .eliminarTramaIntervencionesUsPorid(
                                            listaPersonalAux[i]
                                                .codigoIntervencion);
                                    break;
                                }
                              }),
                          /*itemBuilder: (context, i) =>
                              _banTitle(listaPersonalAux[i]), */
                        ),
                        onRefresh: refreshList),
                  );
                }
              }
            }
            return Center(
              child: Text("¡No existen registros"),
            );
          },
        ),
      ),
    );
  }

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));
  ListTile _banTitle(TramaIntervencion band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          '${band.estado?.substring(0, 1)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      title: Text('${band.tambo}', style: TextStyle(fontSize: 13)),
      subtitle:
          new Text('${band.tipoGobierno}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.fecha}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.estado}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () async {
        status = ConnectionStatusModel().isOnline;
        fToast.showToast(
          toastDuration: Duration(milliseconds: 500),
          child: Material(
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi),
                Text(
                  " Alert! ${status}",
                  style: TextStyle(color: Colors.black87, fontSize: 16.0),
                )
              ],
            ),
          ),
          gravity: ToastGravity.CENTER,
        );

      },
    );
  }
  Future<bool> systemBackButtonPressed() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Intervenciones(widget.snip, '')));
    return true;
  }
}
