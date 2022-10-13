import 'dart:io';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Monitor/gallery/gallery_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/src/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:get/get.dart';

final options = TramaMonitoreoModel.aNivelRiesgo;

class MonitoringDetailNewEditPage extends StatefulWidget {
  TramaProyectoModel? datoProyecto;
  // TramaProyectoModel datoProyecto;
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
    _vauluePartidaEje = _itemsPartidaEje[0];
    _valueProblemaIO = _itemProblemaIO[0];
    _valueAlternSolucion = _itemAlternSolucion[0];
    _valueRiesgo = _itemRiesgo[0];
    _valueNivelRiesgo = _itemNivelRiesgo[0];
  }
  String fechaMonitoreo = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? _statusAdvance;
  String? _valueRiesgo;
  String? _statusMonitor;
  String? _vauluePartidaEje;
  String? _valueProblemaIO;
  String? _valueAlternSolucion;
  String? _valueNivelRiesgo;
  final _formKey = GlobalKey<FormState>();
  final _idMonitor = TextEditingController();
  final _dateMonitor = TextEditingController();
  final _advanceFEA = TextEditingController();
  final _itemStatusAdvance = [
    'Seleccionar',
    'Ejecución',
    'Reinicio',
    'Paralizado',
    'Por iniciar'
  ];
  final _itemsPartidaEje = [
    'Seleccionar',
    'Cimentación',
    'Muros y Columnas',
    'Techo y Acabados',
    'Obras Exteriores',
    'Equipamiento'
  ];
  final _itemProblemaIO = [
    'Seleccionar',
    'Calculo inexacto en duración de las tareas',
    'Retraso en plazos establecidos en proyecto',
    'Estimación inexacta de los costos',
    'Núcleo ejecutor no rinde gastos',
    'Limitados recursos y sobre utilizados',
    'Terreno con problemas de saneamiento legal'
  ];
  final _itemAlternSolucion = [
    'Seleccionar',
    'Solicitar modificación de Exp. Técnico',
    'Gestionar reunión de coordinación con UPS',
    'Modificar programación de tareas (Fast track)',
    'Modificar programación de tareas (Crashing)',
    'Coordinación con el núcleo ejecutor',
    'Gestionar recursos adicionales',
    'Coordinar reunión con asesoría legal',
    'Incrementar presupuesto para saneamiento legal'
  ];
  final _itemRiesgo = [
    'Seleccionar',
    'Incumplimiento de las características de los componentes',
    'Lluvias / deslizamientos / Clima',
    'Asignación de recursos y fondos fuera plazo',
    'Inadecuada estimación de costos',
    'Inadecuada programación',
    'Inadecuada comunicación con UPS'
  ];
  final _advanceFEP = TextEditingController();
  final _obsMonitor = TextEditingController();
  final _dateObra = TextEditingController();
  final _longitud = TextEditingController();
  final _latitud = TextEditingController();
  final _questionCtrl = TextEditingController();
  final _itemStatusMonitor = [
    'Seleccionar',
    'Monitoreo incompleto',
    'Monitoreo por Enviar',
    'Enviado'
  ];
  final _itemNivelRiesgo = [
    'Seleccionar',
    'Muy Bajo',
    'Bajo',
    'Medio',
    'Medio Alto',
    'Alto',
    'Muy Alto.'
  ];
  final _optionCtrls = options.map((o) => TextEditingController()).toList();
  final _question = {'value': '', 'correct': options[0], 'options': options};
  final MainController mainController = MainController();
  ImageController controller = ImageController();
  String _imgPartidaEjecutada = '_imgPartidaEjecutada';

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

  // @override
  // void dispose() {
  //   _questionCtrl.dispose();
  //   for (var ctrl in _optionCtrls) {
  //     ctrl.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    _idMonitor.text = "${widget.datoProyecto?.cui}_$fechaMonitoreo";
    _dateMonitor.text = fechaMonitoreo;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Monitoring'.tr.toUpperCase(),
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
          padding: const EdgeInsets.all(32),
          children: [
            /**
           * ID MONITOREO
           */
            TextFormField(
              controller: _idMonitor,
              decoration: const InputDecoration(labelText: 'Id Monitoreo *'),
              // validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * ESTADO MONITOREO
           */
            const SizedBox(height: 20),
            const Text('Estado Monitoreo *'),
            myDropdownButtonFormField(
                _statusMonitor!, _itemStatusMonitor, true),

            /**
           * FECHA MONITOREO
           */
            TextFormField(
              controller: _dateMonitor,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false,
              decoration: const InputDecoration(
                  //icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: 'Fecha Monitoreo *' //label text of field
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
              decoration: const InputDecoration(
                labelText: '% Avance Fisico Estimado Acumulado *',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * % ESTADO DE AVANCE
           */
            const SizedBox(height: 20),
            const Text('Estado de Avance *'),
            myDropdownButtonFormField(
                _statusAdvance!, _itemStatusAdvance, true),
            /**
           * PARTIDA EJECUTADA
           */
            const SizedBox(height: 20),
            const Text('Partida Ejecutada *'),
            myDropdownButtonFormField(
                _vauluePartidaEje!, _itemsPartidaEje, true),
            /**
           * % AVANCE FISICO ACUMULADO PARTIDA
           */
            TextFormField(
              controller: _advanceFEP,
              decoration: const InputDecoration(
                  labelText: '% Avance Fisico Acumulado Partida *'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * % FOTOS DE LA PARTIDA EJECUTADA (OBLIGATORIO)
           */
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: OutlinedButton.icon(
                    label: const Text('Fotos de la Partida Ejecutada'),
                    icon: const Icon(Icons.image),
                    onPressed: () async {
                      controller.selectMultipleImage(_imgPartidaEjecutada);
                    },
                  ),
                ),
              ],
            ),

            /**
           * OBSERVACIONES
           */
            TextFormField(
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: _obsMonitor,
              decoration: const InputDecoration(labelText: 'Observaciones *'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            ),
            /**
           * PROBLEMA IDENTIFICADO EN LA OBRA
           */
            const SizedBox(height: 20),
            const Text('Problema Indentificado en la Obra *'),
            myDropdownButtonFormField(
                _valueProblemaIO!, _itemProblemaIO, false),
            /**
           * ALTERNATIVA DE SOLUCION
           */
            const SizedBox(height: 20),
            const Text('Alternativa de Solución *'),
            myDropdownButtonFormField(
                _valueAlternSolucion!, _itemAlternSolucion, false),
            /**
           * SELECCIONES EL RIESGO
           */
            const SizedBox(height: 20),
            const Text('Riesgo Identificado'),
            myDropdownButtonFormField(_valueRiesgo!, _itemRiesgo, false),
            /**
           * NIVEL DE RIESGO
           */
            const SizedBox(height: 20),
            const Text('Nivel de Riesgo *'),
            myDropdownButtonFormField(
                _valueNivelRiesgo!, _itemNivelRiesgo, true),

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
                    if (_formKey.currentState!.validate()) {
                      // _question['value'] = _questionCtrl.text;
                      // _question['options'] = _optionCtrls.asMap().entries.map(
                      //   (entry) {
                      //     return {
                      //       'index': options[entry.key],
                      //       'value': entry.value.text
                      //     };
                      //   },
                      // );
                      await mainController.saveMonitoreo(TramaMonitoreoModel(
                        id: 0,
                        isEdit: 1,
                        createdTime: DateTime.now(),
                        snip: "",
                        cui: "",
                        latitud: _latitud.text,
                        longitud: _longitud.text,
                        tambo: "",
                        fechaTerminoEstimado: "",
                        actividadPartidaEjecutada: "",
                        alternativaSolucion: "",
                        // avanceFisicoAcumulado: "",
                        // avanceFisicoPartida: "",
                        estadoAvance: _statusAdvance!,
                        estadoMonitoreo: _statusMonitor!,
                        fechaMonitoreo: _dateMonitor.text,
                        idMonitoreo: _idMonitor.text,
                        idUsuario: "",
                        imgActividad: "",
                        imgProblema: "",
                        imgRiesgo: "",
                        observaciones: _obsMonitor.text,
                        problemaIdentificado: _valueProblemaIO!,
                        riesgoIdentificado: _valueRiesgo!,
                        nivelRiesgo: "",
                        rol: "",
                        usuario: "",
                      ));

                      // List<TramaMonitoreoModel> aMonitoreo =
                      //     await mainController.getAllMonitor(0, 0);

                      showSnackbar(
                        success: true,
                        text: 'FormIsComplete'.tr,
                      );
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _question['value'] = _questionCtrl.text;
                      _question['options'] = _optionCtrls.asMap().entries.map(
                        (entry) {
                          return {
                            'index': options[entry.key],
                            'value': entry.value.text
                          };
                        },
                      );
                      _confirmDialog('SAVE');
                      showSnackbar(
                        success: true,
                        text: 'FormIsComplete'.tr,
                      );
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
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Obx(
                    () {
                      return Expanded(
                        child: GridView.builder(
                          itemCount: controller.selectedFileCount.value,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemBuilder: ((context, index) {
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/loading_icon.gif'),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    image: FileImage(
                                      File(controller.listImagePath[index]),
                                    ),
                                  ),
                                  Positioned(
                                    top: -1,
                                    right: -1,
                                    child: Container(
                                      child: ClipOval(
                                        child: InkWell(
                                          onTap: () {
                                            controller.removeMultipleImage(
                                                controller.listImagePath[index],
                                                _imgPartidaEjecutada);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            color: Color.fromARGB(
                                                255, 221, 22, 22),
                                            child: const Icon(
                                                Icons.remove_circle,
                                                size: 20,
                                                color: Color.fromARGB(
                                                    255, 233, 224, 222)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> myDropdownButtonFormField(
      String valueId, List<String> items, bool? isDense) {
    return DropdownButtonFormField(
      isExpanded: true,
      isDense: isDense!,
      value: valueId,
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
