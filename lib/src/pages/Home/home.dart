import 'dart:async';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/card.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/main_footer_all_option.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/actividadesPnpais.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/cordinacion_articulacion.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/monitoreo_suspervicion.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/programacion_list_page.dart';
import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/util/home_options.dart';
import 'package:actividades_pais/util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Pias/ListaReportesPias.dart';
import 'package:actividades_pais/src/pages/configuracion/Asistencia.dart';
import 'package:actividades_pais/src/pages/configuracion/pantallainicio.dart';
import 'package:get/get.dart';

import 'appbar/AppBar.dart';

class HomePagePais extends StatefulWidget {
  static String route = '/';

  @override
  _HomePagePais createState() => _HomePagePais();
}

class _HomePagePais extends State<HomePagePais> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  int currenIndex = 0;
  var cantidadDB = 0;
  Color changecolor = Colors.grey;
  bool _isVisible = true;
  var _nombrePersona = '';
  var _apellidosPersona = '';
  var unidadTerritorial = '';
  var variable = '';
  var snip = 0;
  var idPlataforma = 0;
  var tipoPlataforma = '';
  var campaniaCod = '';
  var modalidad = '';

  String long = '';
  String lat = '';

  @override
  void initState() {
    super.initState();

    ///ProviderDatos().   verificacionpesmiso();
    mostrarTmbo();
    traerdato();
    verificargps();
  }

  Future verificargps() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
      //print('GPS service is enabled');
    } else {
      //print('GPS service is disabled.');
    }
  }

  traerdato() async {
    await ProviderDatos().verificacionpesmiso();
  }

  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    if (abc.isNotEmpty) {
      var idlp = abc[abc.length - 1].idLugarPrestacion;
      var iduo = abc[abc.length - 1].idUnidadesOrganicas;

      setState(() {
        mostrarNombre();
        if (abc.isNotEmpty) {
          mostrarNombre();
          cantidadDB = 1;
          changecolor = (Colors.blue[400])!;
          _isVisible = false;
          if (idlp == 1) {
            variable = abc[abc.length - 1].lugarPrestacion;
            unidadTerritorial = abc[abc.length - 1].unidTerritoriales;
            snip = abc[abc.length - 1].snip;
          } else if (idlp == 2) {
            variable = abc[abc.length - 1].nombreTambo;
            unidadTerritorial = abc[abc.length - 1].unidTerritoriales;
            snip = abc[abc.length - 1].snip;
            tipoPlataforma = abc[abc.length - 1].tipoPlataforma;
            idPlataforma = abc[abc.length - 1].idTambo;
            campaniaCod = abc[abc.length - 1].codCampania;
            modalidad = abc[abc.length - 1].modalidad;

            //print('campaniaCod $campaniaCod');
          }
        }
      });
    }
  }

  Future mostrarNombre() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    if (abc.isNotEmpty) {
      setState(() {
        _nombrePersona = abc[abc.length - 1].nombres.toUpperCase();
        _apellidosPersona =
            '${abc[abc.length - 1].apellidoPaterno.toUpperCase()} ${abc[abc.length - 1].apellidoMaterno.toUpperCase()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    double wp = responsive.wp(14);
    double hp65 = responsive.hp(35);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (!isPortrait) {
      wp = responsive.wp(20);
      hp65 = responsive.wp(15);
    }

    String icon0 = 'assets/icons/icon_user_setting.png';
    String icon1 = 'assets/icons/icon_account_balance.png';
    String icon2 = 'assets/icons/icon_boat.png';
    String icon3 = 'assets/icons/icon_fligth.png';
    String icon4 = 'assets/icons/icon_intervencion.png';
    String icon5 = 'assets/icons/icon_monitoring.png';
    String icon6 = 'assets/icons/icon_registration.png';
    String icon7 = 'assets/icons/icon_activity.png';

    List<HomeOptions> aHomeOptions = [];

    if (cantidadDB < 1) {
      aHomeOptions.add(
        HomeOptions(
          code: 'OPT1000',
          name: 'TileAppRegister'.tr,
          types: const ['Usuario'],
          image: icon0,
          color: lightTeal,
        ),
      );
    } else {
      if (tipoPlataforma == 'TAMBO') {
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1003',
            name: 'TileIntervencion'.tr,
            types: const ['Ver'],
            image: icon4,
            color: lightBlue,
          ),
        );
      } else {
        if (tipoPlataforma == 'PIAS' &&
            (modalidad == '1' || modalidad == '2' || modalidad == '3')) {
          String sImagePias = modalidad == '1'
              ? icon2
              : modalidad == '2'
                  ? icon3
                  : icon1;
          aHomeOptions.add(
            HomeOptions(
              code: 'OPT1004',
              name: 'TilePias'.tr,
              types: const ['Ver'],
              image: sImagePias,
              color: lightBlue,
            ),
          );
        }
      }
    }

    aHomeOptions.add(
      HomeOptions(
        code: 'OPT1001',
        name: 'TileBitacoraRegister'.tr,
        types: const ['Ver'],
        image: icon6,
        color: lightBlue,
      ),
    );

    aHomeOptions.add(
      HomeOptions(
        code: 'OPT1005',
        name: 'TileProyectTambo'.tr,
        types: const ['Ver'],
        image: icon5,
        color: lightBlue,
      ),
    );

    aHomeOptions.add(
      HomeOptions(
        code: 'OPT1006',
        name: 'TileProgramacionActividad'.tr,
        types: const ['Ver'],
        image: icon7,
        color: lightBlue,
      ),
    );
    void _intervencionOptions(BuildContext context) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(
            'TileProgramacionActividad'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          message: Text(
            'SelectOption'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                /*
                 COORDINACIÓN Y ARTICULACIÓN
                */
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CordinacionArticulacion(),
                  ),
                );
              },
              child: Card(
                color: Color.fromARGB(255, 102, 106, 107),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.supervised_user_circle_sharp,
                        size: 40,
                        color: Color.fromARGB(255, 199, 196, 196),
                      ),
                      Expanded(
                          child: Text(
                        'TileCordArticulacion'.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                /*
                 MONITOREO Y SUPERVISIÓN
                */
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonitoreoSupervicion(),
                  ),
                );
              },
              child: Card(
                color: Color.fromARGB(255, 49, 132, 201),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    const Icon(
                      Icons.language_outlined,
                      size: 40,
                      color: Color.fromARGB(255, 199, 196, 196),
                    ),
                    Expanded(
                        child: Text(
                      'TileMinitoreoSuper'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                /*
                 ACTIVIDADES PNPAIS
                */
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActividadesPnpais(),
                  ),
                );
              },
              child: Card(
                color: Color.fromARGB(255, 61, 102, 73),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    const Icon(
                      Icons.menu_open,
                      size: 40,
                      color: Color.fromARGB(255, 199, 196, 196),
                    ),
                    Expanded(
                        child: Text(
                      'TileActividadPnpais'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ]),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () async {
            //     /*
            //      PROGRAMACION
            //     */
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ProgramacionListPage(),
            //       ),
            //     );
            //   },
            //   child: Card(
            //     color: Color.fromARGB(255, 49, 132, 201),
            //     elevation: 5.0,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         children: [
            //           const Icon(
            //             Icons.check_box,
            //             size: 40,
            //             color: Color.fromARGB(255, 199, 196, 196),
            //           ),
            //           Expanded(
            //               child: Text(
            //             'TileProgramaciones'.tr,
            //             style:
            //                 const TextStyle(color: Colors.white, fontSize: 16),
            //           )),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancelar'),
          ),
        ),
      );
    }

    List listPages = [
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: hp65,
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.only(left: 28, right: 28, bottom: 58),
                itemCount: aHomeOptions.length,
                itemBuilder: (context, index) => TiteCard(
                  aHomeOptions[index],
                  index: index,
                  onPress: () async {
                    var oHomeOptionSelect = aHomeOptions[index];

                    if (cantidadDB < 1) {
                      if (oHomeOptionSelect.code == 'OPT1000') {
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => PantallaInicio(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Registrarse en el App',
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    } else {
                      switch (oHomeOptionSelect.code) {
                        case 'OPT1001':
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Asistencia(long: long, lat: lat),
                            ),
                          );
                          break;
                        case 'OPT1003':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Intervenciones(snip, unidadTerritorial),
                            ),
                          );
                          break;
                        case 'OPT1004':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListaReportesPias(
                                unidadTeritorial: unidadTerritorial,
                                plataforma: variable,
                                idPlataforma: idPlataforma,
                                long: long,
                                lat: lat,
                                campaniaCod: campaniaCod,
                              ),
                            ),
                          );
                          break;
                        default:
                      }
                    }

                    switch (oHomeOptionSelect.code) {
                      case 'OPT1005':
                        var rspt = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MainFooterAllOptionPage(),
                          ),
                        );
                        break;
                      case 'OPT1006':
                        _intervencionOptions(context);
                        break;
                      default:
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarPegaso(
            datoUt: unidadTerritorial,
            plataforma: variable,
            nombre: '$_nombrePersona $_apellidosPersona',
            snip: snip,
          ),
          listPages[currenIndex]
        ],
      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          focusColor: Colors.amber,
          backgroundColor: Colors.orange,
          child: const Icon(Icons.manage_accounts),
          onPressed: () async {
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => PantallaInicio(),
              ),
            );
          },
        ),
      ),
    );
  }
}
