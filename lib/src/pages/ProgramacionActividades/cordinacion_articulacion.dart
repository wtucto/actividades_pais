import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CordinacionArticulacion extends StatefulWidget {
  const CordinacionArticulacion({super.key});

  @override
  State<CordinacionArticulacion> createState() =>
      _CordinacionArticulacionState();
}

class _CordinacionArticulacionState extends State<CordinacionArticulacion> {
  MainController controller = MainController();
  final _formKey = GlobalKey<FormState>();
  final _dateFecha = TextEditingController();
  final _timeInicio = TextEditingController();
  final _timeFinal = TextEditingController();
  final _descripcionEvento = TextEditingController();
  final _evento = TextEditingController();

  static final _itemAccion = [
    "SELECCIONE UNA OPCIÓN",
    "Coordinación con entidades",
    "Articulación - Plan de trabajo",
  ];
  static final _itemTipoUsuario = [
    "SELECCIONE UNA OPCIÓN",
    "GOBIERNO CENTRAL",
    "GOBIERNO REGIONAL",
    "GOBIERNO LOCAL",
    "ORGANISMOS AUTONOMOS",
    "COOPERACION INTERNACIONAL",
    "ONG",
    "ORGANIZACIONES CIVILES",
    "ORGANIZACIONES RELIGIOSAS",
    "SECTOR PRIVADO",
    "UNIVERSIDADES",
    "IAL",
    "IAR"
  ];
  static final _itemSector = [
    "SELECCIONE UNA OPCIÓN",
    "MEF",
    "MIDIS",
    "MIMP",
    "MIDAGRI"
  ];
  static final _itemPrograma = [
    "SELECCIONE UNA OPCIÓN",
    "PROINVERSION-AGENCIA DE PROMOCION DE LA INVERSION PRIVADA",
    "PROCOMPITE",
    "SUPERINTENDENCIA NACIONAL DE ADUANAS Y DE ADMINISTRACION TRIBUTARIA",
    "ORGANISMO SUPERVISOR DE LAS CONTRATACIONES DEL ESTADO"
  ];
  static final _itemDocAcredita = [
    "SELECCIONE UNA OPCIÓN",
    "ACTA",
    "INFORME",
    "HOJA DE RUTA",
    "PROGRAMACION INTERINSTITUCIONAL",
    "PLAN DE TRABAJO",
    "DOCUMENTO EXTERNO",
    "POR CONFIRMAR"
  ];
  static final _itemArOri = [
    "SELECCIONE UNA OPCIÓN",
    "LUCHA CONTRA LA ANEMIA Y DCI",
    "PROGRAMACION DE CARAVANA",
    "EJECUCIÓN DE INTERVENCION MULTISECTORIAL",
    "PLAN MULTISECTORIAL ANTE HELADAS Y FRIAJE",
    "INTERVENCIÓN EN PLATAFORMA DE SERVICIOS",
    "ELABORACIÓN DE PLAN TRABAJO",
    "FIRMA DE CONVENIO",
    "MESA REGIONAL",
    "GESTIÓN DEL RIESGO DE DESASTRES",
    "ASISTENCIA TÉCNICA IAR / ESPACIOS DE ARTICULACIÓN REGIONAL",
    "PLANES DE TRABAJO REGIONAL - AGENDA HAMBRE 0",
    "ASISTENCIA TÉCNICA PLAN DE TRABAJO EN TEMAS PRODUCTIVOS – IAR- HAMBRE 0"
  ];

  String? _valueAccion = _itemAccion[0];
  String? _valueTipoUsuario = _itemTipoUsuario[0];
  String? _valueSector = _itemSector[0];
  String? _valuePrograma = _itemPrograma[0];
  String? _valueAcredita = _itemDocAcredita[0];
  String? _valueArOri = _itemArOri[0];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "COOR Y ARTICULACIÓN",
            style: TextStyle(
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
                Icons.integration_instructions_outlined,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(
              left: 32.0, right: 32.0, top: 15.0, bottom: 20.0),
          children: [
            TextFormField(
              controller: _dateFecha,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  labelText: 'Fecha de Cordinación y Articulación'),
              enabled: true,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    _dateFecha.text = formattedDate;
                  });
                }
              },
            ),
            /**
             * Hora de Inicio
             */
            TextFormField(
              controller: _timeInicio,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(labelText: "Hora Inicio"),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  String formattedTime =
                      DateFormat('HH:mm:ss').format(parsedTime);
                  setState(() {
                    _timeInicio.text = formattedTime;
                  });
                }
              },
            ),
            /**
             * Hora Final
             */
            TextFormField(
              controller: _timeFinal,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(labelText: "Hora Final"),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  String formattedTime =
                      DateFormat('HH:mm:ss').format(parsedTime);
                  setState(() {
                    _timeFinal.text = formattedTime;
                  });
                }
              },
            ),
            /**
             * Accion
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Accion"),
              isExpanded: true,
              isDense: false,
              value: _valueAccion,
              validator: (value) =>
                  value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
                      ? 'Requerido *'
                      : null,
              onChanged: (String? value) {
                setState(() {
                  _valueAccion = value!;
                });
              },
              items: _itemAccion.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            /**
             * Tipo Usuario
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Tipo Usuario"),
              isExpanded: true,
              isDense: false,
              value: _valueTipoUsuario,
              validator: (value) =>
                  value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
                      ? 'Requerido *'
                      : null,
              onChanged: (String? value) {
                setState(() {
                  _valueTipoUsuario = value!;
                });
              },
              items: _itemTipoUsuario
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            /**
             * Sector
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Sector"),
              isExpanded: true,
              isDense: false,
              value: _valueSector,
              validator: (value) =>
                  value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
                      ? 'Requerido *'
                      : null,
              onChanged: (String? value) {
                setState(() {
                  _valueSector = value!;
                });
              },
              items: _itemSector.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            /**
             * Programa
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Programa"),
              isExpanded: true,
              isDense: false,
              value: _valuePrograma,
              validator: (value) =>
                  value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
                      ? 'Requerido *'
                      : null,
              onChanged: (String? value) {
                setState(() {
                  _valuePrograma = value!;
                });
              },
              items:
                  _itemPrograma.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            /**
             * Documento que Acredita el Evento
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: "Documento que Acredita el Evento"),
              isExpanded: true,
              isDense: false,
              value: _valueAcredita,
              validator: (value) =>
                  value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
                      ? 'Requerido *'
                      : null,
              onChanged: (String? value) {
                setState(() {
                  _valueAcredita = value!;
                });
              },
              items: _itemDocAcredita
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            /**
             * ¿Dónde se Realizó el Evento?
             */
            TextFormField(
              controller: _evento,
              decoration: const InputDecoration(
                labelText: '¿Dónde se Realizó el Evento?',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: true,
            ),
            /**
             * Articulación Orientada A.
             */
            DropdownButtonFormField(
              decoration:
                  const InputDecoration(labelText: "Articulación Orientada A."),
              isExpanded: true,
              isDense: false,
              value: _valueArOri,
              validator: (value) =>
                  value!.toUpperCase() == "SELECCIONE UNA OPCIÓN"
                      ? 'Requerido *'
                      : null,
              onChanged: (String? value) {
                setState(() {
                  _valueArOri = value!;
                });
              },
              items: _itemArOri.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
            /**
             * Descripcion del Evento
             */
            TextFormField(
              controller: _descripcionEvento,
              decoration: const InputDecoration(
                labelText: 'Descripción del Evento',
              ),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: true,
            ),
            /**
             * Bonones De Control
             */
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        BusyIndicator.show(context);
                        ProgramacionActividadModel oProg =
                            ProgramacionActividadModel.empty();
                        oProg.programacionActividades =
                            ProgramacionActividadModel
                                .sprogActividadCordArticulacion;
                        oProg.fecha = _dateFecha.text;
                        oProg.horaInicio = _timeInicio.text;
                        oProg.horaFin = _timeFinal.text;
                        oProg.accion = _valueAccion;
                        oProg.tipoUsuario = _valueTipoUsuario;
                        oProg.sector = _valueSector;
                        oProg.programa = _valuePrograma;
                        oProg.documentoQueAcreditaElEvento = _valueAcredita;
                        oProg.dondeSeRealizoElEvento = _evento.text;
                        oProg.articulacionOrientadaA = _valueArOri;
                        oProg.descripcionDelEvento = _evento.text;
                        ProgramacionActividadModel response =
                            await controller.saveProgramaIntervencion(oProg);
                        BusyIndicator.hide(context);
                        showSnackbar(
                          success: true,
                          text: 'Datos Enviados Correctamente',
                        );
                        _formKey.currentState?.reset();
                      } catch (ex) {
                        BusyIndicator.hide(context);
                        AnimatedSnackBar.rectangle(
                          'Error',
                          ex.toString(),
                          type: AnimatedSnackBarType.error,
                          brightness: Brightness.light,
                          mobileSnackBarPosition: MobileSnackBarPosition.top,
                        ).show(context);
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: width / 3.5,
                    child: const Center(
                      child: Text(
                        'Guardar',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 237, 82, 68),
                    onPrimary: Colors.white,
                    shadowColor: const Color.fromARGB(255, 53, 53, 53),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 50,
                    width: width / 3.5,
                    child: const Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
