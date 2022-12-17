import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/listView/ListaProyectos.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

SharedPreferences? _prefs;
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
        title: const Center(
          child: Text("Dashboard Monitor"),
        ),
        //shape: const CustomAppBarShape(multi: 0.05),
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
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 0.12),
                    width: 1.1,
                  ),
                  //borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
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
                                color: const Color(0xFFF5F5F5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                                child: SfCircularChart(
                                  title: ChartTitle(
                                    text: 'ESTADOS DE TAMBOS',
                                    textStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 116, 227, 1),
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
                                      color: Color.fromRGBO(0, 116, 227, 1),
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
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                        isVisible: true,
                                        labelAlignment:
                                            ChartDataLabelAlignment.top,
                                        margin: EdgeInsets.all(1),
                                      ),
                                      name: 'Data',
                                      //explode: true,
                                      //explodeIndex: 1,
                                      radius: '80%',
                                      onPointTap: (ChartPointDetails details) {
                                        //print(details.pointIndex);
                                        //print(details.seriesIndex);
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
                                child: const Text(
                                  "PROYECTOS TAMBOS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 116, 227, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Roboto-Bold',
                                  ),
                                ),
                              ),
                              ListView.builder(
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
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

class CustomAppBarShape extends ContinuousRectangleBorder {
  final double multi;
  const CustomAppBarShape({this.multi = 0.5});
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double height = rect.height;
    double width = rect.width;
    var path = Path();
    path.lineTo(0, height + width * multi);
    path.arcToPoint(
      Offset(width * multi, height),
      radius: Radius.circular(width * multi),
    );
    path.lineTo(width * (1 - multi), height);
    path.arcToPoint(
      Offset(width, height + width * multi),
      radius: Radius.circular(width * multi),
    );
    path.lineTo(width, 0);
    path.close();

    return path;
  }
}
