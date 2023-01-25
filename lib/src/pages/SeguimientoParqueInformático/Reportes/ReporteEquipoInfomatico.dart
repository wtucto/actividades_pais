import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ReporteEquipoInformatico extends StatefulWidget {
  const ReporteEquipoInformatico({Key? key}) : super(key: key);

  @override
  State<ReporteEquipoInformatico> createState() => _ReporteEquipoInformaticoState();
}
List<ChartData> chartData = [
  //1 - Verde       80D8A4
  //2 - Amarillo    FEE191
  //3 - Rojo        E84258
   ChartData('ACTIVO', 0, const Color(0xFF80D8A4)),
   ChartData('INACTIVO', 0, const Color(0xFFE84258)),
];

List<TramaProyectoModel> aProyecto = [];

var activo = 0;
var inactivo = 0;

class _ReporteEquipoInformaticoState extends State<ReporteEquipoInformatico> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildData();
  }

  Future<void> buildData() async {


      activo =  await ProviderSeguimientoParqueInformatico().ReporteEquipos(1);
      inactivo =  await ProviderSeguimientoParqueInformatico().ReporteEquipos(0);


    setState(() {
     /// aProyecto = aProyectoAll;
      chartData = [
        //1 - Verde       80D8A4
        //2 - Amarillo    FEE191
        //3 - Rojo        E84258
        ChartData('ACTIVO', activo, const Color(0xFF80D8A4)),
        ChartData('INACTIVO', inactivo, const Color(0xFFE84258)),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("REPORTE EQUIPO INFORMATICO"),), body: Column(
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
                        text: 'ESTADOS DE EQUIPOS',
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
                        print(args.pointIndex);
                        buildData();
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
                          onPointTap:
                              (ChartPointDetails details) async {
                            BusyIndicator.show(context);
                            await Future<dynamic>.delayed(
                                const Duration(milliseconds: 1000));
                            int iIndex = details.pointIndex! + 1;

                          /*  switch (iIndex) {
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
                            }*/
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
                  /*Container(
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
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
                  ),*/
            /*      aProyecto.isNotEmpty
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
                        color:
                        Color.fromARGB(255, 0, 102, 255),
                      ),
                    ),
                  ),*/
                ],
              );
            },
          ),
        ),
      ],
    ),);
  }

}
class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}
