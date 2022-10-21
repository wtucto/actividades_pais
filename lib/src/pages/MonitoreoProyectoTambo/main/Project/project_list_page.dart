import 'dart:async';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_list_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/project_detail_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_detail_form_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/fab.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/throw-exception.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;
MainController mainController = MainController();

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({Key? key}) : super(key: key);

  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage>
    with TickerProviderStateMixin<ProjectListPage> {
  List<TramaProyectoModel> aProyecto = [];

  Animation<double>? _animation;
  AnimationController? _controller;

  ScrollController scrollController = ScrollController();
  bool loading = true;
  bool isEndPagination = false;
  int offset = 0;
  int limit = 50;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    readJson(offset);
    handleNext();
  }

  @override
  void dispose() {
    scrollController.removeListener(() async {});
    super.dispose();
  }

  Future<void> readJson(paraOffset) async {
    if (!isEndPagination) {
      setState(() {
        loading = true;
      });

      _prefs = await SharedPreferences.getInstance();
      UserModel oUser = UserModel(
        nombres: _prefs!.getString('nombres') ?? '',
        codigo: _prefs!.getString('codigo') ?? '',
        rol: _prefs!.getString('rol') ?? '',
      );

      final List<TramaProyectoModel> response =
          await mainController.getAllProyectoByUserSearch(
        oUser,
        '',
        limit,
        offset,
      );
      if (response.length == 0) {
        isEndPagination = true;
      } else {
        aProyecto = aProyecto + response;
        offset = offset + limit;
      }
      setState(() {
        loading = false;
      });
    }
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        readJson(offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Center(
          child: Text(
            'ProjectListTitle'.tr,
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
                delegate: CustomSearch(aProyecto),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
            setState(() {
              isEndPagination = false;
              readJson(offset);
            });
          },
          child: aProyecto.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        controller: scrollController,
                        itemCount: aProyecto.length,
                        itemBuilder: (context, index) {
                          return ListaProyectos(
                            context: context,
                            oProyecto: aProyecto[index],
                          );
                        },
                      ),
                    ),
                    if (loading == true)
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 40,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (isEndPagination == true)
                      Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        color: Colors.blue,
                        child: const Center(
                          child: Text('Has obtenido todo el contenido.'),
                        ),
                      ),
                  ],
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
                        'No existe nigún proyecto asignado',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Nuevo Monitoreo",
            Icons.add_to_queue,
            onPress: () {
              _controller!.reverse();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MonitoringDetailNewEditPage(
                      datoProyecto: null,
                    );
                  },
                ),
              );
            },
          ),
          FabItem(
            "Otros Monitoreos",
            Icons.remove_red_eye,
            onPress: () {
              _controller!.reverse();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const MonitorList(
                      estadoM: 'OTROS',
                    );
                  },
                ),
              );
            },
          ),
          // FabItem(
          //   "Reporte",
          //   Icons.document_scanner_rounded,
          //   onPress: () {
          //     _controller!.reverse();
          //     final oDataPdf = ReportDto(
          //       customer: 'David Thomas',
          //       address: '123 Fake St\r\nBermuda Triangle',
          //       items: [
          //         TramaMonitoreoModel.empty(),
          //         TramaMonitoreoModel.empty(),
          //         TramaMonitoreoModel.empty(),
          //       ],
          //       name: 'Test 001 PDF',
          //     );

          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (builder) => ReportProjectPage(dataPdf: oDataPdf),
          //       ),
          //     );
          //   },
          // ),
          FabItem(
            "Sincronizar",
            Icons.cloud_sync_rounded,
            onPress: () async {
              BusyIndicator.show(context);
              await mainController.syncLoadInitialData();
              BusyIndicator.hide(context);
              _controller!.reverse();
              Fluttertoast.showToast(
                msg: 'Los registros se sincronizan con éxito',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Color.fromARGB(255, 133, 243, 168),
                textColor: Colors.black,
                fontSize: 16.0,
              );
            },
          ),
        ],
        animation: _animation!,
        onPress: () {
          if (_controller!.isCompleted) {
            _controller!.reverse();
          } else {
            _controller!.forward();
          }
        },
      ),
    );
  }
}

class ListaProyectos extends StatelessWidget {
  const ListaProyectos({
    Key? key,
    required this.context,
    required this.oProyecto,
  }) : super(key: key);

  final BuildContext context;
  final TramaProyectoModel oProyecto;

  void sendMonitoreoPorEnviarByProject() async {
    try {
      List<TramaMonitoreoModel> aError =
          await mainController.sendMonitoreoByProyecto(oProyecto);
      if (aError.isNotEmpty) {
        mostrarAlerta(
          context,
          'Error!',
          'Existen documentos que no se puedieron enviar, verifique que todo los datos sean correctos.',
        );
      } else {
        mostrarAlerta(
          context,
          'Success!',
          'Se enviaron los registros correctamente.',
        );
      }
    } catch (oError) {
      var sTitle = "Alerta";
      var sMessage = oError.toString();
      if (oError is ThrowCustom) {
        sTitle = oError.typeText!;
        sMessage = oError.msg!;
      }
      mostrarAlerta(
        context,
        sTitle,
        sMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String experienceLevelColor = '4495FF';
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
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  Container(
                    // width: 60,
                    // height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CircularPercentIndicator(
                        radius: 30.0,
                        lineWidth: 5.0,
                        percent:
                            double.parse(oProyecto.avanceFisico.toString()),
                        center: Text(
                          "${double.parse(oProyecto.avanceFisico.toString()) * 100}%",
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        progressColor: ((double.parse(
                                        oProyecto.avanceFisico.toString()) *
                                    100) >=
                                50
                            ? Colors.green
                            : (double.parse(oProyecto.avanceFisico.toString()) *
                                        100) <=
                                    30
                                ? Colors.red
                                : Colors.yellow),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(oProyecto.tambo!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(oProyecto.estado!,
                              style: TextStyle(color: Colors.grey[500])),
                        ]),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MonitorList(
                      datoProyecto: oProyecto,
                    ),
                  ));
                },
                child: AnimatedContainer(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 179, 177, 177),
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200),
                  child: const Center(
                    child: Icon(
                      Icons.dynamic_feed,
                      color: Color.fromARGB(255, 85, 84, 84),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return MonitoringDetailNewEditPage(
                                  datoProyecto: oProyecto, statusM: "CREATE");
                            },
                          ),
                        );
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
                          color: Color(int.parse('0xff${experienceLevelColor}'))
                              .withAlpha(20),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add_to_queue,
                            color: Color.fromARGB(255, 56, 54, 54),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProjectDetailPage(datoProyecto: oProyecto),
                        ));
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
                                Color(int.parse('0xff${experienceLevelColor}'))
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
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MonitorList(
                              datoProyecto: oProyecto, estadoM: 'PE'),
                        ));
                        // sendMonitoreoPorEnviarByProject();
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
                                Color(int.parse('0xff${experienceLevelColor}'))
                                    .withAlpha(20)),
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
                Text(
                  oProyecto.cui!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 13, 0, 255),
                    fontSize: 14,
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

class CustomSearch extends SearchDelegate<String> {
  List<TramaProyectoModel> searchaProyecto;
  CustomSearch(this.searchaProyecto);
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
    for (var item in searchaProyecto) {
      if ((item.cui!).contains(query.toLowerCase()) ||
          (item.tambo!).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add('${item.cui} - ${item.tambo}');
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
      for (var item in searchaProyecto) {
        if (item.cui == splitted[0]) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListaProyectos(context: context, oProyecto: item);
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
              // 2. Close Search & Return Result
              // close(context, suggestion);
              // 3. Navigate to Result Page
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
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
