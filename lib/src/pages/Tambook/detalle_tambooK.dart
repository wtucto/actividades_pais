import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/src/pages/Tambook/dashboard_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DetalleTambook extends StatefulWidget {
  const DetalleTambook({super.key, this.listTambo});
  final TamboModel? listTambo;

  @override
  _DetalleTambookState createState() => _DetalleTambookState();
}

class _DetalleTambookState extends State<DetalleTambook> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var flexibleSpaceWidget = SliverAppBar(
      title: const Text(
        "¡ BIENVENIDO A",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      automaticallyImplyLeading: true,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      snap: false,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => DashboardTambook(),
              ));
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "${widget.listTambo?.tambo} !",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Image.asset(
          "assets/design_course/fondo2.jpg",
          fit: BoxFit.fill,
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
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 4,
              child: NestedScrollView(
                controller: scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    flexibleSpaceWidget,
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 40,
                        maxHeight: 40,
                        child: Container(
                          height: 800 * (1 / 11),
                          width: double.infinity,
                          color: const Color.fromARGB(255, 230, 234, 236),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Center(
                                  child: Text(
                                    'OPERATIVO',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 80,
                        maxHeight: 80,
                        child: Container(
                          color: const Color.fromARGB(255, 230, 234, 236),
                          child: const TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black38,
                            indicatorColor: Colors.black,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              color: Colors.white70,
                            ),
                            tabs: [
                              Tab(
                                icon: Icon(Icons.account_box),
                                text: "GESTOR",
                              ),
                              Tab(
                                icon: Icon(Icons.cloud),
                                text: "SERVICIOS INTERNET",
                              ),
                              Tab(
                                icon: Icon(Icons.policy_rounded),
                                text: "INTERVENCIONES",
                              ),
                              Tab(
                                icon: Icon(Icons.computer),
                                text: "EQUIPAMIENTO TECNOLÓGICO",
                              ),
                            ],
                          ),
                        ),
                      ),
                      // pinned: true,
                    ),
                  ];
                },
                body: const TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    TabScreen("GESTOR"),
                    TabScreen("SERVICIOS INTERNET"),
                    TabScreen("INTERVENCIONES"),
                    TabScreen("EQUIPAMIENTO TECNOLÓGICO DEL TAMBO"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container newMethod() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
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
                            AspectRatio(
                              aspectRatio: 1.2,
                              child: Image.asset(
                                'assets/design_course/fondo2.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                            //DETALLE
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(1.0),
                                    topRight: Radius.circular(1.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xFF3A5160)
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "¡BIENVENIDO A SOLEDAD!",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.green
                                                    .withOpacity(0.5),
                                                offset: const Offset(1.1, 1.1),
                                                blurRadius: 10.0),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'OPERATIVO',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                      DefaultTabController(
                                        length: 3, // length of tabs
                                        initialIndex: 0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              child: const TabBar(
                                                labelColor: Colors.blue,
                                                isScrollable: true,
                                                unselectedLabelColor:
                                                    Colors.black,
                                                tabs: [
                                                  Tab(text: 'GESTOR'),
                                                  Tab(text: 'INTERVENCIONES'),
                                                  Tab(text: 'UBICACIÓN'),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  400, //height of TabBarView
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.5))),
                                              child: TabBarView(
                                                children: [
                                                  Container(
                                                    child: ListView(
                                                      children: [
                                                        buildCard(),
                                                        const SizedBox(
                                                            height: 10),
                                                        generales(),
                                                        const SizedBox(
                                                            height: 10),
                                                        card3(),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ListView(
                                                      children: [
                                                        Intecard(),
                                                        const SizedBox(
                                                            height: 10),
                                                        Intecard1(),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ListView(
                                                      children: [
                                                        Image.asset(
                                                          'assets/Tambook/mapa_tambo.jpg',
                                                          height: 400,
                                                          width: 400,
                                                        ),
                                                      ],
                                                    ),
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
          ),
        ],
      ),
    );
  }

  Card buildCard() {
    var heading = 'NUESTRO GESTOR';
    var subheading = 'JULIO CESAR TAMINCHE LLAMO';
    var cardImage = const NetworkImage(
        'https://www.pais.gob.pe/sismonitor/FILES/usuarios/6234/perfil/thumbnail/6234_200x200.jpg');

    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                heading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                subheading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
            Container(
              height: 200.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              // padding: EdgeInsets.all(5.0),
              alignment: Alignment.centerLeft,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ListTile(
                      title: Text('CARRERA'),
                      subtitle: Text('Ingeniería AgroindustrialL'),
                    ),
                    ListTile(
                      title: Text('GRADO'),
                      subtitle: Text('Colegiatura'),
                    ),
                    ListTile(
                      title: Text('SEXO'),
                      subtitle: Text('Masculino'),
                    ),
                    ListTile(
                      title: Text('ESTADO CIVIL'),
                      subtitle: Text('Soltero'),
                    ),
                    ListTile(
                      title: Text('FECHA DE NACIMIENTO'),
                      subtitle: Text('11-04-1988'),
                    ),
                    ListTile(
                      title: Text('EMAIL'),
                      subtitle: Text('jtaminche@pais.gob.pe'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Card generales() {
    var heading = 'DATOS GENERALES';
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                heading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
            Container(
              alignment: Alignment.centerLeft,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ListTile(
                      title: Text('ATENCIONES'),
                      subtitle: Text('10.957'),
                    ),
                    ListTile(
                      title: Text('INTERVENCIONES'),
                      subtitle: Text('741'),
                    ),
                    ListTile(
                      title: Text('BENEFICIARIOS'),
                      subtitle: Text('2,184'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Card card3() {
    var heading = 'JEFE DE UNIDAD TERRITORIAL';
    var subheading = "JOSE GREGORIO ARICA NECIOSUP";
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                heading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                subheading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
            Container(
              alignment: Alignment.centerLeft,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ListTile(
                      title: Text('TÉLEFONO'),
                      subtitle: Text('978997614'),
                    ),
                    ListTile(
                      title: Text('EMAIL'),
                      subtitle: Text('jarica@pais.gob.pe'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

// Intervenciones
  Card Intecard() {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_drop_down_circle),
            title: const Text('QALIWARMA'),
            subtitle: Text(
              '10/11/2022',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'TALLER DE CAPACITACION, CONFORMACION DEL CAE Y ENTREGA DE ALIMENTOS, CON LA FINALIDAD DE DOTAR DE PRODUCTOS RICOS EN PROTEINAS, MINERALES Y VITAMINAS LA CUAL PERMITE COMBATIR LA ANEMIA Y LA DCI, REALIZADO POR EL MONITOR DE GESTION LOCAL DEL PN QALIWARMA',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Image.network(
              'https://www.pais.gob.pe/backendsismonitor/public/storage/programaciones-git/temp/TMOgbPC8JekToSulb2QsRUlQNDtYWbnzwCdauuGx.jpg'),
          ElevatedButton(
            child: Text('Descargar Ficha'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Card Intecard1() {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_drop_down_circle),
            title: const Text(
                'SERVICIO NACIONAL DE AREAS NATURALES PROTEGIDAS (SERNANP)'),
            subtitle: Text(
              '08/11/2022',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'TALLER DE CAPACITACION: EVALUACION DE PECES, ESTANDARIZACION DE ALIMENTOS,COSECHA, COMERCIALIZACION Y ACUERDOS DE COMPROMISO PARA LA CONTINUIDAD DE ACTIVIDADES PARA EL AÑO 2023, EN EL MARCO DE LA EJECUCION DEL PROYECTO “PRODUCCION DE ALEVINOS DE ESPECIES AMAZONICAS',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Image.network(
              'https://www.pais.gob.pe/backendsismonitor/public/storage/programaciones-git/temp/E842oA2wFbzX0wb8ZleAjAJ18z4JQAQ6jDapOsXe.jpg'),
          ElevatedButton(
            child: Text('Descargar Ficha'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class TabScreen extends StatelessWidget {
  const TabScreen(this.listType, {super.key});
  final String listType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              listType,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class SliverContainer extends StatefulWidget {
  final List<Widget> slivers;
  final Widget floatingActionButton;
  final double expandedHeight;
  final double marginRight;
  final double topScalingEdge;

  const SliverContainer(
      {super.key,
      required this.slivers,
      required this.floatingActionButton,
      this.expandedHeight = 256.0,
      this.marginRight = 16.0,
      this.topScalingEdge = 96.0});

  @override
  State<StatefulWidget> createState() {
    return SliverFabState();
  }
}

class SliverFabState extends State<SliverContainer> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: scrollController,
          slivers: widget.slivers,
        ),
        _buildFab(),
      ],
    );
  }

  Widget _buildFab() {
    final topMarginAdjustVal =
        Theme.of(context).platform == TargetPlatform.iOS ? 12.0 : -4.0;
    final double defaultTopMargin = widget.expandedHeight + topMarginAdjustVal;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset > 0 ? offset : 0;
      if (offset < defaultTopMargin - widget.topScalingEdge) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - widget.topScalingEdge / 2) {
        scale = (defaultTopMargin - widget.topScalingEdge / 2 - offset) /
            (widget.topScalingEdge / 2);
      } else {
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: widget.marginRight,
      child: Transform(
        transform: Matrix4.identity()..scale(scale, scale),
        alignment: Alignment.center,
        child: widget.floatingActionButton,
      ),
    );
  }
}
