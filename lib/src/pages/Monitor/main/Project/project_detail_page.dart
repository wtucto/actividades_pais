import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:get/get.dart';

const options = ['BAJO', 'MEDIO', 'ALTO'];

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({Key? key, required this.datoProyecto})
      : super(key: key);

  final TramaProyectoModel datoProyecto;

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late TramaProyectoModel _oProject;

  late final _numSnip;
  late final _cui;
  late final _latitud;
  late final _longitud;
  late final _departamento;
  late final _provincia;
  late final _distrito;
  late final _tambo;
  late final _centroPoblado;
  late final _estado;
  late final _subEstado;
  late final _estadoSaneamiento;
  late final _modalidad;
  late final _fechaInicio;
  late final _fechaTerminoEstimado;
  late final _inversion;
  late final _costoEjecutado;
  late final _costoEstimadoFinal;
  late final _avanceFisico;
  late final _residente;
  late final _supervisor;
  late final _crp;
  late final _codResidente;
  late final _codSupervisor;
  late final _codCrp;

  @override
  void initState() {
    _oProject = widget.datoProyecto;
    _numSnip = TextEditingController(text: _oProject.numSnip);
    _cui = TextEditingController(text: _oProject.cui);
    _latitud = TextEditingController(text: _oProject.latitud);
    _longitud = TextEditingController(text: _oProject.longitud);
    _departamento = TextEditingController(text: _oProject.departamento);
    _provincia = TextEditingController(text: _oProject.provincia);
    _distrito = TextEditingController(text: _oProject.distrito);
    _tambo = TextEditingController(text: _oProject.tambo);
    _centroPoblado = TextEditingController(text: _oProject.centroPoblado);
    _estado = TextEditingController(text: _oProject.estado);
    _subEstado = TextEditingController(text: _oProject.subEstado);
    _estadoSaneamiento =
        TextEditingController(text: _oProject.estadoSaneamiento);
    _modalidad = TextEditingController(text: _oProject.modalidad);
    _fechaInicio = TextEditingController(text: _oProject.fechaInicio);
    _fechaTerminoEstimado =
        TextEditingController(text: _oProject.fechaTerminoEstimado);
    _inversion = TextEditingController(text: _oProject.inversion);
    _costoEjecutado = TextEditingController(text: _oProject.costoEjecutado);
    _costoEstimadoFinal =
        TextEditingController(text: _oProject.costoEstimadoFinal);
    _avanceFisico = TextEditingController(text: _oProject.avanceFisico);
    _residente = TextEditingController(text: _oProject.residente);
    _supervisor = TextEditingController(text: _oProject.supervisor);
    _crp = TextEditingController(text: _oProject.crp);
    _codResidente = TextEditingController(text: _oProject.codResidente);
    _codSupervisor = TextEditingController(text: _oProject.codSupervisor);
    _codCrp = TextEditingController(text: _oProject.codCrp);

    //_POBLADO = TextEditingController(text: _oProject.numSnip);

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final _questionCtrl = TextEditingController();
  final _questionCtrl2 = TextEditingController();
  final _dateinput = TextEditingController();
  final _optionCtrls = options.map((o) => TextEditingController()).toList();
  final _question = {'value': '', 'correct': options[0], 'options': options};

  void showSnackbar({required bool success, required String text}) {
    AnimatedSnackBar.rectangle(
      "Info!",
      text,
      type:
          success ? AnimatedSnackBarType.success : AnimatedSnackBarType.warning,
      brightness: Brightness.light,
      mobileSnackBarPosition: MobileSnackBarPosition.top,
    ).show(context);
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    for (var ctrl in _optionCtrls) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 124, 205),
        elevation: 0,
        leadingWidth: 20,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(
                  Icons.monitor,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          )
        ],
        title: Container(
          height: 45,
          //width: width / 1.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Center(
            child: Text(
              'ProjectDetailTitle'.tr,
              style: const TextStyle(
                color: const Color(0xfffefefe),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(padding: const EdgeInsets.all(32), children: [
          TextFormField(
            controller: _cui,

            ///CÓDIGO ÚNICO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect001'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _numSnip,

            ///CÓDIGO DE SNIP
            decoration: InputDecoration(labelText: 'FldProyect002'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _latitud,

            ///LATITUD DE LA UBICACIÓN DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect003'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _longitud,

            ///LONGITUD DE LA UBICACIÓN DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect004'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _departamento,

            ///NOMBRE DEL DEPARTAMENTO DEL UBIGEO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect005'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _provincia,

            ///NOMBRE DE LA PROVINCIA DEL UBIGEO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect006'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _distrito,

            ///NOMBRE DEL DISTRITO DEL UBIGEO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect007'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _tambo,

            ///NOMBRE DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect008'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _centroPoblado,

            ///NOMBRE DEL CENTRO POBLADO DEL UBIGEO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect009'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _estado,

            ///ESTADO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect010'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _subEstado,

            ///SUB ESTADO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect011'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _estadoSaneamiento,

            ///ESTADO DE SANEAMIENTO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect012'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _modalidad,

            ///MODALIDAD DE CONTRATACIÓN DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect013'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _fechaInicio,

            ///FECHA DE INICIO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect014'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _fechaTerminoEstimado,

            ///FECHA DE TÉRMINO ESTIMADO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect015'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _inversion,

            ///MONTO DE INVERSIÓN DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect016'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _costoEjecutado,

            ///COSTO EJECUTADO ACUMULADO DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect017'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _costoEstimadoFinal,

            ///COSTO ESTIMADO FINAL DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect018'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _avanceFisico,

            ///% AVANCE FÍSICO ACUMULADO
            decoration: InputDecoration(labelText: 'FldProyect019'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _residente,

            ///NOMBRE DEL RESIDENTE
            decoration: InputDecoration(labelText: 'FldProyect020'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _supervisor,

            ///NOMBRE DEL SUPERVISOR
            decoration: InputDecoration(labelText: 'FldProyect021'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _crp,

            ///NOMBRE DEL COORDINADOR REGIONAL DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect022'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _codResidente,

            ///CÓDIGO DEL RESIDENTE
            decoration: InputDecoration(labelText: 'FldProyect023'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _codSupervisor,

            ///CÓDIGO DEL SUPERVISOR
            decoration: InputDecoration(labelText: 'FldProyect024'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
            controller: _codCrp,

            ///CÓDIGO DEL COORDINADOR REGIONAL DEL PROYECTO
            decoration: InputDecoration(labelText: 'FldProyect025'.tr),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}
