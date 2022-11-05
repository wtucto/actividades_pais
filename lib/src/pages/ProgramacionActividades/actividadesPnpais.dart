import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/util/busy-indicator.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ActividadesPnpais extends StatefulWidget {
  const ActividadesPnpais({super.key});

  @override
  State<ActividadesPnpais> createState() => _ActividadesPnpaisState();
}

class _ActividadesPnpaisState extends State<ActividadesPnpais> {
  MainController controller = MainController();
  final _formKey = GlobalKey<FormState>();
  final _dateFecha = TextEditingController();
  final _timeInicio = TextEditingController();
  final _timeFinal = TextEditingController();
  final _descripcion = TextEditingController();

  static final _itemTipoActividad = [
    "Seleccionar Opción",
    "Revisión de Intervenciones (INTRANET)",
    "Reunión mensual",
    "Asistencia a reuniones PN PAIS",
    "Elaboracion de informes",
    "Induccion/capacitacion",
    "Asistencia tecnica",
    "Atencion a publico y autoridades",
    "Entrevista CAS",
    "Asistencia a espacios de articulación",
    "Actividades con enlace MIDIS",
    "Auditorias",
    "Recepción de tambos",
    "Asistencia técnica a caravanas",
  ];
  String? _valueTipoActidad = _itemTipoActividad[0];

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
            "ACTIVIDADES PNPAIS",
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
                Icons.menu_open,
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
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
          children: [
            TextFormField(
              controller: _dateFecha,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  labelText: 'Fecha de Actividades PNPAIS'),
              enabled: true,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  print(formattedDate);

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
             * Tipo Actividad
             */
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: "Tipo Actividad"),
              value: _valueTipoActidad,
              onChanged: (String? value) {
                setState(() {
                  _valueTipoActidad = value!;
                });
              },
              items: _itemTipoActividad
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
             * Descripcion
             */
            TextFormField(
              controller: _descripcion,
              decoration: const InputDecoration(
                labelText: 'Descripción',
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
                                .sprogActividadActividadPnpais;
                        oProg.fecha = _dateFecha.text;
                        oProg.horaInicio = _timeInicio.text;
                        oProg.horaFin = _timeFinal.text;
                        oProg.tipoActividad = _valueTipoActidad;
                        oProg.descripcionActividad = _descripcion.text;
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
