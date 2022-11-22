import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // final List<ChartData> chartData = [
  //   ChartData('David', 25),
  //   ChartData('Steve', 38),
  //   ChartData('Jack', 34),
  //   ChartData('Others', 52)
  // ];
  get pieData => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Monitor"),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.1),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 2),
                      child: const Text(
                        "ESTADO DE TAMBOS",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 116, 227, 1),
                            fontSize: 16,
                            fontFamily: 'Roboto-Bold'),
                      ),
                    ),
                    const Divider(
                      color: Color.fromRGBO(61, 61, 61, 1),
                      // thickness: 1,
                    ),
                    Container(
                      child: SfCircularChart(
                        // Enables the legend
                        legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                            orientation: LegendItemOrientation.vertical,
                            overflowMode: LegendItemOverflowMode.wrap),
                        series: [
                          DoughnutSeries<ChartData, String>(
                              dataSource: [
                                // Bind data source
                                ChartData('Tambo Culminados', 3),
                                ChartData('Tambo en Ejecucion', 11),
                                ChartData('Tambo por Reiniciar', 8),
                              ],
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  labelAlignment: ChartDataLabelAlignment.top,
                                  margin: EdgeInsets.all(1)),
                              name: 'Data')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
  //  Color color;
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
