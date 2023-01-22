import 'dart:async';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Components/card.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/main_footer_all_option.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/actividadesPnpais.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/cordinacion_articulacion.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/monitoreo_suspervicion.dart';
import 'package:actividades_pais/src/pages/ProgramacionActividades/programacion_list_page.dart';
import 'package:actividades_pais/src/pages/SeguimientoParqueInform%C3%A1tico/SeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/pages/Tambook/dashboard_tambook.dart';
import 'package:actividades_pais/src/pages/seguimientoMonitoreo/dashboard.dart';
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
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appbar/AppBar.dart';

SharedPreferences? _prefs;

class HomePagePais extends StatefulWidget {
  static String route = '/';

  @override
  _HomePagePais createState() => _HomePagePais();
}

class _HomePagePais extends State<HomePagePais> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final Logger _log = Logger();

  int currenIndex = 0;
  var cantidadDB = 0;
  Color changecolor = Colors.grey;
  bool _isVisible = true;
  var _nombrePersona = '';
  var _apellidosPersona = '';
  var unidadTerritorial = '';
  var variable = '';
  //var snip = 0;
  //List<int> snips = [];
  var idPlataforma = 0;
  var tipoPlataforma = '';
  var campaniaCod = '';
  var modalidad = '';
  int? dniPrueba;

  String? token;

  String long = '';
  String lat = '';
  List<String> aUnidad = [];
  @override
  void initState() {
    super.initState();

    ///ProviderDatos().   verificacionpesmiso();
    mostrarTmbo();
    traerdato();
    verificargps();
    datosParaPerfil();
    mostrarNombre();
  }

  Future verificargps() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
    } else {}
  }

  traerdato() async {
    await ProviderDatos().verificacionpesmiso();
  }

  datosParaPerfil() async {
    cantidadDB = 1;
    var res = await DatabasePr.db.getAllConfigPersonal();
    if (res.length > 0) {
      List<String> aUnidadTemp = [];
      String codigo = '';
      List<String> aPass = [];
      for (var u in res) {
        aUnidadTemp.add(u.unidad);
        if (u.unidad == 'UPS') codigo = u.codigo;
      }

      setState(() {
        aUnidad = aUnidadTemp;
      });
      return;
    }
  }

  mostrarTmbo() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllTasksConfigInicio();
    var user = await DatabasePr.db.getLoginUser();
    //_log.i(abc[0].nombreTambo);
    // print(object)
    if (abc.isNotEmpty) {
      var idlp = abc[abc.length - 1].idLugarPrestacion;
      var iduo = abc[abc.length - 1].idUnidadesOrganicas;

      setState(() {
        mostrarNombre();
        if (abc.isNotEmpty) {
          tipoPlataforma = abc[0].tipoPlataforma;
          unidadTerritorial = abc[0].unidTerritoriales;

          /*   mostrarNombre();
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
          }*/
        }
      });
    }
  }

  Future mostrarNombre() async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    print("abc[0].nombres");
    print(abc[0].nombres);
    dniPrueba = abc[0].numeroDni;
    _prefs = await SharedPreferences.getInstance();
    token = _prefs!.getString("token");
    //&& token == null
    if (abc.isNotEmpty) {
      setState(() {
        _nombrePersona = abc[abc.length - 1].nombres.toUpperCase();
        _apellidosPersona =
            '${abc[abc.length - 1].apellidoPaterno.toUpperCase()} ${abc[abc.length - 1].apellidoMaterno.toUpperCase()}';
      });
    } else {
      setState(() {
        _nombrePersona = _prefs!.getString("nombres")!;
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
    String icon8 = 'assets/Tambook/libro-abierto.png';

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
      print("tipoPlataforma");
      print(tipoPlataforma);

      if (tipoPlataforma == 'JF') {
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1003',
            name: 'TileIntervencion'.tr,
            types: const ['Ver'],
            image: icon4,
            color: lightBlue,
          ),
        );
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1009',
            name: 'TileParqueInfomatico'.tr,
            types: const ['Ver'],
            image: icon5,
            color: lightBlue,
          ),
        );
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
      if (dniPrueba == 47532262 || dniPrueba == 48400113) {
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1006',
            name: 'TileProgramacionActividad'.tr,
            types: const ['Ver'],
            image: icon7,
            color: lightBlue,
          ),
        );
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1008',
            name: 'TAMBOOK',
            types: const ['Ver'],
            image: icon8,
            color: lightBlue,
          ),
        );
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1007',
            name: 'SEGUIMINETO Y MONITOREO',
            types: const ['Ver'],
            image: icon1,
            color: lightBlue,
          ),
        );
      }
    }

    if (aUnidad.contains("UPS")) {
      if (token != null) {
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1007',
            name: 'SEGUIMINETO Y MONITOREO',
            types: const ['Ver'],
            image: icon1,
            color: lightBlue,
          ),
        );
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1008',
            name: 'TAMBOOK',
            types: const ['Ver'],
            image: icon8,
            color: lightBlue,
          ),
        );
      } else {
        aHomeOptions.add(
          HomeOptions(
            code: 'OPT1005',
            name: 'TileProyectTambo'.tr,
            types: const ['Ver'],
            image: icon5,
            color: lightBlue,
          ),
        );
      }
    }

    void _intervencionOptions(BuildContext context) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('TileProgramacionActividad'.tr),
          message: Text('SelectOption'.tr),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              //isDefaultAction: true,
              onPressed: () async {
                /*
                 COORDINACIÓN Y ARTICULACIÓN
                */
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CordinacionArticulacion(),
                  ),
                );
              },
              child: Text('TileCordArticulacion'.tr),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
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
              child: Text('TileMinitoreoSuper'.tr),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
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
              child: Text('TileActividadPnpais'.tr),
            ),
            // CupertinoActionSheetAction(
            //   onPressed: () async {
            //     /*
            //      ACTIVIDADES PNPAIS
            //     */
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ProgramacionListPage(),
            //       ),
            //     );
            //   },
            //   child: Text('TileProgramaciones'.tr),
            // ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
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
                                  Intervenciones(unidadTerritorial),
                            ),
                          );
                          break;
                          case 'OPT1009':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SeguimientoParqueInformatico(),
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
                      case 'OPT1007':
                        var rspt = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => Dashboard(),
                          ),
                        );
                        break;
                      case 'OPT1008':
                        var rspt = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DashboardTambook(),
                            // builder: (_) => HomeTambook(),
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
          AppBarPais(
            datoUt: token == null ? unidadTerritorial : '',
            plataforma: variable,
            nombre: '$_nombrePersona $_apellidosPersona',
            // snip: snip,
          ),
          listPages[currenIndex]
        ],
      ),
    );
  }
}
