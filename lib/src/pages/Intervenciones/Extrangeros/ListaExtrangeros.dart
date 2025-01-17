import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/PartExtrangeros.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Extrangeros/Extranjeros.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

class ListaExtrangeros extends StatefulWidget {
  int idProgramacion;
  ListaExtrangeros(this.idProgramacion);
  @override
  _ListaExtrangerosState createState() => _ListaExtrangerosState();
}

class _ListaExtrangerosState extends State<ListaExtrangeros> {
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    await DatabasePr.db.listarPartExtrangeros(widget.idProgramacion);
  }

  Listas listas = Listas();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[600],
          onPressed: () async {
            final respuesta = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ExtrangerosPage(idProgramacion: widget.idProgramacion)),
            );
            print(respuesta);
            if (respuesta.toString() == 'participantes') {
              setState(() {});
            }
          },
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Extranjeros",
                style: TextStyle(
                  color: Colors.black, // 2
                ),
              )
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<Participantes>>(
          future: DatabasePr.db
              .listarParticipantes(widget.idProgramacion, 'extrangeros'),
          builder: (BuildContext context,
              AsyncSnapshot<List<Participantes>> snapshot) {
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
                              child: listas.miCardLisPartExtrangeros(
                                  listaPersonalAux[i]),
                              background: Util().buildSwipeActionLeft(),
                              secondaryBackground:
                                  Util().buildSwipeActionRigth(),
                              onDismissed: (direction) async {
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    Util().showAlertDialogEliminar(
                                        'Participantes Extrangeros!!', context,
                                        () async {
                                      await DatabasePr.db
                                          .eliminarExtangerosPorid(
                                              listaPersonalAux[i].id);

                                      setState(() {});
                                      await DatabasePr.db.listarParticipantes(
                                          widget.idProgramacion, 'extrangeros');
                                      Navigator.pop(context);
                                    }, () async {
                                      setState(() {});
                                      await DatabasePr.db.listarParticipantes(
                                          widget.idProgramacion, 'extrangeros');
                                      Navigator.pop(context);
                                    });

                                    break;
                                  case DismissDirection.startToEnd:
                                    Util().showAlertDialogEliminar(
                                        'Participantes Extrangeros!!', context,
                                        () async {
                                      await DatabasePr.db
                                          .eliminarExtangerosPorid(
                                              listaPersonalAux[i].id);

                                      setState(() {});
                                      Navigator.pop(context);
                                    }, () async {
                                      setState(() {});
                                      Navigator.pop(context);
                                    });
                                    break;
                                }
                              }),
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
}
