import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/listView/ListaProyectos.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/search/project_search.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

MainController mainController = MainController();

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<TramaProyectoModel> aProyecto1 = [];
  List<TramaProyectoModel> aProyecto2 = [];
  List<TramaProyectoModel> aProyecto3 = [];
  List<TramaProyectoModel> aProyecto4 = [];
  List<TramaProyectoModel> aProyectoAll = [];

  List<TramaProyectoModel> aProyecto = [];
  ScrollController scrollController = ScrollController();
  final _txtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    buildData();
  }

  List<ChartData> chartData = [
    //1 - Verde       80D8A4
    //2 - Amarillo    FEE191
    //3 - Rojo        E84258
    ChartData('MUY ALTO', 0, const Color(0xFF2196F3)),
    ChartData('ALTO', 0, const Color(0xFF80D8A4)),
    ChartData('MEDIO', 0, const Color(0xFFFEE191)),
    ChartData('BAJO', 0, const Color(0xFFE84258)),
  ];

  Future<void> buildData() async {
    aProyecto1 = [];
    aProyecto2 = [];
    aProyecto3 = [];
    aProyecto4 = [];

    aProyectoAll = await mainController.getAllProyectoDashboard("");

    aProyectoAll.sort((a, b) => a.avanceFisico!.compareTo(b.avanceFisico!));

    for (var o in aProyectoAll) {
      int iSection = getAvancefisicoChar(o);
      switch (iSection) {
        case 1: /* MUL ALTO*/
          aProyecto1.add(o);
          break;
        case 2: /* ALTO*/
          aProyecto2.add(o);
          break;
        case 3: /* BAJO*/
          aProyecto3.add(o);
          break;
        case 4: /* MEDIO */
          aProyecto4.add(o);
          break;
        default:
      }
    }

    setState(() {
      aProyecto = aProyectoAll;
      chartData = [
        //1 - Verde       80D8A4
        //2 - Amarillo    FEE191
        //3 - Rojo        E84258
        ChartData('MUY ALTO', aProyecto1.length, const Color(0xFF2196F3)),
        ChartData('ALTO', aProyecto2.length, const Color(0xFF80D8A4)),
        ChartData('MEDIO', aProyecto3.length, const Color(0xFFFEE191)),
        ChartData('BAJO', aProyecto4.length, const Color(0xFFE84258)),
      ];
    });
  }

  Color getColorAvancefisico(dynamic oProyecto) {
    try {
      return ((double.parse(oProyecto.avanceFisico.toString()) * 100) == 100
          ? Colors.blue
          : (double.parse(oProyecto.avanceFisico.toString()) * 100) >= 50
              ? Colors.green
              : (double.parse(oProyecto.avanceFisico.toString()) * 100) <= 30
                  ? Colors.red
                  : Colors.yellow);
    } catch (oError) {
      return Colors.black;
    }
  }

  int getAvancefisicoChar(dynamic oProyecto) {
    try {
      return ((double.parse(oProyecto.avanceFisico.toString()) * 100) == 100
          ? 1 /* MUL ALTO*/
          : (double.parse(oProyecto.avanceFisico.toString()) * 100) >= 50
              ? 2 /* ALTO*/
              : (double.parse(oProyecto.avanceFisico.toString()) * 100) <= 30
                  ? 4 /* BAJO*/
                  : 3); /* MEDIO */
    } catch (oError) {
      return 4;
    }
  }

  double getAvancefisico(dynamic oProyecto) {
    try {
      return double.parse(oProyecto.avanceFisico.toString());
    } catch (oError) {
      return 1;
    }
  }

  String getAvancefisicoText(dynamic oProyecto) {
    try {
      return "${((double.parse(oProyecto.avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%";
    } catch (oError) {
      return "NAN %";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_10o15,
        shadowColor: color_10o15,
        title: const Center(
          child: Text(
            "DASHBOARD PROYECTOS",
            style: TextStyle(
              color: color_01,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePagePais(),
                ));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () async {
                BusyIndicator.show(context);
                await buildData();
                BusyIndicator.hide(context);
              },
              icon: const Icon(
                Icons.restart_alt_outlined,
                color: color_01,
              ),
            ),
          ),
        ],
        /*
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 48,
            margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorGB,
              border: Border.all(color: Colors.blue),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _txtSearch,
              decoration: InputDecoration(
                icon: const Icon(Icons.search),
                suffixIcon: _txtSearch.text.isNotEmpty
                    ? GestureDetector(
                        child: const Icon(Icons.close),
                        onTap: () {
                          _txtSearch.clear();
                          searhProyectos("");
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: 'Buscar Tambo',
                border: InputBorder.none,
              ),
              onChanged: searhProyectos,
            ),
          ),
        ),
        */
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /**
                             * PIE CHART
                             */
                            Card(
                              color: colorGB,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                              child: SfCircularChart(
                                title: ChartTitle(
                                  text: 'ESTADOS DE TAMBOS',
                                  textStyle: const TextStyle(
                                    color: color_07,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  alignment: ChartAlignment.center,
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.right,
                                  orientation: LegendItemOrientation.vertical,
                                  overflowMode: LegendItemOverflowMode.wrap,
                                  textStyle: const TextStyle(
                                    color: color_07,
                                  ),
                                ),
                                onLegendTapped: (LegendTapArgs args) {
                                  //print(args.pointIndex);
                                },
                                series: [
                                  PieSeries<ChartData, String>(
                                    dataSource: chartData,
                                    pointColorMapper: (ChartData data, _) =>
                                        data.color,
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.top,
                                      margin: EdgeInsets.all(1),
                                    ),
                                    name: 'Data',
                                    //explode: true,
                                    //explodeIndex: 1,
                                    radius: '80%',
                                    onPointTap:
                                        (ChartPointDetails details) async {
                                      BusyIndicator.show(context);
                                      await Future<dynamic>.delayed(
                                          const Duration(milliseconds: 1000));
                                      int iIndex = details.pointIndex! + 1;
                                      switch (iIndex) {
                                        case 1: /* MUL ALTO*/
                                          aProyecto = aProyecto1;
                                          break;
                                        case 2: /* ALTO*/
                                          aProyecto = aProyecto2;
                                          break;
                                        case 3: /* BAJO*/
                                          aProyecto = aProyecto3;
                                          break;
                                        case 4: /* MEDIO */
                                          aProyecto = aProyecto4;
                                          break;
                                        default:
                                      }
                                      setState(() {});
                                      BusyIndicator.hide(context);
                                    },
                                  ),
                                ],
                              ),
                            ),

                            /**
                             * DATA
                             */
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Center(
                                child: Text(
                                  "PROYECTOS TAMBOS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: color_07,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Roboto-Bold',
                                  ),
                                ),
                              ),
                            ),
                            aProyecto.isNotEmpty
                                ? ListView.builder(
                                    itemCount: aProyecto.length,
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(10),
                                    itemBuilder: (context, index) {
                                      return ListaProyectos(
                                        context: context,
                                        oProyecto: aProyecto[index],
                                      );
                                    },
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: color_07,
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searhProyectos(String query) {
    final suggestions = aProyectoAll.where((item) {
      final nombre = item.tambo!.toLowerCase();
      final input = query.toLowerCase();
      return nombre.contains(input);
    }).toList();
    if (suggestions.isEmpty) {
      aProyecto = aProyectoAll;
    } else {
      setState(() => aProyecto = suggestions);
    }
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}
