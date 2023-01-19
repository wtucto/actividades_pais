import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaMarca.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:flutter/material.dart';

class SeguimientoParqueInformatico extends StatefulWidget {
  const SeguimientoParqueInformatico({Key? key}) : super(key: key);

  @override
  State<SeguimientoParqueInformatico> createState() =>
      _SeguimientoParqueInformaticoState();
}

class _SeguimientoParqueInformaticoState
    extends State<SeguimientoParqueInformatico> {
  Listas listas = Listas();
  var seleccionarMarca = "Seleccionar Marca";
  var seleccionarModelo = "Seleccionar Modelo";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProviderSeguimientoParqueInformatico().listaParqueInformatico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PARQUE INFORMATICO"),
          actions: [
            InkWell(
              child: Icon(Icons.filter_list_rounded),
              onTap: () {
                _showAddNoteDialog(context);
              },
            )
          ],
        ),
        body: FutureBuilder<List<ListaEquipoInformatico>>(
          future:
              ProviderSeguimientoParqueInformatico().listaParqueInformatico(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ListaEquipoInformatico>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: Text("¡No existen registros"),
                );
              } else {
                final listaPersonalAux = snapshot.data;
                if (listaPersonalAux!.length == 0) {
                  return const Center(
                    child: Text(
                      'No hay informacion',
                      style: TextStyle(fontSize: 19),
                    ),
                  );
                } else {
                  return Container(
                    child: RefreshIndicator(
                        onRefresh: refreshList,
                        child: ListView.builder(
                          itemCount: listaPersonalAux.length,
                          itemBuilder: (context, i) => Dismissible(
                              key: UniqueKey(),
                              background: buildSwipeActionLeft(),
                              secondaryBackground: buildSwipeActionRigth(),
                              onDismissed: (direction) async {
                                switch (direction) {
                                  case DismissDirection.endToStart:
                                    break;
                                  case DismissDirection.startToEnd:
                                    break;
                                }
                              },
                              child: listas.cardParqueInformatico(
                                listaPersonalAux[i],
                                () async {
                                  /*  final respt = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EjecucionProgramacionPage(
                                                idProgramacion: int.parse(
                                                    listaPersonalAux[i]
                                                        .codigoIntervencion!),
                                                descripcionEvento:
                                                listaPersonalAux[i]
                                                    .descripcionEvento!,
                                                //   snip: widget.snip,
                                                programa: listaPersonalAux[i]
                                                    .programa!,
                                                tramaIntervencion:
                                                listaPersonalAux[i])),
                                  );
                                  if (respt == 'ok') {
                                    print("aqioioo");
                                    refreshList();
                                  }*/
                                },
                              )),
                        )),
                  );
                }
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'ss',
          onPressed: () {},
          child: Icon(Icons.playlist_add_outlined),
        ));
  }

  _showAddNoteDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {

          const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

          String dropdownValue = list.first;
          return AlertDialog(
            title: Text("FILTRO"),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'CODIGO PATRIMONIAL',
                          icon: Icon(Icons.note_add)),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'DENOMINACION', icon: Icon(Icons.note_add)),
                    ),
                    Container(
                     margin: EdgeInsets.only(),
                     child: FutureBuilder<List<Marca>>(
                       future: ProviderSeguimientoParqueInformatico()
                           .listaMarcas(),
                       builder: (BuildContext context,
                           AsyncSnapshot<List<Marca>> snapshot) {
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
                              child: StatefulBuilder(
                                 builder: (BuildContext context, StateSetter dropDownState){
                                   return DropdownButton<Marca>(
                                     isExpanded: true,
                                     underline: Container(),
                                     items: snapshot.data
                                         ?.map((user) {
                                       return new DropdownMenuItem<Marca>(
                                         value: user,
                                         child: new Text(user.descripcionMarca!, style: TextStyle(fontWeight: FontWeight.w500),),
                                       );
                                     }).toList(),
                                     onChanged: (Marca? value) {
                                       dropDownState(() {
                                         seleccionarMarca = value!.descripcionMarca!;
                                       });
                                     },hint: Text(seleccionarMarca),
                                   );
                                 }
                             ),
                           );
                         }
                       },
                     ),
                      ),Container(
                     margin: EdgeInsets.only(),
                     child: FutureBuilder<List<Marca>>(
                       future: ProviderSeguimientoParqueInformatico()
                           .listaMarcas(),
                       builder: (BuildContext context,
                           AsyncSnapshot<List<Marca>> snapshot) {
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
                              child: StatefulBuilder(
                                 builder: (BuildContext context, StateSetter dropDownState){
                                   return DropdownButton<Marca>(
                                     isExpanded: true,
                                     underline: Container(),
                                     items: snapshot.data
                                         ?.map((user) {
                                       return new DropdownMenuItem<Marca>(
                                         value: user,
                                         child: new Text(user.descripcionMarca!, style: TextStyle(fontWeight: FontWeight.w500),),
                                       );
                                     }).toList(),
                                     onChanged: (Marca? value) {
                                       dropDownState(() {
                                         seleccionarModelo = value!.descripcionMarca!;
                                       });
                                     },hint: Text(seleccionarModelo),
                                   );
                                 }
                             ),
                           );
                         }
                       },
                     ),
                      ),

                  ],
                ),
              ),
            ),
            actions: [
              /*  FlatButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),*/
            ],
          );
        },
      );

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

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    //  var abc = await DatabasePr.db.getAllTasksConfigInicio();
    //if (abc.isNotEmpty) {
    //    await DatabasePr.db.listarInterciones();
    //  }
  }
}
