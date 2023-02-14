// ignore_for_file: unnecessary_new

import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/fab.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/Reportes/ReporteEquipoInfomatico.dart';
import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
//import 'package:actividades_pais/src/pages/widgets/WebViewTest.dart';

class HomeTambook extends StatefulWidget {
  const HomeTambook({super.key});

  @override
  State<HomeTambook> createState() => _HomeTambookState();
}

class _HomeTambookState extends State<HomeTambook>
    with TickerProviderStateMixin<HomeTambook> {
  Animation<double>? _animation;
  AnimationController? _controller;

  List<ChartData> chartData = [
    ChartData('PRESTA SERVICIO', 0, colorI),
    ChartData('NO PRESTA SERVICIO', 0, colorS),
  ];

  Future<void> buildData() async {
    setState(() {
      chartData = [
        ChartData('PRESTA SERVICIO', 486, colorS),
        ChartData('NO PRESTA SERVICIO', 5, colorP),
      ];
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    buildData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_10o15,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: getBody(),
          ),
        ],
      ),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cardHeader(),
          const SizedBox(height: 20),
          cardAtenciones(),
          cardIntervenciones(),
          cardBeneficiarios(),
          cardEstadoTambo(),
          cardTambos(),
          cardPersonal(),
          cardEquipamiento(),
          cardEquipoTecnologico(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget cardHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        right: 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 250.0,
            child: Image.asset(
              'assets/bgTamboDefault.jpeg',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          //const Divider(color: color_02o27),
          const Text(
            'PLATAFORMAS FIJAS Y MOVIL',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: color_01,
            ),
          ),
          /*
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  'NUESTRAS PLATAFORMAS CUENTAN CON PERSONAL CAPACITADO Y EQUIPAMIENTO MODERNO, QUE BRINDAN SERVICIOS EN MÁS DE 14 400 CENTROS POBLADOS, EN 22 REGIONES, BENEFICIANDO A MÁS DE 1 MILLÓN DE HABITANTES.',
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          */
        ],
      ),
    );
  }

/*
*------------------------------------------------
*             CHARTS
*-------------------------------------------------
*/

  Padding cardAtenciones() {
    var heading = 'ATENCIONES 2023';

    late ValueNotifier<double> valueNotifier = ValueNotifier(40);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SimpleCircularProgressBar(
                      size: 150,
                      maxValue: 100,
                      valueNotifier: valueNotifier,
                      backColor: Colors.black.withOpacity(0.4),
                      progressStrokeWidth: 20,
                      backStrokeWidth: 20,
                      mergeMode: true,
                      onGetText: (double value) {
                        return Text(
                          '${value.toInt()}%',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          children: const [
                            TableRow(children: [
                              Text(
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "12,000",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Avance :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "1,560",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Brecha :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "10,440",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardIntervenciones() {
    var heading = 'INTERVENCIONES 2023';

    late ValueNotifier<double> valueNotifier = ValueNotifier(20);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SimpleCircularProgressBar(
                      size: 150,
                      maxValue: 100,
                      valueNotifier: valueNotifier,
                      backColor: Colors.black.withOpacity(0.4),
                      progressStrokeWidth: 20,
                      backStrokeWidth: 20,
                      mergeMode: true,
                      progressColors: const [
                        Colors.yellow,
                        Colors.yellowAccent
                      ],
                      onGetText: (double value) {
                        return Text(
                          '${value.toInt()}%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          children: const [
                            TableRow(children: [
                              Text(
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "12,000",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Avance :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "1,560",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Brecha :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "10,440",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardBeneficiarios() {
    var heading = 'BENEFICIARIOS 2023';
    late ValueNotifier<double> valueNotifier3 = ValueNotifier(50);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SimpleCircularProgressBar(
                      size: 150,
                      maxValue: 100,
                      valueNotifier: valueNotifier3,
                      backColor: Colors.black.withOpacity(0.4),
                      progressColors: const [Colors.green, Colors.greenAccent],
                      progressStrokeWidth: 20,
                      backStrokeWidth: 20,
                      mergeMode: true,
                      onGetText: (double value) {
                        return Text(
                          '${value.toInt()}%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Table(
                          children: const [
                            TableRow(children: [
                              Text(
                                "Meta :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "10,000",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Avance :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "3,001",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                "Brecha :",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                "6,999",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding cardEstadoTambo() {
    var heading = 'ESTADO DE LOS TAMBOS';
    late ValueNotifier<double> valueNotifier3 = ValueNotifier(50);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    color: colorGB,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: SfCircularChart(
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
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelAlignment: ChartDataLabelAlignment.top,
                            margin: EdgeInsets.all(1),
                          ),
                          name: 'Data',
                          //explode: true,
                          //explodeIndex: 1,
                          radius: '80%',
                          onPointTap: (ChartPointDetails details) async {},
                        ),
                      ],
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

/*
 * -----------------------------------------------
 *            TAMBOS
 * -----------------------------------------------
 */
  Padding cardTambos() {
    var heading = '485 TAMBOS';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
            color: Colors.white),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'CONSTRUIDOS',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const <Widget>[
                                  Icon(
                                    color: color_01,
                                    Icons.home_outlined,
                                  ),
                                  Text(
                                    '450',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'EN CONSTRUCCIÓN',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const <Widget>[
                                  Icon(
                                    color: color_01,
                                    Icons.home_outlined,
                                  ),
                                  Text(
                                    '10',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              '3',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            const Text(
                              'DAP EN SERVICIO',
                              style: TextStyle(fontSize: 10.0),
                            ),
                            const Text(""),
                            Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                color: color_01,
                                Icons.directions_boat_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      '1',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text(
                                      'EN EJECUCION',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      '5',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text(
                                      'PIAS OPERANDO',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      '8',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text(
                                      'POR EJECUTAR',
                                      style: TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '''|_________|_________|''',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(155, 155, 155, 1.0),
                            ),
                          ),
                          const Text(
                            '|',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(155, 155, 155, 1.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              Text(
                                "14 PIAS",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  * -----------------------------------------------
  *            PERSONAL
  * -----------------------------------------------
  */
  Padding cardPersonal() {
    var heading = 'PERSONAL';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: colorI,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "REGION",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'JEFE UNIDAD TERRITORIAL',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  ' | ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(155, 155, 155, 1.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'MONITOR',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: colorI),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  "TAMBOS PIAS Y UPS",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'GESTOR',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  ' | ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(155, 155, 155, 1.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    children: const <Widget>[
                                      Text(
                                        'GUARDIÁN',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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

  /*
  * -----------------------------------------------
  *            EQUIPAMIENTO
  * -----------------------------------------------
  */
  Padding cardEquipamiento() {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    var heading = 'EQUIPAMIENTO';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.tv,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'SALA DE TV',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.desk,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'OFICINA',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.kitchen_outlined,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'COMEDOR',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.local_hospital_outlined,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'TOPICO',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.wifi,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'INTERNET',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.bed,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'COMEDOR',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*
  * -----------------------------------------------
  *            PARQUE INFORMATICO
  * -----------------------------------------------
  */
  Padding cardEquipoTecnologico() {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    var heading = 'PARQUE INFORMATICO';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorI,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: color_01,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: colorI),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.desktop_mac_outlined,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'PC (10)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.laptop,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'LAPTOP (10)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.photo_camera_front,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'PROYECTOR (30)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.wifi,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'ANTENA WIFI (30)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildSuccessDialog(
                                  context,
                                  title: 'EQUIPAMIENTO TECNOLÓGICO',
                                  subTitle: 'IMPRESORAS',
                                  child: Column(
                                    children: const [
                                      Text(
                                        "PRESTA SERVICIO: 5",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: color_01,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "INPRESTA SERVICIO: 5",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: color_01,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 2,
                                      color: color_01,
                                    ),
                                  ),
                                  child: const Icon(
                                    color: color_01,
                                    Icons.print_outlined,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                const Text(
                                  'IMPRESORAS (10)',
                                  style: TextStyle(
                                    color: color_01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSuccessDialog(
    BuildContext context, {
    String? title,
    String? subTitle,
    Widget? child,
  }) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5.00,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              title ?? '',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: color_01,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            subTitle ?? '',
                            maxLines: null,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: color_01,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            child: child,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      actions: const <Widget>[
        /*
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  colorS,
                ),
              ),
              child: const Text("Aceptar"),
            ),
          ],
        ),

        */
      ],
    );
  }

  SizedBox Box01(String text1, String text2, String icon) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: 180,
      child: Card(
        color: const Color(0xfffaf5f5),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.16,
              color: colorGB,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text1,
                    style: const TextStyle(
                      fontFamily: 'Karla',
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff54c19f),
                    ),
                  ),
                  Text(
                    text2,
                    style: const TextStyle(
                      fontFamily: 'Karla',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff75777d),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 7),
              child: Image.asset(
                //'assets/icons/tambos.png',
                'assets/icons/$icon',
                width: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container Box2() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.purple),
                ),
                child: const Center(
                  child: Text(
                    "PJ",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              '100',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text('Followers'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              '100',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text('Following'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Peter Jonathan",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Row(
                    children: const <Widget>[
                      Text(
                        "@pj",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          color: Color.fromRGBO(155, 155, 155, 1.0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
