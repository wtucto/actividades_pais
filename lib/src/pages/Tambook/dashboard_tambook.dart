import 'package:actividades_pais/src/pages/Tambook/atenciones_list_view.dart';
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
      backgroundColor: const Color(0xFFa0d9f5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFa0d9f5),
        shadowColor: const Color(0xFFa0d9f5),
        title: const Center(
          child: Text(
            'TAMBOOK',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
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
        ],
      ),
    );
  }

  Widget cardHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 16),
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
              color: Colors.black,
            ),
          ),
          const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
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
              width: 2, color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: Color.fromARGB(255, 255, 255, 255)),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ListTile(
                    title: Text(''),
                    subtitle: Text(""),
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
              width: 2, color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: Color.fromARGB(255, 255, 255, 255)),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ListTile(
                    title: Text(''),
                    subtitle: Text(""),
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
  Padding cardEquipamiento() {
    var heading = 'EQUIPAMIENTO';
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: const Color.fromARGB(255, 255, 255, 255)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: ListTile(
            title: Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          children: <Widget>[
            const Divider(color: Color.fromARGB(255, 255, 255, 255)),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ListTile(
                    title: Text(''),
                    subtitle: Text(""),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
