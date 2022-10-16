import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/src/image_controller.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/src/image_multiple.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class MonitoringDetailNewEditPage extends StatefulWidget {
  TramaProyectoModel? datoProyecto;
  MonitoringDetailNewEditPage({Key? key, this.datoProyecto}) : super(key: key);

  @override
  _MonitoringDetailNewEditPageState createState() =>
      _MonitoringDetailNewEditPageState();
}

class _MonitoringDetailNewEditPageState
    extends State<MonitoringDetailNewEditPage> {
  _MonitoringDetailNewEditPageState() {
    _statusMonitor = _itemStatusMonitor[0];
    _statusAdvance = _itemStatusAdvance[0];
    _valuePartidaEje = _itemsPartidaEje[0];
    _valueProblemaIO = _itemProblemaIO[0];
    _valueAlternSolucion = _itemAlternSolucion[0];
    _valueRiesgo = _itemRiesgo[0];
    _valueNivelRiesgo = _itemNivelRiesgo[0];
  }
  int idM = 0;
  String titleMonitor = "";
  String fechaMonitoreo = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? _statusAdvance;
  String? _valueRiesgo;
  String? _statusMonitor;
  String? _valuePartidaEje;
  String? _valueProblemaIO;
  String? _valueAlternSolucion;
  String? _valueNivelRiesgo;
  final _formKey = GlobalKey<FormState>();
  final _idMonitor = TextEditingController();
  final _dateMonitor = TextEditingController();
  final _advanceFEA = TextEditingController();
  final _advanceFEP = TextEditingController();
  final _obsMonitor = TextEditingController();
  final _dateObra = TextEditingController();
  final _longitud = TextEditingController();
  final _latitud = TextEditingController();

  final _itemStatusMonitor = TramaMonitoreoModel.aEstadoMonitoreo;
  final _itemNivelRiesgo = TramaMonitoreoModel.aNivelRiesgo;
  final _itemStatusAdvance = TramaMonitoreoModel.aEstadoAvance;
  final _itemsPartidaEje = TramaMonitoreoModel.aActividadPartidaEjecutada;
  final _itemProblemaIO = TramaMonitoreoModel.aProblemaIdentificado;
  final _itemAlternSolucion = TramaMonitoreoModel.aAlternativaSolucion;
  final _itemRiesgo = TramaMonitoreoModel.aRiesgoIdentificado;

  final MainController mainController = MainController();
  ImageController controller = ImageController();
  final String _imgPartidaEjecutada = 'imgPartidaEjecutada';
  List<bool> expandedPE = [false, false];
  final String _imgProblemaIdentificado = 'imgProblemaIdentificado';
  List<bool> expandedPI = [false, false];
  final String _imgRiesgoIdentificado = 'imgRiesgoIdentificado';
  List<bool> expandedRI = [false, false];

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
  Widget build(BuildContext context) {
    _idMonitor.text = widget.datoProyecto?.cui == null
        ? "${fechaMonitoreo}"
        : "${widget.datoProyecto?.cui}_IDE_$fechaMonitoreo";
    _dateMonitor.text = fechaMonitoreo;
    titleMonitor = widget.datoProyecto?.tambo == null
        ? "MONITOR"
        : "${widget.datoProyecto?.tambo}";
    _advanceFEA.text = widget.datoProyecto?.avanceFisico == null
        ? ""
        : "${widget.datoProyecto?.avanceFisico}";
    _dateObra.text = widget.datoProyecto?.fechaTerminoEstimado == null
        ? ""
        : "${widget.datoProyecto?.fechaTerminoEstimado}";
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Center(
          child: Text(
            titleMonitor,
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
                onPressed: () {},
                icon: const Icon(
                  Icons.monitor,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          )
        ],
      ),
      /**
       * Formulario
       */
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            /**
               * ID MONITOREO
              */
            TextFormField(
              controller: _idMonitor,
              decoration: const InputDecoration(labelText: 'Id Monitoreo *'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
               * ESTADO MONITOREO
              */
            myDropdownButtonFormField(_statusMonitor!, _itemStatusMonitor,
                false, 'Estado Monitoreo *', false),
            /**
               * FECHA MONITOREO
               */
            TextFormField(
              controller: _dateMonitor,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Fecha Monitoreo *'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
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
            TextFormField(
              controller: _advanceFEA,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '% Avance Fisico Estimado Acumulado *',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),

            /**
             * % ESTADO DE AVANCE
             */
            myDropdownButtonFormField(_statusAdvance!, _itemStatusAdvance,
                false, 'Estado de Avance *', true),
            /**
               * PARTIDA EJECUTADA
               */
            myDropdownButtonFormField(_valuePartidaEje!, _itemsPartidaEje,
                false, 'Partida Ejecutada *', true),
            /**
               * % AVANCE FISICO ACUMULADO PARTIDA
               */
            TextFormField(
              controller: _advanceFEP,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: '% Avance Fisico Acumulado Partida *'),
              // validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
             * Fotos de la Partida Ejecutada(Obligatorio) 
            */
            OutlinedButton.icon(
              label: const Text('Fotos de la Partida Ejecutada *'),
              icon: const Icon(Icons.image),
              onPressed: () async {
                await controller.selectMultipleImage(_imgPartidaEjecutada);
                setState(() {});
              },
            ),
            myExpansionPanelListethod(_imgPartidaEjecutada, expandedPE),

            /**
           * OBSERVACIONES
           */
            TextFormField(
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: _obsMonitor,
              decoration: const InputDecoration(labelText: 'Observaciones'),
              // validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * PROBLEMA IDENTIFICADO EN LA OBRA (Obligatorio)
           */
            myDropdownButtonFormField(_valueProblemaIO!, _itemProblemaIO, false,
                'Problema Indentificado en la Obra *', true),
            /**
             * Foto del Problema Identificado (Opcional)
             */
            OutlinedButton.icon(
              label: const Text('Foto del Problema Identificado'),
              icon: const Icon(Icons.image),
              onPressed: () async {
                await controller.selectMultipleImage(_imgProblemaIdentificado);
                setState(() {});
              },
            ),
            myExpansionPanelListethod(_imgProblemaIdentificado, expandedPI),
            /**
             * ALTERNATIVA DE SOLUCION
             */
            myDropdownButtonFormField(_valueAlternSolucion!,
                _itemAlternSolucion, false, 'Alternativa de Solución *', true),
            /**
           * SELECCIONES EL RIESGO Identificado
           */
            myDropdownButtonFormField(_valueRiesgo!, _itemRiesgo, false,
                'Riesgo Identificado', false),
            /**
             * Foto del Riesgo Identificado (Opcional)
             */
            OutlinedButton.icon(
              label: const Text('Foto del Riesgo Identificado'),
              icon: const Icon(Icons.image),
              onPressed: () async {
                await controller.selectMultipleImage(_imgRiesgoIdentificado);
                setState(() {});
              },
            ),
            myExpansionPanelListethod(_imgRiesgoIdentificado, expandedRI),
            /**
            * NIVEL DE RIESGO
            */
            myDropdownButtonFormField(_valueNivelRiesgo!, _itemNivelRiesgo,
                false, 'Nivel de Riesgo', false),

            /**
           * FECHA TERMINO OBRA
           */
            TextFormField(
              controller: _dateObra,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  //icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: 'Fecha Termino Obra *' //label text of field
                  ),

              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    _dateObra.text =
                        formattedDate; //set output date to TextField value.
                  });
                }
              },
            ),
            /**
           * LOGITUD
           */
            TextFormField(
              controller: _longitud,
              decoration: const InputDecoration(labelText: 'Longitud *'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * LATITUD
           */
            TextFormField(
              controller: _latitud,
              decoration: const InputDecoration(labelText: 'Latitud *'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
             * Botones
             */
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 12, 124, 205),
                    onPrimary: Colors.white,
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
                      TramaMonitoreoModel dataSave = await mainController
                          .saveMonitoreo(TramaMonitoreoModel(
                        id: idM,
                        isEdit: 1,
                        createdTime: DateTime.now(),
                        snip: widget.datoProyecto?.numSnip,
                        cui: widget.datoProyecto?.cui,
                        latitud: _latitud.text,
                        longitud: _longitud.text,
                        tambo: widget.datoProyecto?.tambo,
                        fechaTerminoEstimado: _dateObra.text,
                        actividadPartidaEjecutada:
                            _valuePartidaEje!.toUpperCase() ==
                                    "SELECCIONE UNA OPCIÓN"
                                ? ""
                                : _valuePartidaEje!,
                        alternativaSolucion:
                            _valueAlternSolucion!.toUpperCase() ==
                                    "SELECCIONE UNA OPCIÓN"
                                ? ""
                                : _valueAlternSolucion!,
                        avanceFisicoAcumulado: double.parse(
                            _advanceFEP.text == "" ? "0" : _advanceFEP.text),
                        avanceFisicoPartida: double.parse(
                            _advanceFEP.text == "" ? "0" : _advanceFEP.text),
                        estadoAvance: _statusAdvance!.toUpperCase() ==
                                "SELECCIONE UNA OPCIÓN"
                            ? ""
                            : _statusAdvance!,
                        estadoMonitoreo: _statusMonitor!.toUpperCase() ==
                                "SELECCIONE UNA OPCIÓN"
                            ? ""
                            : _statusMonitor!,
                        fechaMonitoreo: _dateMonitor.text,
                        idMonitoreo: _idMonitor.text,
                        idUsuario: oUser.codigo,
                        imgActividad: imgPE,
                        imgProblema: imgPI,
                        imgRiesgo: imgRI,
                        observaciones: _obsMonitor.text,
                        problemaIdentificado: _valueProblemaIO!.toUpperCase() ==
                                "SELECCIONE UNA OPCIÓN"
                            ? ""
                            : _valueProblemaIO!,
                        riesgoIdentificado: _valueRiesgo!.toUpperCase() ==
                                "SELECCIONE UNA OPCIÓN"
                            ? ""
                            : _valueRiesgo!,
                        nivelRiesgo: _valueNivelRiesgo!.toUpperCase() ==
                                "SELECCIONE UNA OPCIÓN"
                            ? ""
                            : _valueNivelRiesgo!,
                        rol: oUser.rol,
                        usuario: oUser.nombres,
                      ));
                      if (idM == 0) {
                        showSnackbar(
                          success: true,
                          text: 'Datos Guardados Correctamente',
                        );
                      } else {
                        showSnackbar(
                          success: true,
                          text: 'Datos Actualizados Correctamente',
                        );
                      }

                      idM = dataSave.id!;
                    } catch (ex) {
                      // ignore: use_build_context_synchronously
                      AnimatedSnackBar.rectangle(
                        'Error',
                        ex.toString(),
                        type: AnimatedSnackBarType.error,
                        brightness: Brightness.light,
                        mobileSnackBarPosition: MobileSnackBarPosition.top,
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
                    primary: const Color.fromARGB(255, 1, 173, 130),
                    onPrimary: Colors.white,
                    shadowColor: const Color.fromARGB(255, 53, 53, 53),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // _confirmDialog('SAVE');
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
                        TramaMonitoreoModel dataSave = await mainController
                            .saveMonitoreo(TramaMonitoreoModel(
                          id: idM,
                          isEdit: 1,
                          createdTime: DateTime.now(),
                          snip: widget.datoProyecto?.numSnip,
                          cui: widget.datoProyecto?.cui,
                          latitud: _latitud.text,
                          longitud: _longitud.text,
                          tambo: widget.datoProyecto?.tambo,
                          fechaTerminoEstimado: _dateObra.text,
                          actividadPartidaEjecutada:
                              _valuePartidaEje!.toUpperCase() ==
                                      "SELECCIONE UNA OPCIÓN"
                                  ? ""
                                  : _valuePartidaEje!,
                          alternativaSolucion:
                              _valueAlternSolucion!.toUpperCase() ==
                                      "SELECCIONE UNA OPCIÓN"
                                  ? ""
                                  : _valueAlternSolucion!,
                          avanceFisicoAcumulado: double.parse(
                              _advanceFEP.text == "" ? "0" : _advanceFEP.text),
                          avanceFisicoPartida: double.parse(
                              _advanceFEP.text == "" ? "0" : _advanceFEP.text),
                          estadoAvance: _statusAdvance!.toUpperCase() ==
                                  "SELECCIONE UNA OPCIÓN"
                              ? ""
                              : _statusAdvance!,
                          estadoMonitoreo: _statusMonitor!.toUpperCase() ==
                                  "SELECCIONE UNA OPCIÓN"
                              ? ""
                              : _statusMonitor!,
                          fechaMonitoreo: _dateMonitor.text,
                          idMonitoreo: _idMonitor.text,
                          idUsuario: oUser.codigo,
                          imgActividad: imgPE,
                          imgProblema: imgPI,
                          imgRiesgo: imgRI,
                          observaciones: _obsMonitor.text,
                          problemaIdentificado:
                              _valueProblemaIO!.toUpperCase() ==
                                      "SELECCIONE UNA OPCIÓN"
                                  ? ""
                                  : _valueProblemaIO!,
                          riesgoIdentificado: _valueRiesgo!.toUpperCase() ==
                                  "SELECCIONE UNA OPCIÓN"
                              ? ""
                              : _valueRiesgo!,
                          nivelRiesgo: _valueNivelRiesgo!.toUpperCase() ==
                                  "SELECCIONE UNA OPCIÓN"
                              ? ""
                              : _valueNivelRiesgo!,
                          rol: oUser.rol,
                          usuario: oUser.nombres,
                        ));
                        if (idM == 0) {
                          showSnackbar(
                            success: true,
                            text: 'Datos Guardados Correctamente',
                          );
                        } else {
                          showSnackbar(
                            success: true,
                            text: 'Datos Actualizados Correctamente',
                          );
                        }

                        idM = dataSave.id!;
                      } catch (ex) {
                        // ignore: use_build_context_synchronously
                        AnimatedSnackBar.rectangle(
                          'Error',
                          ex.toString(),
                          type: AnimatedSnackBarType.error,
                          brightness: Brightness.light,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
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
            ),
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
                  child: const Text(
                    "Lista de Imagenes",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
              body: Container(
                padding: const EdgeInsets.all(5),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    MyImageMultiple(
                        controller: controller, nameField: fieldNameImage),
                  ],
                ),
              ),
              isExpanded: expanded[0],
            ),
          ]),
    ]);
  }

  DropdownButtonFormField<String> myDropdownButtonFormField(String valueId,
      List<String> items, bool? isDense, textLabel, bool isvalidad) {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: textLabel),
      isExpanded: true,
      isDense: isDense!,
      value: valueId,
      validator: (value) => value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
          ? isvalidad
              ? 'Requerido *'
              : null
          : null,
      items:
          items.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
      onChanged: (val) {
        setState(() {
          valueId = val!;
        });
      },
    );
  }

  Future<void> _confirmDialog(String sAction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('W'.tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
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
}
