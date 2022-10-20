import 'dart:async';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_detail_new_edit_page.dart';
import 'package:actividades_pais/util/alert_question.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class MonitorList extends StatefulWidget {
  const MonitorList({Key? key, this.datoProyecto, this.estadoM})
      : super(key: key);

  final TramaProyectoModel? datoProyecto;
  final String? estadoM;

  static _MonitorListState of(BuildContext context) {
    return context.findAncestorStateOfType<_MonitorListState>()!;
  }

  @override
  _MonitorListState createState() => _MonitorListState();
}

class _MonitorListState extends State<MonitorList> {
  List<TramaMonitoreoModel> aMonResp = [];
  bool _isLoading = false;
  MainController mainController = MainController();
  late TramaProyectoModel _oProject = TramaProyectoModel.empty();
  late bool isResume = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      loadData(context);
      setState(() {});
    }
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

  void showSnackbar({required bool success, required String text}) {
    AnimatedSnackBar.rectangle(
      'I'.tr,
      text,
      type:
          success ? AnimatedSnackBarType.success : AnimatedSnackBarType.warning,
      brightness: Brightness.light,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }

  Future<void> loadData(BuildContext context) async {
    try {
      if (widget.datoProyecto != null) {
        _oProject = widget.datoProyecto!;
        if (widget.estadoM == 'PE') {
          aMonResp =
              await mainController.getAllMonitorPorEnviar(0, 0, _oProject);
        } else {
          aMonResp =
              await mainController.getAllMonitoreoByProyecto(_oProject, 0, 0);
        }
      } else {
        isResume = true;
        if (widget.estadoM == 'OTROS') {
          _prefs = await SharedPreferences.getInstance();
          UserModel oUser = UserModel(
            nombres: _prefs!.getString("nombres") ?? "",
            codigo: _prefs!.getString("codigo") ?? "",
            rol: _prefs!.getString("rol") ?? "",
          );
          aMonResp = await mainController.getAllOtherMonitoreo(
            oUser,
            0,
            0,
          );
        } else {
          aMonResp = await mainController.getAllMonitorPorEnviar(
            0,
            0,
            TramaProyectoModel.empty(),
          );
        }
      }
    } catch (oError) {
      mostrarAlerta(
          context!, "Warning!", "No se encontraron registros para mostrar.");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Center(
            child: Text(
              'MonitoringListTitle'.tr,
              style: const TextStyle(
                color: Color(0xfffefefe),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchMonitor(aMonResp),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            setState(() {});
          },
          child: Container(
            child: aMonResp.isNotEmpty
                ? ListaMonitores(context: context, oMonitoreo: aMonResp)
                : Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 245, 246, 248)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "No existe Monitores",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        floatingActionButton: _getFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked);
  }

  Widget _getFAB() {
    if (aMonResp.isEmpty || widget.estadoM == null) {
      return Container();
    } else {
      if (widget.estadoM == "PE" || widget.estadoM == "ALL") {
        return FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              final alert = AlertQuestion(
                  title: "Información",
                  message: "¿Está Seguro de Enviar Monitores?",
                  onNegativePressed: () {
                    Navigator.of(context).pop();
                  },
                  onPostivePressed: () async {
                    Navigator.of(context).pop();
                    BusyIndicator.show(context);
                    String sMsg = await syncMonitor(context, aMonResp);
                    BusyIndicator.hide(context);
                    if (sMsg != "") {
                      await Future.delayed(const Duration(milliseconds: 100));
                      mostrarAlerta(context, "Error!", sMsg);
                    } else {
                      showSnackbar(
                        success: true,
                        text: 'Monitor Enviado Correctamente',
                      );
                      setState(() {});
                    }
                  });

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
            child: const Icon(Icons.cloud_upload_rounded));
      } else {
        return Container();
      }
    }
  }
}

class ListaMonitores extends StatefulWidget {
  List<TramaMonitoreoModel> oMonitoreo;
  ListaMonitores({
    Key? key,
    required this.context,
    required this.oMonitoreo,
  }) : super(key: key);

  final BuildContext context;

  @override
  State<ListaMonitores> createState() => _ListaMonitoresState();
}

class _ListaMonitoresState extends State<ListaMonitores> {
  final MainController mainController = MainController();

  Color getColorByStatus(String estadoMonitoreo) {
    Color c = Colors.green;
    switch (estadoMonitoreo) {
      case TramaMonitoreoModel.sEstadoINC:
        c = const Color.fromARGB(255, 255, 115, 96);
        break;
      case TramaMonitoreoModel.sEstadoPEN:
        c = const Color.fromARGB(249, 255, 152, 0);
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

  void showSnackbar({required bool success, required String text}) {
    AnimatedSnackBar.rectangle(
      'I'.tr,
      text,
      type:
          success ? AnimatedSnackBarType.success : AnimatedSnackBarType.warning,
      brightness: Brightness.light,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(widget.context);
  }

  @override
  Widget build(BuildContext context) {
    String experienceLevelColor = "4495FF";
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: widget.oMonitoreo.length, //widget.oMonitoreo.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.oMonitoreo[index].tambo!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 37, 71, 194),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Chip(
                      label: Text(
                          widget.oMonitoreo[index].actividadPartidaEjecutada!),
                      backgroundColor: Colors.green,
                      labelStyle: const TextStyle(color: Colors.white)),
                  const Padding(padding: EdgeInsets.all(10.0)),
                  Chip(
                    label: Text(widget.oMonitoreo[index].estadoMonitoreo!),
                    backgroundColor: getColorByStatus(
                        widget.oMonitoreo[index].estadoMonitoreo!),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(children: [
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Estado Avance: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.oMonitoreo[index].estadoAvance!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Avance Fisico Acumulado: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${widget.oMonitoreo[index].avanceFisicoAcumulado!}%',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Nivel Riesgo: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.oMonitoreo[index].nivelRiesgo!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Fecha Monitoreo: ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 62, 61, 61),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.oMonitoreo[index].fechaMonitoreo!,
                                    style: const TextStyle(
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
                  if (isUpdate(widget.oMonitoreo[index].estadoMonitoreo!))
                    GestureDetector(
                      onTap: () async {
                        final alert = AlertQuestion(
                            title: "Información",
                            message: "¿Está Seguro de Enviar Monitoreo?",
                            onNegativePressed: () {
                              Navigator.of(context).pop();
                            },
                            onPostivePressed: () async {
                              Navigator.of(context).pop();
                              BusyIndicator.show(context);
                              String sMsg = await syncMonitor(
                                  context, [widget.oMonitoreo[index]]);
                              BusyIndicator.hide(context);
                              if (sMsg != "") {
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                mostrarAlerta(context, "Error!", sMsg);
                              } else {
                                showSnackbar(
                                  success: true,
                                  text: 'Monitor Enviado Correctamente',
                                );
                                setState(() {});
                              }
                            });

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding: const EdgeInsets.all(5),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 179, 177, 177),
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Color(
                            int.parse("0xff${experienceLevelColor}"),
                          ).withAlpha(20),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.cloud_upload_rounded,
                            color: Color.fromARGB(255, 38, 173, 108),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (isEditDelete(
                            widget.oMonitoreo[index].estadoMonitoreo!))
                          GestureDetector(
                            onTap: () {
                              //Navigator.of(context).push(MaterialPageRoute( builder: (context) => MonitorList(datoProyecto: _oProject), ));
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MonitoringDetailNewEditPage(
                                        datoMonitor: widget.oMonitoreo[index],
                                        statusM: 'UPDATE'),
                              ));
                            },
                            child: AnimatedContainer(
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 179, 177, 177),
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(int.parse(
                                          "0xff${experienceLevelColor}"))
                                      .withAlpha(20)),
                              child: const Center(
                                child: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 56, 54, 54),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MonitoringDetailNewEditPage(
                                  datoMonitor: widget.oMonitoreo[index],
                                  statusM: 'LECTURA'),
                            ));
                          },
                          child: AnimatedContainer(
                            height: 35,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 15),
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 179, 177, 177),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(12),
                                color: Color(int.parse(
                                        "0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                            child: const Center(
                              child: Icon(
                                Icons.visibility,
                                color: Color.fromARGB(255, 56, 54, 54),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (isEditDelete(
                            widget.oMonitoreo[index].estadoMonitoreo!))
                          GestureDetector(
                            onTap: () async {
                              final alert = AlertQuestion(
                                  title: "Información",
                                  message:
                                      "¿Está Seguro de Eliminar Monitoreo?",
                                  onNegativePressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  onPostivePressed: () async {
                                    Navigator.of(context).pop();
                                    BusyIndicator.show(context);
                                    bool res =
                                        await mainController.deleteMonitor(
                                            widget.oMonitoreo[index]);
                                    BusyIndicator.hide(context);
                                    if (res) {
                                      showSnackbar(
                                        success: true,
                                        text: 'Monitor Eliminado Correctamente',
                                      );
                                      widget.oMonitoreo.removeAt(index);
                                      setState(() {});
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      AnimatedSnackBar.rectangle(
                                        'Error',
                                        'No se pudo Enviar Monitore',
                                        type: AnimatedSnackBarType.error,
                                        brightness: Brightness.light,
                                        mobileSnackBarPosition:
                                            MobileSnackBarPosition.top,
                                      ).show(context);
                                    }
                                  });

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            child: AnimatedContainer(
                              height: 35,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 15),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 179, 177, 177),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(12),
                                color: Color(
                                  int.parse("0xff${experienceLevelColor}"),
                                ).withAlpha(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 241, 85, 64),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.right,
                        widget.oMonitoreo[index].idMonitoreo!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 13, 0, 255),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomSearchMonitor extends SearchDelegate<String> {
  List<TramaMonitoreoModel> searchMonitor;
  CustomSearchMonitor(this.searchMonitor);
  final List<int> _data =
      List<int>.generate(100001, (int i) => i).reversed.toList();

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchMonitor) {
      if ((item.idMonitoreo!).contains(query.toLowerCase()) ||
          (item.estadoMonitoreo!).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add('${item.idMonitoreo} - ${item.estadoMonitoreo}');
      }
    }
    if (query.isEmpty || matchQuery.isEmpty) {
      return buildNoSuggestions();
    } else {
      return buildSuggestionsSuccess(matchQuery);
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;
    if (searched == null || !_data.contains(searched)) {
      final splitted = searched.split(' - ');
      for (var item in searchMonitor) {
        if (item.idMonitoreo == splitted[0]) {
          return ListaMonitores(context: context, oMonitoreo: [item]);
        }
      }
    }
    return buildNoSuggestions();
  }

  Widget buildNoSuggestions() => const Center(
        child: Text(
          '¡No hay sugerencias!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
            },
            leading: const Icon(Icons.search),
            title: RichText(
              text: TextSpan(
                text: suggestion,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      );
}
