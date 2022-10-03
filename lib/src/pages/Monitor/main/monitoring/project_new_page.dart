import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:actividades_pais/app_properties.dart';

const options = ['BAJO', 'MEDIO', 'ALTO'];

class ProjectNewPage extends StatefulWidget {
  const ProjectNewPage({Key? key}) : super(key: key);
  @override
  _ProjectNewPageState createState() => _ProjectNewPageState();
}

class _ProjectNewPageState extends State<ProjectNewPage> {
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
    /*
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //margin: EdgeInsets.all(50),
        padding: EdgeInsets.all(10),
        duration: Duration(milliseconds: 1200),
        //backgroundColor: Colors.grey[100],
        //shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Row(children: [
          Icon(
            success ? Icons.gpp_good : Icons.error,
            color: success ? Colors.greenAccent : Colors.redAccent,
          ),
          const SizedBox(width: 8),
          Text(
            textAlign: TextAlign.center,
            text,
          ),
        ]),
        action: SnackBarAction(
          label: 'Cerrar',
          disabledTextColor: Colors.white,
          textColor: Color.fromARGB(255, 255, 0, 0),
          onPressed: () {
            //Do whatever you want
          },
        ),
      ),
    );
    */
  }

  @override
  void dispose() {
    _questionCtrl.dispose();
    for (var ctrl in _optionCtrls) {
      ctrl.dispose();
    }
    super.dispose();
  }

  String dropdownvalue = 'Reinicio';
  var items = [
    'Reinicio',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];

  String dropdownvalueRiesgo = 'Bajo';
  var itemsRiesgo = ['Bajo', 'Medio', 'Alto'];

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
              "Monitoreo",
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
          /**
           * ID MONITOREO
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(labelText: 'Id Monitoreo *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * ESTADO MONITOREO
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(labelText: 'Estado Monitoreo *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * FECHA MONITOREO
           */
          TextFormField(
            controller: _dateinput,
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
            decoration: InputDecoration(
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
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  _dateinput.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          /**
           * % AVANCE FISICO ESTIMADO ACUMULADO
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(
              labelText: '% Avance Fisico Estimado Acumulado *',
            ),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * % ESTADO DE AVANCE
           */
          const SizedBox(height: 32),
          Text("Estado de Avance *"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width / 1.209,
                margin: EdgeInsets.only(top: 2, bottom: 2),
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    //isDense: true,
                    isExpanded: true,
                    value: dropdownvalue,
                    dropdownColor: Color.fromARGB(255, 255, 255, 255),
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select Data",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          /**
           * % AVANCE FISICO ACUMULADO PARTIDA
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(
                labelText: '% Avance Fisico Acumulado Partida *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * PARTIDA EJECUTADA
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(labelText: 'Partida Ejecutada *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),

          /**
           * OBSERVACIONES
           */
          TextFormField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 4,
            maxLines: 5,
            controller: _questionCtrl2,
            decoration: const InputDecoration(labelText: 'Observaciones *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * PROBLEMA IDENTIFICADO EN LA OBRA
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(
                labelText: 'Problema Indentificado en la Obra *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * ALTERNATIVA DE SOLUCION
           */
          TextFormField(
            controller: _questionCtrl,
            decoration:
                const InputDecoration(labelText: 'Alternativa de Solución *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * SELECCIONES EL RIESGO
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(labelText: 'Riesgo *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * NIVEL DE RIESGO
           */
          const SizedBox(height: 32),
          Text("Nivel de Riesgo *"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width / 1.209,
                margin: EdgeInsets.only(top: 2, bottom: 2),
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    //isDense: true,
                    isExpanded: true,
                    value: dropdownvalueRiesgo,
                    dropdownColor: Color.fromARGB(255, 255, 255, 255),
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select Data",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    items: itemsRiesgo
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalueRiesgo = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          /**
           * FECHA TERMINO OBRA
           */
          TextFormField(
            controller: _dateinput,
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
            decoration: InputDecoration(
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
                  _dateinput.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          /**
           * LOGITUD
           */

          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(labelText: 'Longitud *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * LATITUD
           */
          TextFormField(
            controller: _questionCtrl,
            decoration: const InputDecoration(labelText: 'Latitud *'),
            validator: (v) => v!.isEmpty ? 'Requerido (*)' : null,
          ),
          /**
           * OTROS
        
                  
          const SizedBox(height: 32),
          ...options
              .asMap()
              .entries
              .map((entry) => [
                    TextFormField(
                      controller: _optionCtrls[entry.key],
                      decoration:
                          InputDecoration(labelText: 'Option ${entry.value}*'),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      validator: (v) => v!.isEmpty
                          ? 'Please fill in Option ${entry.value}'
                          : null,
                    ),
                    const SizedBox(height: 32),
                  ])
              .expand((w) => w),
              */
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 12, 124, 205),
                  onPrimary: Colors.white,
                  shadowColor: Color.fromARGB(255, 53, 53, 53),
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

                    showSnackbar(
                      success: true,
                      text: 'Formulario correcto.',
                    );
                  } else {
                    showSnackbar(
                      success: false,
                      text: 'Campos requeridos (*).',
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: width / 3.5,
                  child: Center(
                    child: Text(
                      "Grabar",
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 1, 173, 130),
                  onPrimary: Colors.white,
                  shadowColor: Color.fromARGB(255, 53, 53, 53),
                  elevation: 5,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _question['value'] = _questionCtrl.text;
                    _question['options'] = _optionCtrls.asMap().entries.map(
                      (entry) {
                        _confirmDialog("SAVE");
                        return {
                          'index': options[entry.key],
                          'value': entry.value.text
                        };
                      },
                    );

                    showSnackbar(
                      success: true,
                      text: 'Formulario correcto.',
                    );
                  } else {
                    showSnackbar(
                      success: false,
                      text: 'Campos requeridos (*).',
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: width / 3.5,
                  child: Center(
                    child: Text(
                      "Enviar",
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
              )
            ],
          ),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }

  Future<void> _confirmDialog(String sAction) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de realizar la operación?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Si'),
              onPressed: () {
                if (sAction == 'SAVE') {}
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            TextButton(
              child: const Text('No'),
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
