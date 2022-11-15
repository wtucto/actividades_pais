import 'package:actividades_pais/main.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Clases/InfoTelefono.dart';
import 'package:actividades_pais/src/datamodels/Formulario/FormularioReq.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ConfiguracionPersonal extends StatefulWidget {
  String unidad = '';

  ConfiguracionPersonal({
    this.unidad = '',
  });

  @override
  _ConfiguracionPersonal createState() => _ConfiguracionPersonal();
}

class _ConfiguracionPersonal extends State<ConfiguracionPersonal> {
  TextEditingController _controllerNDocumento = TextEditingController();
  TextEditingController _controllerApPaterno = TextEditingController();
  TextEditingController _controllerApMaterno = TextEditingController();
  TextEditingController _controllerNombres = TextEditingController();
  TextEditingController _controllerContrasenia = TextEditingController();
  TextEditingController _controllerfecha = TextEditingController();
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime? nowfec = new DateTime.now();
  Servicios servicios = new Servicios();
  var _isloading = false;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue[800],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("CONFIGURACION PERSONAL"),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  FormularioReq().textinputdet(
                      " NUMERO DNI",
                      _controllerNDocumento,
                      TextCapitalization.words,
                      TextInputType.number),
                  const SizedBox(height: 20.0),
                  FormularioReq().textinputdet(" NOMBRES", _controllerNombres,
                      TextCapitalization.words, TextInputType.text),
                  const SizedBox(height: 20.0),
                  FormularioReq().textinputdet(
                      " APELLIDO PATERNO",
                      _controllerApPaterno,
                      TextCapitalization.words,
                      TextInputType.text),
                  const SizedBox(height: 20.0),
                  FormularioReq().textinputdet(
                      " APELLIDO MATERNO",
                      _controllerApMaterno,
                      TextCapitalization.words,
                      TextInputType.text),
                  const SizedBox(height: 20.0),
                  Container(
                    decoration: servicios.myBoxDecoration(),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingrese dato.';
                        }
                      },
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: nowfec!,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );

                        if (picked != null) {
                          setState(() {
                            _controllerfecha.text
                                .replaceAll('', formatter.format(picked));
                            _controllerfecha.text = formatter.format(picked);
                          });
                        }
                      },
                      textAlign: TextAlign.justify,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      controller: _controllerfecha,
                      enabled: true,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          labelText: "Fecha Nacimiento"),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  FormularioReq().textinputdet(
                      " CONTRASEÑA",
                      _controllerContrasenia,
                      TextCapitalization.words,
                      TextInputType.text),
                  const SizedBox(height: 25.0),
                  Container(
                    decoration: servicios.myBoxDecoration(),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[800],
                        ),
                        child: _isloading
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Text(
                              'Registrando...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17, color: Colors.white),
                            )
                          ],
                        )
                            : const Text(
                          'Guardar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_controllerNombres.text == "" ||
                              _controllerApPaterno.text == "" ||
                              _controllerApMaterno.text == "" ||
                              _controllerNDocumento.text == "") {
                            Fluttertoast.showToast(
                                msg: "Ingresar Datos",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            if (_isloading) return;
                            setState(() {
                              _isloading = true;
                            });

                            var r = ConfigPersonal(
                                unidad: widget.unidad,
                                nombres: _controllerNombres.text,
                                apellidoMaterno: _controllerApMaterno.text,
                                apellidoPaterno: _controllerApPaterno.text,
                                contrasenia: _controllerContrasenia.text,
                                fechaNacimento: _controllerfecha.text,
                                numeroDni:
                                int.parse(_controllerNDocumento.text));

                            await DatabasePr.db.insertConfigPersonal(r);
                            await Future.delayed(const Duration(seconds: 2));

                            setState(() {
                              _isloading = false;
                            });
                            if (_isloading == false) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => LoadingScreen()));
                            }
                          }
                        }),
                  )
                ],
              )),
        ));
  }
}
