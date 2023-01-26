import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/dto/response_base64_file_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_search_tambo_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_tambo_centro_poblado_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_tambo_servicio_internet_dto.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/fab.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/pdf_preview_page2.dart';
import 'package:actividades_pais/src/pages/Tambook/dashboard_tambook.dart';
import 'package:actividades_pais/src/pages/Tambook/search/search_tambook.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DetalleTambook extends StatefulWidget {
  const DetalleTambook({super.key, this.listTambo});
  final BuscarTamboDto? listTambo;

  @override
  _DetalleTambookState createState() => _DetalleTambookState();
}

class _DetalleTambookState extends State<DetalleTambook>
    with TickerProviderStateMixin<DetalleTambook> {
  ScrollController scrollCtr = ScrollController();
  ScrollController scrollCtr2 = ScrollController();
  Animation<double>? _animation;
  AnimationController? _controller;
  MainController mainCtr = MainController();

  late TamboModel oTambo = TamboModel.empty();

  @override
  void dispose() {
    scrollCtr.dispose();
    scrollCtr2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollCtr = ScrollController();
    scrollCtr.addListener(() => setState(() {}));
    scrollCtr2.addListener(() => setState(() {}));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();

    /**
     * OBTENER DETALLE GENERAL DE TMBO
     */
    tamboDatoGeneral();
  }

  Uint8List convertBase64(String base64String) {
    return const Base64Decoder().convert(base64String.split(',').last);
  }

  Future<void> tamboDatoGeneral() async {
    oTambo = await mainCtr
        .getTamboDatoGeneral((widget.listTambo!.idTambo).toString());

    setState(() {});
  }

  Future<Uint8List> downloadPDF() async {
    RespBase64FileDto oB64 = await mainCtr
        .getBuildBase64PdfFichaTecnica((widget.listTambo!.idTambo).toString());
    return convertBase64(oB64.base64 ?? '');
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
                builder: (BuildContext context) => const DashboardTambook(),
              ));
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "${widget.listTambo?.nombreTambo} !",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Container(
          height: 200.0,
          child: Ink.image(
            image: NetworkImage(oTambo.tamboPathImage ?? ''),
            fit: BoxFit.fitHeight,
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
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 4,
              child: NestedScrollView(
                controller: scrollCtr,
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
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    //TabScreen("GESTOR"),
                    Container(
                      child: ListView(
                        children: [
                          /*
                            * NUESTRO GESTOR
                            */
                          cardNuestroGestor(),
                          const SizedBox(height: 10),

                          /*
                            * DATOS GENERALES
                            */
                          cardDatosGenerales(),
                          const SizedBox(height: 10),
                          /*
                            * NUESTRO JEFE DE UNIDAD TERRITORIAL
                            */
                          cardNuestroJefeUnidad(),
                          const SizedBox(height: 10),

                          /*
                            * DATOS DE UBICACIÓN
                            */
                          cardDatosUbicacion(),
                          const SizedBox(height: 10),

                          /*
                            * DATOS DEMOGRÁFICOS
                            */
                          cardDatosDemograficos(),
                          const SizedBox(height: 10),

                          /*
                            * DATOS DE LA OBRA
                            */
                          cardDatosObra(),
                          const SizedBox(height: 10),

                          /*
                            * CENTROS POBLADOS
                            */
                          cardDatosCentroPoblado(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),

                    //const TabScreen("SERVICIOS INTERNET"),
                    Container(
                      child: ListView(
                        children: [
                          cardDatosSrvInternet(),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),

                    //TabScreen("INTERVENCIONES"),
                    Container(
                      child: ListView(
                        children: [
                          Intecard(),
                          const SizedBox(height: 10),
                          Intecard1(),
                        ],
                      ),
                    ),
                    const TabScreen("EQUIPAMIENTO TECNOLÓGICO DEL TAMBO"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Ficha técnica",
            Icons.picture_as_pdf_sharp,
            onPress: () async {
              try {
                BusyIndicator.show(context);
                bool isConnec = await CheckConnection.isOnlineWifiMobile();
                if (isConnec) {
                  Uint8List dataPdf = await downloadPDF();
                  BusyIndicator.hide(context);
                  _controller!.reverse();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PdfPreviewPage2(dataPdf: dataPdf),
                    ),
                  );
                  return;
                } else {}
              } catch (oError) {}
              BusyIndicator.hide(context);
            },
          ),
        ],
        animation: _animation!,
        onPress: () {
          if (_controller!.isCompleted) {
            _controller!.reverse();
          } else {
            _controller!.forward();
          }
        },
      ),
    );
  }

  Card cardNuestroGestor() {
    var heading = 'NUESTRO GESTOR';
    var subheading = oTambo.gestorNombre ?? '';
    var cardImage = NetworkImage(oTambo.gestorPathImage ?? '');
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
                subheading!,
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
                  children: [
                    ListTile(
                      title: const Text('CARRERA'),
                      subtitle: Text(oTambo.gestorProfession ?? ''),
                    ),
                    ListTile(
                      title: const Text('GRADO'),
                      subtitle: Text(oTambo.gestorGradoAcademico ?? ''),
                    ),
                    ListTile(
                      title: const Text('SEXO'),
                      subtitle: Text(oTambo.gestorSexo ?? ''),
                    ),
                    ListTile(
                      title: const Text('ESTADO CIVIL'),
                      subtitle: Text(oTambo.gestorEstadoCivil ?? ''),
                    ),
                    ListTile(
                      title: const Text('FECHA DE NACIMIENTO'),
                      subtitle: Text(oTambo.gestorFechaNacimiento ?? ''),
                    ),
                    ListTile(
                      title: const Text('EMAIL'),
                      subtitle: Text(oTambo.gestorCorreo ?? ''),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Card cardDatosGenerales() {
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
                  children: [
                    ListTile(
                      title: const Text('ATENCIONES'),
                      subtitle: Text(oTambo.atencion ?? ''),
                    ),
                    ListTile(
                      title: const Text('INTERVENCIONES'),
                      subtitle: Text(oTambo.intervencion ?? ''),
                    ),
                    ListTile(
                      title: const Text('BENEFICIARIOS'),
                      subtitle: Text(oTambo.beneficiario ?? ''),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Card cardDatosUbicacion() {
    var heading = 'DATOS DE UBICACIÓN';
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
                children: [
                  ListTile(
                    title: const Text('DEPARTAMENTO'),
                    subtitle: Text(oTambo.nombreDepartamento ?? ''),
                  ),
                  ListTile(
                    title: const Text('PROVINCIA'),
                    subtitle: Text(oTambo.nombreProvincia ?? ''),
                  ),
                  ListTile(
                    title: const Text('DISTRITO'),
                    subtitle: Text(oTambo.nombreDistrito ?? ''),
                  ),
                  ListTile(
                    title: const Text('CENTRO POBLADO'),
                    subtitle: Text(oTambo.nombreCcpp ?? ''),
                  ),
                  ListTile(
                    title: const Text('COORDENADAS'),
                    subtitle:
                        Text('${oTambo.xCcpp ?? ''} , ${oTambo.yCcpp ?? ''}'),
                  ),
                  ListTile(
                    title: const Text('ALTITUD'),
                    subtitle: Text(oTambo.altitudCcpp ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card cardDatosDemograficos() {
    var heading = 'DATOS DEMOGRÁFICOS';
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
                children: [
                  ListTile(
                    title: const Text('N° DE HOGARES'),
                    subtitle: Text(oTambo.hogaresAnteriores ?? ''),
                  ),
                  ListTile(
                    title: const Text('N° DE VIVIENDAS'),
                    subtitle: Text(oTambo.viviendasAnterior ?? ''),
                  ),
                  ListTile(
                    title: const Text('POBLACIÓN'),
                    subtitle: Text(oTambo.poblacionAnterior ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card cardDatosObra() {
    var heading = 'DATOS DE LA OBRA';
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
                children: [
                  ListTile(
                    title: const Text('N° SNIP'),
                    subtitle: Text(
                        oTambo.nSnip == null ? '' : oTambo.nSnip.toString()),
                  ),
                  ListTile(
                    title: const Text('MONTO CONTRATADO'),
                    subtitle: Text(oTambo.montoAdjudicado ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card cardNuestroJefeUnidad() {
    var heading = 'NUESTRO JEFE DE UNIDAD TERRITORIAL';
    var subheading =
        "${oTambo.jefeNombre ?? ''} ${oTambo.jefeApellidoPaterno ?? ''} ${oTambo.jefeApellidoMaterno ?? ''}";
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
                children: [
                  ListTile(
                    title: const Text('TÉLEFONO'),
                    subtitle: Text(oTambo.jefeTelefono ?? ''),
                  ),
                  ListTile(
                    title: const Text('EMAIL'),
                    subtitle: Text(oTambo.jefeCorreo ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card cardDatosCentroPoblado() {
    var heading = 'CENTROS POBLADOS';
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '$heading ( ${oTambo.aCentroPoblado!.length} )',
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
                children: [
                  for (var oCentro in oTambo.aCentroPoblado!)
                    ListTile(
                      title: Text(
                        '- ${oCentro.nombreCcpp} ( ALTITUD: ${oCentro.altitudCcpp} - REGION: ${oCentro.regionCatural} )',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card cardDatosSrvInternet() {
    var heading = 'SERVICIOS INTERNET';
    TamboServicioInternetDto oSrvInter = oTambo.oServicioInternet!;
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
                children: [
                  /*ListTile(
                    title: const Text('CENTRO POBLADO'),
                    subtitle: Text(oSrvInter.nombreCcpp!),
                  ),*/
                  ListTile(
                    title: const Text('INTERNET'),
                    subtitle: Text(oSrvInter.internet!),
                  ),
                  ListTile(
                    title: const Text('FECHA INSTALACIÓN'),
                    subtitle: Text(oSrvInter.fecInstalacion!),
                  ),
                  ListTile(
                    title: const Text('ESTADO INTERNET'),
                    subtitle: Text(oSrvInter.estadoInternet!),
                  ),
                  ListTile(
                    title: const Text('VELOCIDAD BAJADA'),
                    subtitle: Text(oSrvInter.veloBaja!),
                  ),
                  ListTile(
                    title: const Text('VELOCIDAD SUBIDA'),
                    subtitle: Text(oSrvInter.veloSube!),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
            child: const Text('Descargar Ficha'),
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
            child: const Text('Descargar Ficha'),
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
