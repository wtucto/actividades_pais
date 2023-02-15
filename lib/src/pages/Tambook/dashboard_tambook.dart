import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/fab.dart';
import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/home_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/mapa_tambook.dart';
import 'package:actividades_pais/src/pages/seguimientoMonitoreo/dashboard.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/pages/widgets/widget-custom.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardTambook extends StatefulWidget {
  const DashboardTambook({super.key});

  @override
  State<DashboardTambook> createState() => _DashboardTambookState();
}

class _DashboardTambookState extends State<DashboardTambook>
    with TickerProviderStateMixin<DashboardTambook> {
  Animation<double>? _animation;
  AnimationController? _controller;

  int pageIndex = 0;

  List<ChartData> chartData = [
    ChartData('OPERATIVO', 0, colorI),
    ChartData('NO OPERATIVO', 0, colorS),
    ChartData('MEDIO', 0, color_13),
    ChartData('BAJO', 0, colorP),
  ];

  Future<void> buildData() async {
    setState(() {
      chartData = [
        ChartData('OPERATIVO', 486, colorI),
        ChartData('NO OPERATIVO', 5, colorS),
      ];
    });
  }

  final pages = [
    const HomeTambook(),
    const MapTambook(),
    pageFeed(),
  ];

  onTapped(int index) {
    setState(() {
      pageIndex = index;
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
      appBar: WidgetCustoms.appBar(
        'BUSCAR TAMBO',
        context: context,
        icon: Icons.arrow_back,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePagePais(),
            ),
          );
        },
        iconAct: Icons.search,
        onPressedAct: () {
          showSearch(
            context: context,
            delegate: SearchTambookDelegate(),
          );
        },
      ),
      backgroundColor: colorGB,
      body: pages[pageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: color_10o15,
        foregroundColor: Colors.black,
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchTambookDelegate(),
          );
        },
        child: const Icon(Icons.search),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: pageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Intervenciones',
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
          const SizedBox(
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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

  Padding avanceMetas() {
    var heading = '';
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
                                        "OPERATIVO: 5",
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
                                        "INOPERATIVO: 5",
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

class pageHome extends StatelessWidget {
  const pageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 1",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class pageMap extends StatelessWidget {
  const pageMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 2",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class pageFeed extends StatelessWidget {
  pageFeed({Key? key}) : super(key: key);
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<TamboServicioIntervencionesGeneral> listaPersonalAux = [];

    TamboServicioIntervencionesGeneral aServ =
        TamboServicioIntervencionesGeneral();
    aServ.tambo = 'NUEVO PARAISO';
    aServ.departamento = 'departamento';
    aServ.descripcion =
        'Sesión de trabajo para estatuir la cantidad de raciones diarias en función al padrón de beneficiarios que presenta el comedor popular, realizado por miembros del comité del comedor popular "Tres Hermanos", dirigido a pobladores de la C.N. Nuevo Paraiso.';

    aServ.fecha = '2012/01/01';
    aServ.fechaImagen = '2012/01/01';
    aServ.idPrograma = 1;
    aServ.idProgramacion = 788303;
    aServ.imagen =
        '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"';
    aServ.programa = 'programa';
    aServ.sector = 'Sector';
    aServ.pathImagen =
        'https://www.pais.gob.pe/backendsismonitor/public/storage/programaciones-git/temp/vlnUB1x8kKQhk7Nlq6HaBCsqhgAijPPF5klySJc0.jpeg';

    listaPersonalAux.add(aServ);
    listaPersonalAux.add(aServ);

    return Container(
      color: colorGB,
      child: Center(
        child: ListView.builder(
          controller: controller,
          itemCount: listaPersonalAux.length,
          itemBuilder: (context, i) => cardHistrialTambosInter(
            listaPersonalAux[i],
            () async {
              /*
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FichaIntervencion(listaPersonalAux[i].idProgramacion!),
              ),
            );
            */
            },
          ),
        ),
      ),
    );
  }

  Card cardHistrialTambosInter(
    TamboServicioIntervencionesGeneral band,
    callback,
  ) {
    return Card(
      color: AppConfig.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(20),
      elevation: 7,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          const Divider(
            color: Colors.white,
            height: 5,
            thickness: 3,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
            title: Row(
              children: [
                SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/icons/icons8-male-user-100.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${band.tambo} \n${band.idProgramacion}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.justify,
                  '${band.descripcion}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Image.network('${band.pathImagen}'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: callback,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.download,
                          color: Colors.black,
                        ),
                      )
                    ],
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
