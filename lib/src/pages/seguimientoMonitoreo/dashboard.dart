import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/SeguimientoMonitoreo/listView/ListaProyectos.dart';
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
  List<TramaProyectoModel> aProyecto = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
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
      0,
      0,
    );
    setState(() {
      aProyecto = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('CULMINADOS', 3, const Color.fromRGBO(9, 0, 136, 1)),
      ChartData('EN JECUCION', 11, const Color.fromARGB(255, 41, 160, 134)),
      ChartData('POR REINICIAR', 8, Color.fromARGB(255, 243, 232, 77)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Dashboard Monitor"),
        ),
        shape: const CustomAppBarShape(multi: 0.05),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(
                Icons.bar_chart_sharp,
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
                      color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.1),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                                Container(
                                  child: Card(
                                    color: Color.fromARGB(255, 245, 245, 247),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 2,
                                    child: SfCircularChart(
                                      title: ChartTitle(
                                        text: 'ESTADOS DE TAMBOS',
                                        textStyle: const TextStyle(
                                            color:
                                                Color.fromRGBO(0, 116, 227, 1),
                                            fontSize: 16,
                                            fontFamily: 'Roboto-Bold'),
                                        alignment: ChartAlignment.center,
                                      ),
                                      // Enables the legend
                                      legend: Legend(
                                        isVisible: true,
                                        position: LegendPosition.bottom,
                                        orientation:
                                            LegendItemOrientation.vertical,
                                        overflowMode:
                                            LegendItemOverflowMode.wrap,
                                        textStyle: const TextStyle(
                                            color:
                                                Color.fromRGBO(0, 116, 227, 1),
                                            fontSize: 16,
                                            fontFamily: 'Roboto-Bold'),
                                      ),
                                      series: [
                                        PieSeries<ChartData, String>(
                                          dataSource: chartData,
                                          pointColorMapper:
                                              (ChartData data, _) => data.color,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true,
                                                  labelAlignment:
                                                      ChartDataLabelAlignment
                                                          .top,
                                                  margin: EdgeInsets.all(1)),
                                          name: 'Data',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                    color: Color.fromRGBO(61, 61, 61, 1)),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "TAMBOS EN EJECUCIÓN Y POR REINICIAR",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 116, 227, 1),
                                        fontSize: 16,
                                        fontFamily: 'Roboto-Bold'),
                                  ),
                                ),
                                const Divider(
                                    color: Color.fromRGBO(61, 61, 61, 1)),
                                ListView.builder(
                                  itemCount: aProyecto.length,
                                  physics: ClampingScrollPhysics(),
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
                          }),
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
