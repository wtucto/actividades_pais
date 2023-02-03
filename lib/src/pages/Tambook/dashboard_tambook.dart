import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';

class DashboardTambook extends StatefulWidget {
  const DashboardTambook({super.key});

  @override
  State<DashboardTambook> createState() => _DashboardTambookState();
}

class _DashboardTambookState extends State<DashboardTambook> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_10o15,
        shadowColor: color_10o15,
        title: const Center(
          child: Text(
            'TAMBOOK',
            style: TextStyle(
              color: color_01,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              color: color_01,
              Icons.search,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchTambookDelegate(),
              );
            },
          )
        ],
      ),
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
          const SizedBox(height: 20),
          cardHeader(),
          const SizedBox(height: 20),
          cardTambos(),
          cardPersonal(),
          cardEquipamiento(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget cardHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const Divider(color: color_02o27),
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
        ],
      ),
    );
  }

/*
 * -----------------------------------------------
 *            TAMBOS
 * -----------------------------------------------
 */
  Padding cardTambos() {
    var heading = '486 TAMBOS';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: colorI,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
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
                            '''|________|________|''',
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
            width: 2,
            color: colorI,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
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
                                    fontSize: 18.0,
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
                                    fontSize: 18.0,
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
            width: 2,
            color: colorI,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 1.0,
                      ),
                      child: Text(
                        '''   ''',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16),
                      ),
                    ),
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
