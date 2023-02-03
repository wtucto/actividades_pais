import 'package:actividades_pais/src/pages/Tambook/atenciones_list_view.dart';
import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
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
        title: const Center(
          child: Text(
            'TAMBOOK',
            style: TextStyle(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(10),
                child: AtencionesListView(),
              ),
            ],
          ),

          getPopularCourseUI(),
          // Intervenciones
        ],
      ),
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Últimas Intervenciones',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: Colors.black,
            ),
          ),
          const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
          Card(
            margin: const EdgeInsets.all(5),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'SUB PREFECTURA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.27,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'VI Feria Agromercado 2022, con la finalidad de comercializar los productos agropecuarios y derivados propios de la zona a precios razonables y cumpliendo los protocolos de bioseguridad directamente a los consumidores finales, evento realizado por la Agencia Agraria Melgar, dirigido a las asociaciones de productores y población del distrito de Ayaviri.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                Image.asset('assets/design_course/tercero.jpeg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
