import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:get/get.dart';

const options = ['BAJO', 'MEDIO', 'ALTO'];

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);
  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final _formKey = GlobalKey<FormState>();

  final _CODIGO_SNIP = TextEditingController(text: "286453");
  final _CUI = TextEditingController(text: "2191033");
  final _LONG = TextEditingController(text: "-71.969002");
  final _LAT = TextEditingController(text: "-14.903419");
  final _DEPARTAMENTO = TextEditingController(text: "AREQUIPA");
  final _PROVINCIA = TextEditingController(text: "CASTILLA");
  final _TAMBO = TextEditingController(text: "CHICOTAÑA");
  final _CENTRO = TextEditingController(text: "CHICOTANA");
  final _POBLADO = TextEditingController(text: "CIP_74190");
  final _COD_RESIDENTE = TextEditingController(text: "RENE RICARDO GONZALES");
  final _RESIDENTE = TextEditingController(text: "QUISPE");
  final _COD_SUPERVISOR = TextEditingController(text: "CIP_62352");
  final _SUPERVISOR = TextEditingController(text: "JUAN VENTURA CASTILLA");
  final _COD_CRP = TextEditingController(text: "CIP 92822");

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
            controller: _CODIGO_SNIP,
            decoration: const InputDecoration(labelText: 'CODIGO SNIP'),
            validator: (v) => v!.isEmpty ? 'Required'.tr : null,
            enabled: false,
          ),
          TextFormField(
              controller: _CUI,
              decoration: const InputDecoration(labelText: 'CUI'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _LONG,
              decoration: const InputDecoration(labelText: 'LONG'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _LAT,
              decoration: const InputDecoration(labelText: 'LAT'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _DEPARTAMENTO,
              decoration: const InputDecoration(labelText: 'DEPARTAMENTO'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _PROVINCIA,
              decoration: const InputDecoration(labelText: 'PROVINCIA'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _TAMBO,
              decoration: const InputDecoration(labelText: 'TAMBO'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _CENTRO,
              decoration: const InputDecoration(labelText: 'CENTRO'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _POBLADO,
              decoration: const InputDecoration(labelText: 'POBLADO'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _COD_RESIDENTE,
              decoration: const InputDecoration(labelText: 'COD RESIDENTE'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _RESIDENTE,
              decoration: const InputDecoration(labelText: 'RESIDENTE'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _COD_SUPERVISOR,
              decoration: const InputDecoration(labelText: 'COD SUPERVISOR'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _SUPERVISOR,
              decoration: const InputDecoration(labelText: 'SUPERVISOR'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          TextFormField(
              controller: _COD_CRP,
              decoration: const InputDecoration(labelText: 'COD CRP'),
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              enabled: false),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}
