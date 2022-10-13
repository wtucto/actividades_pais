import 'dart:convert';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_list_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/project_detail_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_detail_new_edit_page.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:get/get.dart';

class MonitorList extends StatefulWidget {
  const MonitorList({Key? key, this.datoProyecto}) : super(key: key);

  final TramaProyectoModel? datoProyecto;

  static _MonitorListState of(BuildContext context) {
    return context.findAncestorStateOfType<_MonitorListState>()!;
  }

  @override
  _MonitorListState createState() => _MonitorListState();
}

class _MonitorListState extends State<MonitorList> {
  bool _isLoading = false;
  MainController mainController = MainController();
  late TramaProyectoModel _oProject = TramaProyectoModel.empty();
  late bool isResume = false;

  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  void show() {
    ///MonitorList.of(context).show();
    setState(() {
      _isLoading = true;
    });
  }

  void hide() {
    ///MonitorList.of(context).hide();
    setState(() {
      _isLoading = false;
    });
  }

  late List<TramaMonitoreoModel> aMonResp = [];

  Future<void> loadData(BuildContext context) async {
    try {
      if (widget.datoProyecto != null) {
        _oProject = widget.datoProyecto!;
        aMonResp =
            await mainController.getAllMonitoreoByProyecto(_oProject, 0, 0);

        ///Comentar: Data solo para pruebas
        TramaMonitoreoModel o1 = TramaMonitoreoModel();
        o1.idMonitoreo = "122_IDE_01-10-2022";
        o1.actividadPartidaEjecutada = "Cimentación";
        o1.estadoMonitoreo = "INCOMPLETO";
        o1.fechaMonitoreo = "01-10-2022";
        o1.estadoAvance = "Reinicio";
        o1.avanceFisicoAcumulado = 1;
        o1.nivelRiesgo = "Alto";
        aMonResp.add(o1);

        ///Comentar: Data solo para pruebas
        TramaMonitoreoModel o3 = TramaMonitoreoModel();
        o3.idMonitoreo = "124_IDE_01-10-2022";
        o3.actividadPartidaEjecutada = "obras Exteriores";
        o3.estadoMonitoreo = "ENVIADO";
        o3.fechaMonitoreo = "01-10-2022";
        o3.estadoAvance = "Por iniciar";
        o3.avanceFisicoAcumulado = 1;
        o3.nivelRiesgo = "Medio Alto";
        aMonResp.add(o3);
      } else {
        isResume = true;
        aMonResp = await mainController.getAllMonitorPorEnviar(0, 0);
      }
    } catch (oError) {
      mostrarAlerta(
          context!, "Warning!", "No se encontraron registros para mostrar.");
    }

    ///Comentar: Data solo para pruebas
    TramaMonitoreoModel o2 = TramaMonitoreoModel();
    o2.idMonitoreo = "123_IDE_01-10-2022";
    o2.actividadPartidaEjecutada = "Muros y Columnas";
    o2.estadoMonitoreo = "POR ENVIAR";
    o2.fechaMonitoreo = "01-10-2022";
    o2.estadoAvance = "Ejecución";
    o2.avanceFisicoAcumulado = 1;
    o2.nivelRiesgo = "Muy Alto";
    aMonResp.add(o2);

    setState(() {});
  }

  Color getColorByStatus(String estadoMonitoreo) {
    Color c = Colors.green;
    switch (estadoMonitoreo) {
      case TramaMonitoreoModel.sEstadoINC:
        c = Color.fromARGB(255, 255, 115, 96);
        break;
      case TramaMonitoreoModel.sEstadoPEN:
        c = Color.fromARGB(249, 255, 152, 0);
        break;
      case TramaMonitoreoModel.sEstadoENV:
        c = Colors.green;
        break;
    }
    return c;
  }

  bool isUpdate(String estadoMonitoreo) {
    bool isUpdae = false;
    switch (estadoMonitoreo) {
      case TramaMonitoreoModel.sEstadoINC:
        isUpdae = false;
        break;
      case TramaMonitoreoModel.sEstadoPEN:
        isUpdae = true;
        break;
      case TramaMonitoreoModel.sEstadoENV:
        isUpdae = false;
        break;
      default:
    }
    return isUpdae;
  }

  bool isEditDelete(String estadoMonitoreo) {
    bool isUpdae = false;
    switch (estadoMonitoreo) {
      case TramaMonitoreoModel.sEstadoINC:
        isUpdae = true;
        break;
      case TramaMonitoreoModel.sEstadoPEN:
        isUpdae = true;
        break;
      case TramaMonitoreoModel.sEstadoENV:
        isUpdae = false;
        break;
      default:
    }
    return isUpdae;
  }

  Future<String> syncMonitor(
      BuildContext context, List<TramaMonitoreoModel> a) async {
    String sMsg = "";
    try {
      List<TramaMonitoreoModel> aResp = await mainController.sendMonitoreo(a);

      if (aResp.length > 0) {
        sMsg =
            'Hay registros que no se pudieron enviar al servidor porque generaron un error: ${aResp.length}';
      }
    } catch (oError) {
      sMsg = '¡Ups! Algo salió mal, vuelve a intentarlo mas tarde.';
    }
    //throw Exception('¡Ups! Algo salió mal, vuelve a intentarlo mas tarde.');
    return sMsg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 124, 205),
        elevation: 0,
        leadingWidth: 20,
        /*
        -- Navigation button
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade600,
          ),
        ),
        */
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          )
        ],
        title: Center(
          child: Text(
            'MonitoringListTitle'.tr,
            style: const TextStyle(
              color: const Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20.0,
            ),
          ),
        ), /*Container(
          height: 45,
          child: TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              hintText: "Buscar",
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),*/
      ),
      body: Container(
        child: aMonResp.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: aMonResp.length,
                itemBuilder: (context, index) {
                  return jobComponent(
                    context: context,
                    oMonitoreo: aMonResp[index],
                  );
                },
              )
            : Center(child: Text('EmptyData'.tr)),
      ),
    );
  }

  jobComponent({
    required BuildContext context,
    required TramaMonitoreoModel oMonitoreo,
  }) {
    String experienceLevelColor = "4495FF";
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Chip(
                  label: Text(oMonitoreo.actividadPartidaEjecutada!),
                  backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white)),
              Padding(padding: EdgeInsets.all(10.0)),
              Chip(
                label: Text(oMonitoreo.estadoMonitoreo!),
                backgroundColor: getColorByStatus(oMonitoreo.estadoMonitoreo!),
                labelStyle: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Estado Avance: ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 62, 61, 61),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                oMonitoreo.estadoAvance!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Avance Fisico Acumulado: ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 62, 61, 61),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${oMonitoreo.avanceFisicoAcumulado!}%',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Nivel Riesgo: ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 62, 61, 61),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                oMonitoreo.nivelRiesgo!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Fecha Monitoreo: ',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 62, 61, 61),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                oMonitoreo.fechaMonitoreo!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                ]),
              ),
              if (isUpdate(oMonitoreo.estadoMonitoreo!))
                GestureDetector(
                  onTap: () async {
                    BusyIndicator.show(context);
                    String sMsg = await syncMonitor(context, [oMonitoreo]);

                    setState(() {
                      loadData(context);
                    });

                    BusyIndicator.hide(context);
                    if (sMsg != "") {
                      await Future.delayed(const Duration(milliseconds: 100));
                      mostrarAlerta(context, "Error!", sMsg);
                    }
                  },
                  child: AnimatedContainer(
                    height: 35,
                    padding: EdgeInsets.all(5),
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      border: new Border.all(
                        color: Color.fromARGB(255, 179, 177, 177),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Color(
                        int.parse("0xff${experienceLevelColor}"),
                      ).withAlpha(20),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.upload,
                        color: Color.fromARGB(255, 38, 173, 108),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (isEditDelete(oMonitoreo.estadoMonitoreo!))
                      GestureDetector(
                        onTap: () {
                          //Navigator.of(context).push(MaterialPageRoute( builder: (context) => MonitorList(datoProyecto: _oProject), ));
                        },
                        child: AnimatedContainer(
                          height: 35,
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              border: new Border.all(
                                  color: Color.fromARGB(255, 179, 177, 177),
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(
                                      int.parse("0xff${experienceLevelColor}"))
                                  .withAlpha(20)),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 56, 54, 54),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => MonitoringDetailNewEditPage(),
                        // ));
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: new Border.all(
                                color: Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                        child: Center(
                          child: Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 56, 54, 54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (isEditDelete(oMonitoreo.estadoMonitoreo!))
                      GestureDetector(
                        onTap: () {},
                        child: AnimatedContainer(
                          height: 35,
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            border: new Border.all(
                                color: Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color: Color(
                              int.parse("0xff${experienceLevelColor}"),
                            ).withAlpha(20),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 241, 85, 64),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Text(
                  oMonitoreo.idMonitoreo!,
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 0, 255),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
