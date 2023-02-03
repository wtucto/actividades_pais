import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Atencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Clima.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/TipoAtencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderDataJson.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:intl/intl.dart';

import '../../../../util/app-config.dart';

class CrearAtenciones extends StatefulWidget {
  String idUnicoReporte = '';

  CrearAtenciones(this.idUnicoReporte);

  @override
  _CrearAtencionesState createState() => _CrearAtencionesState();
}

class _CrearAtencionesState extends State<CrearAtenciones> {
  Object? seleccionarClima = 'Seleccionar Tipo';

  Atencion atencion = Atencion();

/*  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agregar Atencion",
        ),
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
        backgroundColor: AppConfig.primaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              child: FutureBuilder<List<TipoAtencion>>(
                future: ProviderDataJson().getTipoAtencion(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TipoAtencion>> snapshot) {
                  TipoAtencion? depatalits;
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
                        // decoration: servicios.myBoxDecoration(),
                        child: DropdownButton<TipoAtencion>(
                      underline: SizedBox(),
                      isExpanded: true,
                      items: snapshot.data
                          ?.map((user) => DropdownMenuItem<TipoAtencion>(
                                child: Text(user.descripcion!),
                                value: user,
                              ))
                          .toList(),
                      onChanged: (TipoAtencion? newVal) {
                        depatalits = newVal!;
                        print(seleccionarClima);
                        seleccionarClima = newVal.descripcion;
                        atencion.tipoDescripcion = newVal.descripcion;
                        atencion.tipo = newVal.cod;
                        setState(() {});
                      },
                      value: depatalits,
                      hint: Text("${seleccionarClima} "),
                    ));
                  }
                },
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  atencion.atendidos = int.parse(value);
                },
                decoration: InputDecoration(
                  labelText: 'Atendidos',
                  //   hintText: 'Atendidos',
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                onChanged: (value) {
                  atencion.atenciones = int.parse(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Atenciones',
                  //   hintText: 'Atendidos',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppConfig.primaryColor),
                ),
                child: Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (atencion.tipoDescripcion == null ||
                      atencion.tipo == null ||
                      atencion.atenciones == null ||
                      atencion.atendidos == null) {
                    Util().showAlertDialog('Atenciones Realizadas',
                        'Ingresar los datos correspondientes', context, () {
                      Navigator.pop(context);
                    });
                  } else {
                    var respt = await DatabasePias.db.buscarTipoAtencion(
                        atencion.tipo, widget.idUnicoReporte);

                    if (respt.isEmpty) {
                      atencion.idUnicoReporte = widget.idUnicoReporte;
                      var aed = await DatabasePias.db.insertAtencion(atencion);
                      if (aed > 0) {
                        Navigator.pop(context, 'atencion');
                        //   Navigator.of(context).pop();
                        //traerUltimo();
                      }
                    } else {
                      Util().showAlertDialog(
                          'Atenciones Realizadas',
                          'Atencion ingresada con anterioridad, por favor seleccionar otro servicio.',
                          context, () {
                        Navigator.pop(context);
                      });
                    }
                  }

                  /* if(atencion.atenciones==0){
                  }
                  atencion.idUnicoReporte = widget.idUnicoReporte;
                  var aed=    await DatabasePias.db.insertAtencion(atencion);
                    if (aed > 0) {
                      Navigator.pop(context, 'atencion');
                   //   Navigator.of(context).pop();
                      //traerUltimo();
                    }*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
