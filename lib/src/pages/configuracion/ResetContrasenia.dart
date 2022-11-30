import 'package:actividades_pais/main.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../datamodels/Formulario/FormularioReq.dart';
import 'package:intl/intl.dart';

class ResetContrasenia extends StatefulWidget {
  @override
  State<ResetContrasenia> createState() => _ResetContraseniaState();
}

class _ResetContraseniaState extends State<ResetContrasenia> {
  /// const ResetContrasenia({Key? key}) : super(key: key);
  TextEditingController _controllerNDocumento = TextEditingController();

  TextEditingController _controllerApPaterno = TextEditingController();

  TextEditingController _controllerApMaterno = TextEditingController();

  TextEditingController _controllerNombres = TextEditingController();

  TextEditingController _controllerContrasenia = TextEditingController();

  TextEditingController _controllerfecha = TextEditingController();
  Servicios servicios = new Servicios();
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime? nowfec = new DateTime.now();

  var _isloading = false;
  var _mostrar = true;
  var idUsuario;

  String nombresUsuario ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Olvido su contraseña", style: TextStyle(fontSize: 20),), centerTitle: true, backgroundColor: Colors.blue[800]),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                children: [
                  (_mostrar == true)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            FormularioReq().textinputdet(
                                "NUMERO DNI",
                                _controllerNDocumento,
                                TextCapitalization.words,
                                TextInputType.number, true),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                           //   decoration: servicios.myBoxDecoration(),
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
                                    firstDate: DateTime(1800, 8),
                                    lastDate: DateTime(2101),
                                  );

                                  if (picked != null) {
                                    setState(() {
                                      _controllerfecha.text.replaceAll(
                                          '', formatter.format(picked));
                                      _controllerfecha.text =
                                          formatter.format(picked);
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
                                      borderSide:
                                          BorderSide(color: Color(0xFF0EA1E8)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF0EA1E8)),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF0EA1E8)),
                                    ),
                                    labelText: "FECHA NACIMIENTO"),
                              ),
                            ),
                            const SizedBox(height: 20.0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 24,
                                            ),
                                            Text(
                                              '...',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      : const Text(
                                          'Validar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white),
                                        ),
                                  onPressed: () async {
                                    if (_controllerfecha.text == "" ||
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

                                      await Future.delayed(
                                          const Duration(seconds: 2));

                                      var rest = await DatabasePr.db
                                          .getValidarUsuario(
                                              dni: int.parse(
                                                  _controllerNDocumento.text),
                                              fechaNacimiento:
                                                  _controllerfecha.text);
                                      if (rest.length > 0) {
                                        nombresUsuario = rest[0].nombres + " " +rest[0].apellidoPaterno  + " " +rest[0].apellidoMaterno;
                                        print(rest[0].nombres);
                                        idUsuario = rest[0].id;
                                        setState(() {
                                          _mostrar = false;
                                        });
                                      }
                                      setState(() {
                                        _isloading = false;
                                      });
                                      if (_isloading == false) {}
                                    }
                                  }),
                            )
                          ],
                        )
                      : new Container(),
                  (_mostrar == false)
                      ? Column(children: [

                        Container(child: Text("$nombresUsuario"),),
                    const SizedBox(height: 20.0),
                          FormularioReq().textinputdet(
                              "INGRESAR NUEVA CONTRASEÑA",
                              _controllerContrasenia,
                              TextCapitalization.words,
                              TextInputType.number, true),
                          const SizedBox(height: 20.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                fontSize: 17,
                                                color: Colors.white),
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
                                  var configPersonal = ConfigPersonal(
                                      contrasenia: _controllerContrasenia.text,
                                      id: idUsuario);
                                  var resp = await DatabasePr.db
                                      .updateUsuarioContrasenia(configPersonal);
                                  if (resp>=0) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => LoadingScreen()));
                                  }
                                }),
                          )
                        ])
                      : new Container()
                ],
              )),
        ));
  }
}
