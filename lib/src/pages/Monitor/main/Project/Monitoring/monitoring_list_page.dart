import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';

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
  List<TramaMonitoreoModel> aMonResp = [];
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

  Future<void> loadData(BuildContext context) async {
    try {
      if (widget.datoProyecto != null) {
        _oProject = widget.datoProyecto!;
        aMonResp =
            await mainController.getAllMonitoreoByProyecto(_oProject, 0, 0);

        ///Comentar: Data solo para pruebas
        // TramaMonitoreoModel o1 = TramaMonitoreoModel();
        // o1.idMonitoreo = "122_IDE_01-10-2022";
        // o1.actividadPartidaEjecutada = "Cimentación";
        // o1.estadoMonitoreo = "INCOMPLETO";
        // o1.fechaMonitoreo = "01-10-2022";
        // o1.estadoAvance = "Reinicio";
        // o1.avanceFisicoAcumulado = 1;
        // o1.nivelRiesgo = "Alto";
        // aMonResp.add(o1);

        ///Comentar: Data solo para pruebas
        // TramaMonitoreoModel o3 = TramaMonitoreoModel();
        // o3.idMonitoreo = "124_IDE_01-10-2022";
        // o3.actividadPartidaEjecutada = "obras Exteriores";
        // o3.estadoMonitoreo = "ENVIADO";
        // o3.fechaMonitoreo = "01-10-2022";
        // o3.estadoAvance = "Por iniciar";
        // o3.avanceFisicoAcumulado = 1;
        // o3.nivelRiesgo = "Medio Alto";
        // aMonResp.add(o3);
      } else {
        isResume = true;
        aMonResp = await mainController.getAllMonitorPorEnviar(0, 0);
      }
    } catch (oError) {
      mostrarAlerta(
          context!, "Warning!", "No se encontraron registros para mostrar.");
    }

    ///Comentar: Data solo para pruebas
    // TramaMonitoreoModel o2 = TramaMonitoreoModel();
    // o2.idMonitoreo = "123_IDE_01-10-2022";
    // o2.actividadPartidaEjecutada = "Muros y Columnas";
    // o2.estadoMonitoreo = "POR ENVIAR";
    // o2.fechaMonitoreo = "01-10-2022";
    // o2.estadoAvance = "Ejecución";
    // o2.avanceFisicoAcumulado = 1;
    // o2.nivelRiesgo = "Muy Alto";
    // aMonResp.add(o2);

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
      body: Container(
        child: aMonResp.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: aMonResp.length,
                itemBuilder: (context, index) {
                  String experienceLevelColor = "4495FF";
                  return ListaMonitores(
                      context: context, oMonitoreo: aMonResp[index]);
                },
              )
            : Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 246, 248)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "No existe Monitores, Verificar su conexión",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ListaMonitores extends StatelessWidget {
  ListaMonitores({
    Key? key,
    required this.context,
    required this.oMonitoreo,
  }) : super(key: key);

  final MainController mainController = MainController();
  final BuildContext context;
  final TramaMonitoreoModel oMonitoreo;

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

  @override
  Widget build(BuildContext context) {
    String experienceLevelColor = "4495FF";
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
          Row(
            children: [
              Chip(
                  label: Text(oMonitoreo.actividadPartidaEjecutada!),
                  backgroundColor: Colors.green,
                  labelStyle: const TextStyle(color: Colors.white)),
              const Padding(padding: EdgeInsets.all(10.0)),
              Chip(
                label: Text(oMonitoreo.estadoMonitoreo!),
                backgroundColor: getColorByStatus(oMonitoreo.estadoMonitoreo!),
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
                                oMonitoreo.estadoAvance!,
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
                                '${oMonitoreo.avanceFisicoAcumulado!}%',
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
                                oMonitoreo.nivelRiesgo!,
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
                                oMonitoreo.fechaMonitoreo!,
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
              if (isUpdate(oMonitoreo.estadoMonitoreo!))
                GestureDetector(
                  onTap: () async {
                    BusyIndicator.show(context);
                    String sMsg = await syncMonitor(context, [oMonitoreo]);

                    // setState(() {
                    //   loadData(context);
                    // });

                    BusyIndicator.hide(context);
                    if (sMsg != "") {
                      await Future.delayed(const Duration(milliseconds: 100));
                      mostrarAlerta(context, "Error!", sMsg);
                    }
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
                        Icons.upload,
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
                    if (isEditDelete(oMonitoreo.estadoMonitoreo!))
                      GestureDetector(
                        onTap: () {
                          //Navigator.of(context).push(MaterialPageRoute( builder: (context) => MonitorList(datoProyecto: _oProject), ));
                        },
                        child: AnimatedContainer(
                          height: 35,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 15),
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 179, 177, 177),
                                  width: 1.0,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(
                                      int.parse("0xff${experienceLevelColor}"))
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
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => MonitoringDetailNewEditPage(),
                        // ));
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
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
                    if (isEditDelete(oMonitoreo.estadoMonitoreo!))
                      GestureDetector(
                        onTap: () {},
                        child: AnimatedContainer(
                          height: 35,
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 15),
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 179, 177, 177),
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
                Text(
                  oMonitoreo.idMonitoreo!,
                  style: const TextStyle(
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
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListaMonitores(
                  context: context, oMonitoreo: searchMonitor[index]);
            },
          );
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
