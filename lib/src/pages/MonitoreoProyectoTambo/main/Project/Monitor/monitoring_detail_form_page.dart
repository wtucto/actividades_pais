import 'dart:async';
import 'dart:collection';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Search/project_search_otro.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/src/image_controller.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/src/image_multiple.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/main_footer_all_option.dart';
import 'package:actividades_pais/util/alert_question.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:actividades_pais/util/check_geolocator.dart';
import 'package:actividades_pais/util/throw-exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class MonitoringDetailNewEditPage extends StatefulWidget {
  TramaProyectoModel? datoProyecto;
  TramaMonitoreoModel? datoMonitor;

  List<String> cbEMONI = [];
  List<String> cbNRIES = [];
  List<String> cbEAVAN = [];
  List<String> cbPEJEC = [];
  List<String> cbPIDEO = [];
  List<String> cbASOLU = [];
  List<String> cbRIDEN = [];

  final String? statusM;
  MonitoringDetailNewEditPage(
      {Key? key, this.datoProyecto, this.statusM, this.datoMonitor})
      : super(key: key);

  @override
  _MonitoringDetailNewEditPageState createState() =>
      _MonitoringDetailNewEditPageState();
}

class _MonitoringDetailNewEditPageState
    extends State<MonitoringDetailNewEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _idMonitor = TextEditingController();
  final _cuiCtr = TextEditingController();
  final _dateMonitor = TextEditingController();
  final _advanceFEA = TextEditingController();
  final _advanceFEP = TextEditingController();
  final _obsMonitor = TextEditingController();
  final _dateObra = TextEditingController();
  final _longitud = TextEditingController();
  final _latitud = TextEditingController();

  bool _enabledF = true;
  int idM = 0;
  String titleMonitor = "";
  String fechaMonitoreo = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? _ciu = "";
  String? _snip = "";
  String? _tambo = "";

  TramaMonitoreoModel oMonitoreo = TramaMonitoreoModel.empty();

  String? _statusMonitor = "";
  String? _statusAdvance = "";
  String? _valuePartidaEje = "";
  String? _valueProblemaIO = "";
  String? _valueAlternSolucion = "";
  String? _valueRiesgo = "";
  String? _valueNivelRiesgo = "";

  final MainController mainController = MainController();
  ImageController controller = ImageController();
  final String _imgPartidaEjecutada = 'imgPartidaEjecutada';
  List<bool> expandedPE = [false, false];
  final String _imgProblemaIdentificado = 'imgProblemaIdentificado';
  List<bool> expandedPI = [false, false];
  final String _imgRiesgoIdentificado = 'imgRiesgoIdentificado';
  List<bool> expandedRI = [false, false];

  String sShowMessage = '';
  void showSnackbar({required bool success, required String text}) {
    AnimatedSnackBar.rectangle(
      'I'.tr,
      text,
      type:
          success ? AnimatedSnackBarType.success : AnimatedSnackBarType.warning,
      brightness: Brightness.light,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }

  @override
  void initState() {
    super.initState();
    checkGeolocator();
    getMaestra().then((o) {
      if (mounted) {
        if (widget.statusM == "CREATE" || widget.statusM == "SEARCH") {
          loadData(context);
        }
        if (widget.statusM == "UPDATE") {
          getDataMonitor(widget.datoMonitor!);
        }
        if (widget.statusM == "LECTURA") {
          _enabledF = false;
          getDataMonitor(widget.datoMonitor!);
        }
      }
      setState(() {});
    });
  }

  Future<void> checkGeolocator() async {
    try {
      await CheckGeolocator().check();
    } catch (oError) {
      var sTitle = 'Error';
      var sMessage = oError.toString();
      if (oError is ThrowCustom) {
        sTitle = oError.typeText!;
        sMessage =
            '${oError.msg!}, vaya a Configuración de su dispositivo > Privacidad para otorgar permisos a la aplicación.';
      }
      sShowMessage = sMessage;

      setState(() {
        sShowMessage = sMessage;
      });
    }
  }

  Future<void> getMaestra() async {
    try {
      /**
       * Obtener los registros de cada combo
       */

      try {
        widget.cbASOLU = await mainController.getListComboItemByType(
            ComboItemModel.cbASOLU, 0, 0);

        widget.cbEAVAN = await mainController.getListComboItemByType(
            ComboItemModel.cbEAVAN, 0, 0);

        widget.cbEMONI = await mainController.getListComboItemByType(
            ComboItemModel.cbEMONI, 0, 0);

        widget.cbNRIES = await mainController.getListComboItemByType(
            ComboItemModel.cbNRIES, 0, 0);

        widget.cbPEJEC = await mainController.getListComboItemByType(
            ComboItemModel.cbPEJEC, 0, 0);

        widget.cbPIDEO = await mainController.getListComboItemByType(
            ComboItemModel.cbPIDEO, 0, 0);

        widget.cbRIDEN = await mainController.getListComboItemByType(
            ComboItemModel.cbRIDEN, 0, 0);

        widget.cbASOLU = LinkedHashSet<String>.from(widget.cbASOLU).toList();
        widget.cbEAVAN = LinkedHashSet<String>.from(widget.cbEAVAN).toList();
        widget.cbEMONI = LinkedHashSet<String>.from(widget.cbEMONI).toList();
        widget.cbNRIES = LinkedHashSet<String>.from(widget.cbNRIES).toList();
        widget.cbPEJEC = LinkedHashSet<String>.from(widget.cbPEJEC).toList();
        widget.cbPIDEO = LinkedHashSet<String>.from(widget.cbPIDEO).toList();
        widget.cbRIDEN = LinkedHashSet<String>.from(widget.cbRIDEN).toList();
      } catch (oError) {
        widget.cbASOLU = TramaMonitoreoModel.aAlternativaSolucion;
        widget.cbEAVAN = TramaMonitoreoModel.aEstadoAvance;
        widget.cbEMONI = TramaMonitoreoModel.aEstadoMonitoreo;
        widget.cbNRIES = TramaMonitoreoModel.aNivelRiesgo;
        widget.cbPEJEC = TramaMonitoreoModel.aActividadPartidaEjecutada;
        widget.cbPIDEO = TramaMonitoreoModel.aProblemaIdentificado;
        widget.cbRIDEN = TramaMonitoreoModel.aRiesgoIdentificado;
      }

      /**
       * Agregar valor por defecto de los combos
       * - Seleccione una opción
       * en la primera posición
       */

      String sPlaceholder = TramaMonitoreoModel.sOptDropdownDefault;
      widget.cbASOLU.insert(0, "$sPlaceholder para: ALTERNATIVA SOLUCION");
      widget.cbEAVAN.insert(0, "$sPlaceholder para: ESTADO AVANCE");
      widget.cbEMONI.insert(0, "$sPlaceholder para: ESTADO MONITOREO");
      widget.cbNRIES.insert(0, "$sPlaceholder para: NIVEL RIESGO");
      widget.cbPEJEC.insert(0, "$sPlaceholder para: PARTIDA EJECUTADA");
      widget.cbPIDEO
          .insert(0, "$sPlaceholder para: PROBLEMA IDENTIFICADO OBRA");
      widget.cbRIDEN.insert(0, "$sPlaceholder para: RIESGO IDENTIFICADO");

      /**
       * Seleccionar el valor por defecto de los combos
       * - Seleccione una opción
       */
      _statusMonitor = widget.cbEMONI[0];
      _statusAdvance = widget.cbEAVAN[0];
      _valuePartidaEje = widget.cbPEJEC[0];
      _valueProblemaIO = widget.cbPIDEO[0];
      _valueAlternSolucion = widget.cbASOLU[0];
      _valueRiesgo = widget.cbRIDEN[0];
      _valueNivelRiesgo = widget.cbNRIES[0];
    } catch (oError) {
      var sTitle = 'Error';
      var sMessage = oError.toString();
      if (oError is ThrowCustom) {
        sTitle = oError.typeText!;
        sMessage =
            '${oError.msg!}, vaya a Configuración de su dispositivo > Privacidad para otorgar permisos a la aplicación.';
      }
      sShowMessage = sMessage;

      setState(() {});
    }
  }

  Future<void> loadData(BuildContext context) async {
    try {
      if (widget.datoProyecto != null) {
        oMonitoreo =
            await mainController.buildNewMonitor(widget.datoProyecto!.cui!);
      }
    } catch (oError) {}
    try {
      setState(() {
        _snip = widget.datoProyecto?.numSnip;
        _ciu = widget.datoProyecto?.cui;
        _cuiCtr.text = _ciu!;
        _tambo = widget.datoProyecto?.tambo;
        _cuiCtr.text = oMonitoreo.cui!;
        _idMonitor.text = oMonitoreo.idMonitoreo!;
        _dateMonitor.text = oMonitoreo.fechaMonitoreo!;
        titleMonitor = oMonitoreo.tambo! == "" ? 'MONITOR' : oMonitoreo.tambo!;
        _advanceFEA.text =
            ((oMonitoreo.avanceFisicoAcumulado! * 100).toStringAsFixed(2))
                .toString();
        _dateObra.text = oMonitoreo.fechaTerminoEstimado!;
        _longitud.text = oMonitoreo.longitud!;
        _latitud.text = oMonitoreo.latitud!;
        if (oMonitoreo.estadoMonitoreo != "") {
          _statusMonitor = oMonitoreo.estadoMonitoreo;
        }
      });
    } catch (error) {
      print(error);
    }
  }

  String getPorcent(double value) {
    return ((value * 100).toStringAsFixed(2)).toString();
  }

  String getValueSelected(String value) {
    return (value.toUpperCase().contains("SELECCIONE UNA OPCIÓN") ||
            value == "")
        ? ""
        : value;
  }

  getDataMonitor(TramaMonitoreoModel m) {
    controller.itemsImagesAll = {};
    setState(() {
      titleMonitor = m.tambo!;
      idM = m.id!;
      _snip = m.snip;
      _cuiCtr.text = m.cui!;
      _idMonitor.text = m.idMonitoreo!;

      _tambo = m.tambo;
      _dateMonitor.text = m.fechaMonitoreo!;
      _advanceFEA.text = getPorcent(m.avanceFisicoAcumulado!);
      _advanceFEP.text = getPorcent(m.avanceFisicoPartida!);
      _obsMonitor.text = m.observaciones!;
      _dateObra.text = m.fechaTerminoEstimado!;
      _longitud.text = m.longitud!;
      _latitud.text = m.latitud!;

      _statusMonitor =
          m.estadoMonitoreo == "" ? widget.cbEMONI[0] : m.estadoMonitoreo;
      _statusAdvance =
          m.estadoAvance == "" ? widget.cbEAVAN[0] : m.estadoAvance;
      _valuePartidaEje = m.actividadPartidaEjecutada == ""
          ? widget.cbPEJEC[0]
          : m.actividadPartidaEjecutada;
      _valueProblemaIO = m.problemaIdentificado == ""
          ? widget.cbPIDEO[0]
          : m.problemaIdentificado;
      _valueAlternSolucion = m.alternativaSolucion == ""
          ? widget.cbASOLU[0]
          : m.alternativaSolucion;
      _valueRiesgo =
          m.riesgoIdentificado == "" ? widget.cbRIDEN[0] : m.riesgoIdentificado;
      _valueNivelRiesgo =
          m.nivelRiesgo == "" ? widget.cbNRIES[0] : m.nivelRiesgo;

      List<String?> listaImage = [];
      listaImage.addAll([
        m.imgActividad,
        m.imgActividad1,
        m.imgActividad2,
        m.imgActividad3,
        m.imgActividad4
      ]);

      for (var item in listaImage) {
        if (!item.toString().contains("opt/uploads")) {
          if (item != null && item != "") {
            controller.itemsImagesAll.addAll(
              {
                _imgPartidaEjecutada: item.split(","),
              },
            );
          }
        }
      }

      listaImage = [];
      listaImage.addAll([
        m.imgProblema,
        m.imgProblema1,
        m.imgProblema2,
        m.imgProblema3,
        m.imgProblema4
      ]);
      for (var item in listaImage) {
        if (!item.toString().contains("opt/uploads")) {
          if (item != null && item != "") {
            controller.itemsImagesAll.addAll(
              {
                _imgProblemaIdentificado: item.split(","),
              },
            );
          }
        }
      }

      listaImage = [];
      listaImage.addAll([
        m.imgRiesgo,
        m.imgRiesgo1,
        m.imgRiesgo2,
        m.imgRiesgo3,
        m.imgRiesgo4,
      ]);
      for (var item in listaImage) {
        if (!item.toString().contains("opt/uploads")) {
          if (item != null && item != "") {
            controller.itemsImagesAll.addAll(
              {
                _imgRiesgoIdentificado: item.split(","),
              },
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => {
            if (widget.statusM == "SEARCH")
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainFooterAllOptionPage(),
                    ))
              }
            else
              {
                Navigator.pop(context, () {
                  setState(() {});
                }),
              }
          },
        ),
        title: Center(
          child: Text(
            titleMonitor == "" ? "MONITOR" : titleMonitor,
            style: const TextStyle(
              color: Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                if (titleMonitor == "") {
                  showSearch(
                    context: context,
                    delegate: ProjetSearchOtroDelegate(),
                  );
                }
              },
              icon: Icon(
                titleMonitor == "" ? Icons.search : Icons.monitor,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
      ),
      /**
       * Formulario
       */
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            /**
               * CODIGO UNICO DE PROYECTO
              */
            Text(
              'FldMonitor001'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _cuiCtr,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
            ),
            /**
               * ID MONITOREO
              */
            const SizedBox(height: 10),
            Text(
              'FldMonitor002'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _idMonitor,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
            ),
            /**
               * ESTADO MONITOREO
              */
            const SizedBox(height: 10),
            Text(
              'FldMonitor003'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            MyDropdownButtonFormField(
              value: _statusMonitor!,
              items: widget.cbEMONI,
              isDense: false,
              onChanged: null,
              isRequired: false,
            ),

            /**
             * FECHA MONITOREO
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor004'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _dateMonitor,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  setState(() {
                    _dateMonitor.text = _dateMonitor.text;
                  });
                }
              },
            ),
            /**
            * % AVANCE FISICO ESTIMADO ACUMULADO
            */
            const SizedBox(height: 10),
            Text(
              'FldMonitor005'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _advanceFEA,
              keyboardType: TextInputType.number,
              maxLength: 6,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              enabled: _enabledF,
              validator: (v) {
                final intNumber = double.tryParse(v!);
                if (intNumber != null && intNumber > 0 && intNumber <= 100) {
                  return null;
                }
                return 'Ingrese el numero de 0 A 100';
              },
            ),

            /**
             * % ESTADO DE AVANCE
             */
            const SizedBox(height: 5),
            Text(
              'FldMonitor006'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            MyDropdownButtonFormField(
              value: _statusAdvance!,
              items: widget.cbEAVAN,
              isDense: false,
              isRequired: true,
              onChanged: _enabledF
                  ? (val) {
                      setState(() {
                        _statusAdvance = val.toString();
                      });
                    }
                  : null,
            ),
            /**
             * PARTIDA EJECUTADA
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor007'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            MyDropdownButtonFormField(
              value: _valuePartidaEje!,
              items: widget.cbPEJEC,
              isDense: false,
              isRequired: true,
              onChanged: _enabledF
                  ? (val) async {
                      String sValue = val.toString().toUpperCase();
                      _valuePartidaEje = val.toString();
                      try {
                        TramaProyectoModel oProyect =
                            TramaProyectoModel.empty();
                        oProyect.numSnip = _snip;
                        TramaMonitoreoModel oLastMonitor =
                            await mainController.getMonitoreoLastTypePartida(
                          oProyect,
                          _valuePartidaEje!,
                        );

                        _advanceFEP.text =
                            ((oLastMonitor.avanceFisicoPartida! * 100)
                                    .toStringAsFixed(2))
                                .toString();
                      } catch (e) {
                        _advanceFEP.text = '0.00';
                      }

                      setState(() {});
                    }
                  : null,
            ),
            /**
             * % AVANCE FISICO ACUMULADO PARTIDA
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor008'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _advanceFEP,
              maxLength: 6,
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: _enabledF,
            ),
            /**
             * Fotos de la Partida Ejecutada(Obligatorio) 
            */
            _enabledF
                ? OutlinedButton.icon(
                    label: Text(
                      'FldMonitor009'.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    icon: const Icon(Icons.image),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      await _showChoiceDialog(context, _imgPartidaEjecutada);
                      setState(() {});
                    },
                  )
                : Text(
                    'FldMonitor009'.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            const SizedBox(height: 10),
            myExpansionPanelListethod(_imgPartidaEjecutada, expandedPE),

            /**
           * OBSERVACIONES
           */
            const SizedBox(height: 10),
            Text(
              'FldMonitor010'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: _obsMonitor,
              enabled: _enabledF,
              // validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * PROBLEMA IDENTIFICADO EN LA OBRA (Obligatorio)
           */
            const SizedBox(height: 10),
            Text(
              'FldMonitor011'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            MyDropdownButtonFormField(
              value: _valueProblemaIO!,
              items: widget.cbPIDEO,
              isDense: false,
              isRequired: true,
              onChanged: _enabledF
                  ? (val) {
                      setState(() {
                        _valueProblemaIO = val.toString();
                      });
                    }
                  : null,
            ),
            /**
             * Foto del Problema Identificado (Opcional)
             */
            const SizedBox(height: 10),
            _enabledF
                ? OutlinedButton.icon(
                    label: Text(
                      'FldMonitor012'.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    icon: const Icon(Icons.image),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      await _showChoiceDialog(
                          context, _imgProblemaIdentificado);
                      setState(() {});
                    },
                  )
                : Text(
                    'FldMonitor012'.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            const SizedBox(height: 10),
            myExpansionPanelListethod(_imgProblemaIdentificado, expandedPI),
            /**
             * ALTERNATIVA DE SOLUCION
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor013'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            MyDropdownButtonFormField(
              value: _valueAlternSolucion!,
              items: widget.cbASOLU,
              isDense: false,
              isRequired: true,
              onChanged: _enabledF
                  ? (val) {
                      setState(() {
                        _valueAlternSolucion = val.toString();
                      });
                    }
                  : null,
            ),
            /**
             * SELECCIONES EL RIESGO Identificado
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor014'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            MyDropdownButtonFormField(
              value: _valueRiesgo!,
              items: widget.cbRIDEN,
              isDense: false,
              isRequired: false,
              onChanged: _enabledF
                  ? (val) {
                      setState(() {
                        _valueRiesgo = val.toString();
                      });
                    }
                  : null,
            ),
            /**
             * Foto del Riesgo Identificado (Opcional)
             */
            const SizedBox(height: 5),
            _enabledF
                ? OutlinedButton.icon(
                    label: Text(
                      'FldMonitor015'.tr,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    icon: const Icon(Icons.image),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      await _showChoiceDialog(context, _imgRiesgoIdentificado);
                      setState(() {});
                    },
                  )
                : Text(
                    'FldMonitor015'.tr,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            const SizedBox(height: 10),
            myExpansionPanelListethod(_imgRiesgoIdentificado, expandedRI),
            /**
            * NIVEL DE RIESGO
            */
            const SizedBox(height: 10),
            Text(
              'FldMonitor016'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            MyDropdownButtonFormField(
              value: _valueNivelRiesgo!,
              items: widget.cbNRIES,
              isDense: false,
              isRequired: false,
              onChanged: _enabledF
                  ? (val) {
                      setState(() {
                        _valueNivelRiesgo = val.toString();
                      });
                    }
                  : null,
            ),

            /**
             * FECHA TERMINO OBRA
             */
            const SizedBox(height: 10),
            Text(
              'FldMonitor017'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _dateObra,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: _enabledF,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    _dateObra.text = formattedDate;
                  });
                }
              },
            ),
            /**
           * LOGITUD
           */
            const SizedBox(height: 10),
            Text(
              'FldMonitor018'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _longitud,
              enabled: _enabledF,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * LATITUD
           */
            const SizedBox(height: 10),
            Text(
              'FldMonitor019'.tr,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextFormField(
              controller: _latitud,
              enabled: _enabledF,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            const SizedBox(height: 10),
            Text(sShowMessage,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.red.withOpacity(1.0),
                  fontWeight: FontWeight.bold,
                )),
            /**
             * Botones
             */
            const SizedBox(height: 32),
            _enabledF
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 12, 124, 205),
                          shadowColor: const Color.fromARGB(255, 53, 53, 53),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          String imgPE = "";
                          String imgPI = "";
                          String imgRI = "";

                          controller.itemsImagesAll.forEach((key, items) {
                            if (key == _imgPartidaEjecutada) {
                              imgPE = items.join(",");
                            }
                            if (key == _imgProblemaIdentificado) {
                              imgPI = items.join(",");
                            }
                            if (key == _imgRiesgoIdentificado) {
                              imgRI = items.join(",");
                            }
                          });
                          _prefs = await SharedPreferences.getInstance();
                          UserModel oUser = UserModel(
                            nombres: _prefs!.getString("nombres") ?? "",
                            codigo: _prefs!.getString("codigo") ?? "",
                            rol: _prefs!.getString("rol") ?? "",
                          );
                          try {
                            final alert = AlertQuestion(
                                title: "Información",
                                message: "¿Está Seguro de Guardar Monitor?",
                                onNegativePressed: () {
                                  Navigator.of(context).pop();
                                },
                                onPostivePressed: () async {
                                  Navigator.of(context).pop();
                                  BusyIndicator.show(context);
                                  try {
                                    TramaMonitoreoModel dataSave =
                                        await mainController
                                            .saveMonitoreo(TramaMonitoreoModel(
                                      id: idM,
                                      isEdit: 1,
                                      createdTime: DateTime.now(),
                                      snip: _snip,
                                      cui: _cuiCtr.text,
                                      latitud: _latitud.text,
                                      longitud: _longitud.text,
                                      tambo: _tambo,
                                      fechaTerminoEstimado: _dateObra.text,
                                      avanceFisicoAcumulado: (double.parse(
                                              _advanceFEA.text == ""
                                                  ? "0"
                                                  : _advanceFEA.text) /
                                          100),
                                      avanceFisicoPartida: (double.parse(
                                              _advanceFEP.text == ""
                                                  ? "0"
                                                  : _advanceFEP.text) /
                                          100),
                                      fechaMonitoreo: _dateMonitor.text,
                                      idMonitoreo: _idMonitor.text,
                                      idUsuario: oUser.codigo,
                                      imgActividad: imgPE,
                                      imgProblema: imgPI,
                                      imgRiesgo: imgRI,
                                      observaciones: _obsMonitor.text,
                                      estadoAvance:
                                          getValueSelected(_statusAdvance!),
                                      estadoMonitoreo:
                                          getValueSelected(_statusMonitor!),
                                      actividadPartidaEjecutada:
                                          getValueSelected(_valuePartidaEje!),
                                      alternativaSolucion: getValueSelected(
                                          _valueAlternSolucion!),
                                      problemaIdentificado:
                                          getValueSelected(_valueProblemaIO!),
                                      riesgoIdentificado:
                                          getValueSelected(_valueRiesgo!),
                                      nivelRiesgo:
                                          getValueSelected(_valueNivelRiesgo!),
                                      rol: oUser.rol,
                                      usuario: oUser.nombres,
                                    ));

                                    BusyIndicator.hide(context);
                                    if (idM == 0) {
                                      showSnackbar(
                                        success: true,
                                        text: 'Datos Guardados Correctamente',
                                      );
                                    } else {
                                      showSnackbar(
                                        success: true,
                                        text:
                                            'Datos Actualizados Correctamente',
                                      );
                                    }
                                    getDataMonitor(dataSave);
                                  } catch (oError) {
                                    var sTitle = 'Error';
                                    var sMessage = oError.toString();
                                    if (oError is ThrowCustom) {
                                      sTitle = oError.typeText!;
                                      sMessage = oError.msg!;
                                    }

                                    BusyIndicator.hide(context);
                                    AnimatedSnackBar.rectangle(
                                      sTitle,
                                      sMessage,
                                      type: AnimatedSnackBarType.error,
                                      brightness: Brightness.light,
                                      mobileSnackBarPosition:
                                          MobileSnackBarPosition.top,
                                    ).show(context);
                                  }
                                });

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          } catch (ex) {
                            BusyIndicator.hide(context);
                            AnimatedSnackBar.rectangle(
                              'Error',
                              ex.toString(),
                              type: AnimatedSnackBarType.error,
                              brightness: Brightness.light,
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                            ).show(context);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: width / 3.5,
                          child: Center(
                            child: Text(
                              'SaveData'.tr,
                              style: const TextStyle(
                                color: Color(0xfffefefe),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 1, 173, 130),
                          shadowColor: const Color.fromARGB(255, 53, 53, 53),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String imgPE = "";
                            String imgPI = "";
                            String imgRI = "";
                            controller.itemsImagesAll.forEach((key, items) {
                              if (key == _imgPartidaEjecutada) {
                                imgPE = items.join(",");
                              }
                              if (key == _imgProblemaIdentificado) {
                                imgPI = items.join(",");
                              }
                              if (key == _imgRiesgoIdentificado) {
                                imgRI = items.join(",");
                              }
                            });
                            _prefs = await SharedPreferences.getInstance();
                            UserModel oUser = UserModel(
                              nombres: _prefs!.getString("nombres") ?? "",
                              codigo: _prefs!.getString("codigo") ?? "",
                              rol: _prefs!.getString("rol") ?? "",
                            );
                            if (imgPE == "") {
                              showSnackbar(
                                success: false,
                                text:
                                    'Debe ingresar una imagen de la partida Ejecutada',
                              );
                            } else {
                              if (idM == 0) {
                                AnimatedSnackBar.rectangle(
                                  'Error',
                                  'Para enviar un monitoreo debes ingresar todos los campos obligatorios y hacer click en el botón grabar',
                                  type: AnimatedSnackBarType.error,
                                  brightness: Brightness.light,
                                  mobileSnackBarPosition:
                                      MobileSnackBarPosition.top,
                                ).show(context);
                              } else {
                                final alert = AlertQuestion(
                                    title: "Información",
                                    message: "¿Está Seguro de Enviar Monitor?",
                                    onNegativePressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    onPostivePressed: () async {
                                      Navigator.of(context).pop();
                                      BusyIndicator.show(context);
                                      try {
                                        List<TramaMonitoreoModel> dataSend =
                                            await mainController.sendMonitoreo([
                                          TramaMonitoreoModel(
                                            id: idM,
                                            isEdit: 1,
                                            createdTime: DateTime.now(),
                                            snip: _snip,
                                            cui: _cuiCtr.text,
                                            latitud: _latitud.text,
                                            longitud: _longitud.text,
                                            tambo: _tambo,
                                            fechaTerminoEstimado:
                                                _dateObra.text,
                                            avanceFisicoAcumulado:
                                                (double.parse(
                                                        _advanceFEA.text == ""
                                                            ? "0"
                                                            : _advanceFEA
                                                                .text) /
                                                    100),
                                            avanceFisicoPartida: (double.parse(
                                                    _advanceFEP.text == ""
                                                        ? "0"
                                                        : _advanceFEP.text) /
                                                100),
                                            fechaMonitoreo: _dateMonitor.text,
                                            idMonitoreo: _idMonitor.text,
                                            idUsuario: oUser.codigo,
                                            imgActividad: imgPE,
                                            imgProblema: imgPI,
                                            imgRiesgo: imgRI,
                                            observaciones: _obsMonitor.text,
                                            estadoAvance: getValueSelected(
                                                _statusAdvance!),
                                            estadoMonitoreo: getValueSelected(
                                                _statusMonitor!),
                                            actividadPartidaEjecutada:
                                                getValueSelected(
                                                    _valuePartidaEje!),
                                            alternativaSolucion:
                                                getValueSelected(
                                                    _valueAlternSolucion!),
                                            problemaIdentificado:
                                                getValueSelected(
                                                    _valueProblemaIO!),
                                            riesgoIdentificado:
                                                getValueSelected(_valueRiesgo!),
                                            nivelRiesgo: getValueSelected(
                                                _valueNivelRiesgo!),
                                            rol: oUser.rol,
                                            usuario: oUser.nombres,
                                          )
                                        ]);
                                        BusyIndicator.hide(context);

                                        if (dataSend.isEmpty) {
                                          showSnackbar(
                                            success: true,
                                            text:
                                                'Datos Enviados Correctamente',
                                          );
                                        } else {
                                          /**
                                           * Mostrar el registro que esta generando error
                                           */
                                          getDataMonitor(dataSend[0]);

                                          AnimatedSnackBar.rectangle(
                                            'Error',
                                            'No se pudo enviar el monitor',
                                            type: AnimatedSnackBarType.error,
                                            brightness: Brightness.light,
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.top,
                                          ).show(context);
                                        }
                                      } catch (ex) {
                                        BusyIndicator.hide(context);
                                        AnimatedSnackBar.rectangle(
                                          'Error',
                                          ex.toString(),
                                          type: AnimatedSnackBarType.error,
                                          brightness: Brightness.light,
                                          mobileSnackBarPosition:
                                              MobileSnackBarPosition.top,
                                        ).show(context);
                                      }
                                    });

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }
                            }
                          } else {
                            showSnackbar(
                              success: false,
                              text: 'RequiredFields'.tr,
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: width / 3.5,
                          child: Center(
                            child: Text(
                              'SendData'.tr,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Row(),
          ],
        ),
      ),
    );
  }

  ListView myExpansionPanelListethod(
      String fieldNameImage, List<bool> expanded) {
    return ListView(shrinkWrap: true, children: [
      ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              expanded[panelIndex] = !isExpanded;
            });
          },
          animationDuration: const Duration(milliseconds: 600),
          children: [
            ExpansionPanel(
              backgroundColor: expanded[0] == true
                  ? const Color.fromARGB(255, 224, 230, 231)
                  : Colors.white,
              headerBuilder: (context, isOpen) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    "FldMonitor020".tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
              body: Container(
                padding: const EdgeInsets.all(5),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    MyImageMultiple(
                        controller: controller,
                        nameField: fieldNameImage,
                        enabled: _enabledF),
                  ],
                ),
              ),
              isExpanded: expanded[0],
            ),
          ]),
    ]);
  }

  Future<void> _confirmDialog(String sAction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('W'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('ConfirmationQuestion100'.tr),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'.tr),
              onPressed: () {
                if (sAction == 'SAVE') {}
                /*Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));*/
              },
            ),
            TextButton(
              child: Text('No'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showChoiceDialog(BuildContext context, String nameImage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            title: const Text(
              'SELECCIONAR',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(10),
                    ),
                    label: const Text(
                      'Imagen de Galeria',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    icon: const Icon(Icons.image),
                    onPressed: () async {
                      await controller.selectMultipleImage(nameImage);
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(10),
                    ),
                    label: const Text(
                      'Tomar una Foto',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    icon: const Icon(Icons.camera_alt_rounded),
                    onPressed: () async {
                      await controller.imageCamera(nameImage);
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class MyDropdownButtonFormField extends StatelessWidget {
  const MyDropdownButtonFormField(
      {Key? key,
      required this.items,
      required this.value,
      required this.isDense,
      this.onChanged,
      required this.isRequired})
      : super(key: key);

  final List<dynamic> items;
  final String value;
  final bool isDense;
  final void Function(Object?)? onChanged;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      // hint: Text(
      //   'seleccione una opción',
      //   style: TextStyle(
      //     fontSize: 14,
      //     color: Theme.of(context).hintColor,
      //   ),
      // ),
      isExpanded: true,
      isDense: isDense,
      value: value.isNotEmpty ? value : null,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      onChanged: onChanged,
      validator: isRequired
          ? (value) => value
                      .toString()
                      .toUpperCase()
                      .contains("SELECCIONE UNA OPCIÓN") ||
                  value == ""
              ? 'Required'.tr
              : null
          : null,
      items: items.isNotEmpty
          ? items
              .map(
                (e) => DropdownMenuItem(
                    value: e,
                    child: e.toUpperCase().contains("SELECCIONE UNA OPCIÓN")
                        ? Text(
                            e,
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor),
                          )
                        : Text(
                            e,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
              )
              .toList()
          : null,
    );
  }
}
