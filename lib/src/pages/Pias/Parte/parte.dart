import 'dart:ui';

import 'package:actividades_pais/src/datamodels/Clases/ConsultarTambosPiasxUnidadTerritorial.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Campania.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/Clases/tipoPlataforma.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderConfiguracion.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Clima.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/PuntoAtencionPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:intl/intl.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderDataJson.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';

class Parte extends StatefulWidget {
  String plataforma, unidadTerritorial, idUnicoReporte;
  int idPlataforma;
  String long = '';
  String lat = '';
  String campaniaCod = '';

  Parte(
      {this.plataforma = "",
      this.unidadTerritorial = "",
      this.idPlataforma = 0,
      this.idUnicoReporte = '',
      this.long = '',
      this.lat = '',
      this.campaniaCod = ''});

  @override
  _ParteState createState() => _ParteState();
}

class _ParteState extends State<Parte> {
  var nombreUnidTerritoriales = "";
  var seleccionarUnidTerritoriales = "SELECCIONAR UNIDAD TERRITORIAL";
  var tablaid = 1;
  var idUnidTerritoriales = 0;

  TextEditingController fecha = TextEditingController();
  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  var seleccionarPuesto = 'Seleccionar';
  var seleccionarClima = 'seleccionarClima';
  TextEditingController controllerfecha = TextEditingController();
  TextEditingController controllerDetalle = TextEditingController();
  TextEditingController controllerPersonal = TextEditingController();
  TextEditingController controllerestadosEquipos = TextEditingController();
  TextEditingController controllerSismonitor = TextEditingController();
  ReportesPias reportePias = ReportesPias();
  var acnuevo = 0;
  var contadorTextDetalle = 0;
  Color colorTextDetalle = Colors.black;
  var underlineCbo = Container(
    height: 1,
    color: Color(0xFF1E88E5),
  );

  var seleccionarTpPla = "";

  int idTambo = 0;

  int snip = 0;

  String seleccionarTablaPlataforma = "SELECCIONAR";

  String nombreTambo = "";

  String seleccionarCamapania = "SELECCIONAR";

  String campania = "";

  int codCampania = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    traerUltimo();
    reportePias.latitud = widget.lat;
    reportePias.longitud = widget.long;
    reportePias.unidadTerritorial = widget.unidadTerritorial;
    reportePias.idPlataforma = widget.idPlataforma.toString();
    reportePias.plataforma = widget.plataforma;
    reportePias.idUnicoReporte = widget.idUnicoReporte;
    controllerfecha.text = widget.idUnicoReporte;
    reportePias.fechaParteDiario = widget.idUnicoReporte;
    reportePias.campania = widget.campaniaCod;
  }

  traerUltimo() async {
    var ar = await DatabasePias.db.traerUtlimoPorId(widget.idUnicoReporte);
    if (ar[0].id != null) {
      if (ar.length > 0) {
        controllerfecha.text = ar[0].fechaParteDiario;
        seleccionarPuesto = ar[0].puntoAtencion;
        controllerDetalle.text = ar[0].detallePuntoAtencion;
        controllerPersonal.text = ar[0].personal;
        controllerestadosEquipos.text = ar[0].estadoEquipos;
        controllerSismonitor.text = ar[0].sismonitor;
        seleccionarClima = ar[0].clima;
        reportePias.idClima = ar[0].idClima;
        reportePias.codigoUbigeo = ar[0].codigoUbigeo;
        reportePias.fechaParteDiario = ar[0].fechaParteDiario;
        reportePias.puntoAtencion = ar[0].puntoAtencion;
        reportePias.detallePuntoAtencion = ar[0].detallePuntoAtencion;
        reportePias.personal = ar[0].personal;
        reportePias.estadoEquipos = ar[0].estadoEquipos;
        reportePias.sismonitor = ar[0].sismonitor;
        reportePias.clima = ar[0].clima;
        acnuevo = 1;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: 350,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.blue[800],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Guardar',
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                ],
              ),
              onPressed: () async {
                if (acnuevo == 0) {
                  await DatabasePias.db.insertReportePias(reportePias);
                  traerUltimo();
                } else {
                  await DatabasePias.db.updateTask(reportePias);
                }
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Unidad Territorial: "),
                  (widget.unidadTerritorial == '')
                      ? Container(
                          child: SizedBox(
                            width: 200.0,
                            child: Container(
                              child: FutureBuilder<List<UnidadesTerritoriales>>(
                                future: ProviderServicios().getUnidadesTerr(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<UnidadesTerritoriales>>
                                        snapshot) {
                                  UnidadesTerritoriales depatalits;
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
                                        //decoration:   servicios.myBoxDecoration(),
                                        child: DropdownButton<
                                            UnidadesTerritoriales>(
                                      underline: underlineCbo,
                                      isExpanded: true,
                                      items: snapshot.data
                                          ?.map((user) => DropdownMenuItem<
                                                  UnidadesTerritoriales>(
                                                child: Text(
                                                    user.unidadTerritorial),
                                                value: user,
                                              ))
                                          .toList(),
                                      onChanged:
                                          (UnidadesTerritoriales? newVal) {
                                        setState(() {
                                          nombreUnidTerritoriales =
                                              newVal!.unidadTerritorial;
                                          depatalits = newVal;
                                          seleccionarUnidTerritoriales =
                                              newVal.unidadTerritorial;
                                          tablaid =
                                              newVal.id_UnidadesTerritoriales;
                                          idUnidTerritoriales =
                                              newVal.id_UnidadesTerritoriales;
                                          DatabasePr.db
                                              .getporidUnidadTeritoria(tablaid);
                                        });
                                      },
                                      hint: Text(
                                          "$seleccionarUnidTerritoriales",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      //     hint: Text("   $data_depara"),
                                    ));
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 200.0,
                          child: Text("${widget.unidadTerritorial}"),
                        ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Plataforma: "),
                  (widget.plataforma == '')
                      ? Container(
                          child: SizedBox(
                              width: 200.0,
                              child: Container(
                                child: FutureBuilder<
                                    List<RspoTambosPiasxUnidadTerritorial>?>(
                                  future: ProviderConfiguracion()
                                      .listaTambosPiasxUnidadTerritorial(
                                          'PIAS', tablaid),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<
                                              List<
                                                  RspoTambosPiasxUnidadTerritorial>?>
                                          snapshot) {
                                    RspoTambosPiasxUnidadTerritorial?
                                        depatalits;
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
                                          child: DropdownButton<
                                              RspoTambosPiasxUnidadTerritorial>(
                                        underline: underlineCbo,
                                        isExpanded: true,
                                        items: snapshot.data
                                            ?.map((user) => DropdownMenuItem<
                                                    RspoTambosPiasxUnidadTerritorial>(
                                                  child:
                                                      Text(user.nombreTambo!),
                                                  value: user,
                                                ))
                                            .toList(),
                                        onChanged:
                                            (RspoTambosPiasxUnidadTerritorial?
                                                newVal) {
                                          setState(() {
                                            depatalits = newVal!;
                                            seleccionarTablaPlataforma =
                                                newVal.nombreTambo!;
                                            idTambo = newVal.idPlataforma!;
                                            snip = newVal.snip!;
                                            nombreTambo = newVal.nombreTambo!;
                                            print(idTambo);

                                          });
                                        },
                                        value: depatalits,
                                        hint: Text(
                                            "$seleccionarTablaPlataforma",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0)),
                                      ));
                                    }
                                  },
                                ),

                                ///getporidUnidadTeritoria
                              )))
                      : SizedBox(
                          width: 200.0,
                          child: SizedBox(
                            width: 200.0,
                            child: Text("${widget.plataforma}"),
                          ),
                        ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 10,
                ),
                Text("CAMPAÑA: "),
                SizedBox(
                  width: 200.0,
                  child: Container(
                    child: FutureBuilder<List<Campania>>(
                      future: ProviderDataJson().getCamapanias(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Campania>> snapshot) {
                        Campania? depatalits;
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
                              //  decoration:
                              //    servicios.myBoxDecoration(),
                              child: DropdownButton<Campania>(
                            underline: underlineCbo,
                            isExpanded: true,
                            items: snapshot.data
                                ?.map((user) => DropdownMenuItem<Campania>(
                                      child: Text(user.descripcion),
                                      value: user,
                                    ))
                                .toList(),
                            onChanged: (Campania? newVal) {
                              setState(() {
//await

                                depatalits = newVal!;
                                seleccionarCamapania = newVal.descripcion;
                                campania = newVal.descripcion;
                                codCampania = int.parse(newVal.cod);
                              });
                            },
                            value: depatalits,
                            hint: Text("$seleccionarCamapania",
                                style: TextStyle(color: Colors.black)),
                          ));
                        }
                      },
                    ),
                  ),
                )
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Punto de Atencion: "),
                  (widget.plataforma =='')?
                  SizedBox(
                    width: 200.0,
                    child: Container(
                      child: FutureBuilder<List<PuntoAtencionPias>>(
                        future: ProviderServiciosRest().listarPuntoAtencionPias(
                            codCampania.toString(), idTambo, 0),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<PuntoAtencionPias>> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                child: DropdownButton<PuntoAtencionPias>(
                              underline: SizedBox(),
                              isExpanded: true,
                              items: snapshot.data
                                  ?.map((user) =>
                                      DropdownMenuItem<PuntoAtencionPias>(
                                        child: Text(user.puntoAtencion!),
                                        value: user,
                                      ))
                                  .toList(),
                              onChanged: (PuntoAtencionPias? newVal) {
                                setState(() {
                                  seleccionarPuesto = newVal!.puntoAtencion!;
                                  reportePias.puntoAtencion = seleccionarPuesto;
                                  reportePias.codigoUbigeo =
                                      newVal.codigoUbigeo!;
                                });
                              },
                              hint: Text("$seleccionarPuesto", style: TextStyle(color: Colors.black)),
                            ));
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  ): SizedBox(
                    width: 200.0,
                    child: Container(
                      ///      child: TextField()
                      child: FutureBuilder<List<PuntoAtencionPias>>(
                        future: DatabasePias.db.ListarPuntoAtencionPias(
                            widget.campaniaCod, widget.idPlataforma),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<PuntoAtencionPias>> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                child: DropdownButton<PuntoAtencionPias>(
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  items: snapshot.data
                                      ?.map((user) =>
                                      DropdownMenuItem<PuntoAtencionPias>(
                                        child: Text(user.puntoAtencion!),
                                        value: user,
                                      ))
                                      .toList(),
                                  onChanged: (PuntoAtencionPias? newVal) {
                                    setState(() {
                                      // depatalits = newVal!;
                                      // seleccionarPuesto = newVal.puntoAtencion!;
                                      seleccionarPuesto = newVal!.puntoAtencion!;
                                      reportePias.puntoAtencion = seleccionarPuesto;
                                      reportePias.codigoUbigeo =
                                      newVal.codigoUbigeo!;
                                    });
                                  },
                                  hint: Text("  $seleccionarPuesto "),
                                ));
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Fecha: "),
                  SizedBox(
                      width: 200.0,
                      child: TextField(
                        controller: controllerfecha,
                        decoration: InputDecoration(),
                        onTap: () async {
                          nowfec = await showDatePicker(
                              context: context,
                              initialDate: nowfec!,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));

                          setState(() {
                            controllerfecha.text
                                .replaceAll('', formatter.format(nowfec!));
                            controllerfecha.text = formatter.format(nowfec!);
                            reportePias.fechaParteDiario = controllerfecha.text;
                          });
                        },
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerDetalle,
                        onChanged: (value) {
                          reportePias.detallePuntoAtencion = value;
                        },
                        //  onChanged: (value) {
                        /*     reportePias.detallePuntoAtencion = value;
                          print(value.length);
                          setState(() {
                            contadorTextDetalle = value.length;
                            if (contadorTextDetalle > 200) {
                              colorTextDetalle = Colors.red;
                            } else {
                              colorTextDetalle = Colors.black;
                            }
                          });*/
                        //  },
                        maxLength: 200,
                        maxLines: 5,
                        //or null
                        decoration:
                            InputDecoration.collapsed(hintText: "Detalle"),
                      ),
                    )),
              ),
              /*       Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      "Carácter maximo ($contadorTextDetalle /200)",
                      style: TextStyle(color: colorTextDetalle),
                    ),
                  ),
                ],
              ),*/
              //  _lineas(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerPersonal,
                        onChanged: (value) {
                          reportePias.personal = value;
                        },
                        maxLines: 1,
                        maxLength: 100,
                        //or null
                        decoration: InputDecoration(
                          labelText: 'Personal:',
                        ),
                      ),
                    )),
              ),
              // _lineas(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 100,
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerestadosEquipos,
                        onChanged: (value) {
                          reportePias.estadoEquipos = value;
                        },
                        maxLines: 1,
                        //or null
                        decoration: InputDecoration(
                          labelText: 'Estados de los Equipos: ',
                        ),
                      ),
                    )),
              ),
              // _lineas(),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: controllerSismonitor,
                        onChanged: (value) {
                          reportePias.sismonitor = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Sismonitor:',
                        ),
                        maxLength: 100,
                      ),
                    )),
              ),
              //_lineas(),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Text('Clima'),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: FutureBuilder<List<CLima>>(
                  future: ProviderDataJson().getSaveClima(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CLima>> snapshot) {
                    CLima? depatalits;
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
                          child: DropdownButton<CLima>(
                        underline: SizedBox(),
                        isExpanded: true,
                        items: snapshot.data
                            ?.map((user) => DropdownMenuItem<CLima>(
                                  child: Text(user.descripcion),
                                  value: user,
                                ))
                            .toList(),
                        onChanged: (CLima? newVal) {
                          setState(() {
                            depatalits = newVal!;
                            seleccionarClima = newVal.descripcion;
                            reportePias.idClima = newVal.cod;
                            reportePias.clima = seleccionarClima;
                          });
                        },
                        value: depatalits,
                        hint: Text("  $seleccionarClima "),
                      ));
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  _linea() {
    return Column(
      children: [
        SizedBox(
          height: 2,
          child: Container(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 2,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
