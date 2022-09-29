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

class ConfiguracionPersonal extends StatefulWidget {
  @override
  _ConfiguracionPersonal createState() => _ConfiguracionPersonal();
}

class _ConfiguracionPersonal extends State<ConfiguracionPersonal> {
  TextEditingController _controllerNDocumento = TextEditingController();
  TextEditingController _controllerApPaterno = TextEditingController();
  TextEditingController _controllerApMaterno = TextEditingController();
  TextEditingController _controllerNombres = TextEditingController();
  TextEditingController _controllerCargo = TextEditingController();
  Servicios servicios = new Servicios();
  var _imeiNumber;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  var _isloading = false;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue[800],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("CONFIGURACION PERSONAL"),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  FormularioReq().textinputdet(
                      " NUMERO DNI",
                      _controllerNDocumento,
                      TextCapitalization.words,
                      TextInputType.number),
                  SizedBox(height: 20.0),
                  FormularioReq().textinputdet(" NOMBRES", _controllerNombres,
                      TextCapitalization.words, TextInputType.text),
                  SizedBox(height: 20.0),
                  FormularioReq().textinputdet(
                      " APELLIDO PATERNO",
                      _controllerApPaterno,
                      TextCapitalization.words,
                      TextInputType.text),
                  SizedBox(height: 20.0),
                  FormularioReq().textinputdet(
                      " APELLIDO MATERNO",
                      _controllerApMaterno,
                      TextCapitalization.words,
                      TextInputType.text),
                  /*   SizedBox(height: 20.0),
                  FormularioReq().textinputdet("CARGO", _controllerCargo,
                      TextCapitalization.words, TextInputType.text), */
                  SizedBox(height: 25.0),
                  Container(
                    decoration: servicios.myBoxDecoration(),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(

                        //color: Colors.blue[800],
                        child: _isloading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
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
                            : Text(
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
                                nombres: _controllerNombres.text,
                                apellidoMaterno: _controllerApMaterno.text,
                                apellidoPaterno: _controllerApPaterno.text,
                                cargo: _controllerCargo.text,
                                numeroDni:
                                    int.parse(_controllerNDocumento.text));

                            await DatabasePr.db.insertConfigPersonal(r);

                            var info = InfoTelefono(imei: _imeiNumber);

                            await DatabasePr.db.insertInfoTel(info);
                            await Future.delayed(Duration(seconds: 2));

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
