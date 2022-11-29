// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:actividades_pais/main.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/configuracion/ConfiguracionInicial.dart';
import 'package:actividades_pais/src/pages/configuracion/ResetContrasenia.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Login/widgets/botonLog.dart';
import 'package:actividades_pais/src/pages/Login/customImput.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/api/pnpais_api.dart';

import '../configuracion/pantallainicio.dart';

SharedPreferences? _prefs;
bool? checkGuardarDatos = false;
bool? check = false;
bool? bRepeat = false;

MainController mainController = MainController();

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var contador = 0;
  @override
  void initState() {
    loadPreferences();
    vaidarexUsuario();

    super.initState();
  }

  loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    check = _prefs!.getBool("check");
    if (_prefs != null && check == true) {
      if (_prefs!.getString("clave") != "") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomePagePais()),
        );
      }
    }
  }

  vaidarexUsuario() async {
    var cnt = await DatabasePr.db.getAllConfigPersonal();
    setState(() {
      print(cnt.length);
      contador = cnt.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: h / 12),
              decoration: const BoxDecoration(
                gradient: mainButton5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: w / 2,
                    height: h / 6,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/paislogo.png',
                          width: w / 3.5,
                          height: h / 7,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -h / 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(
                        left: w / 15, right: w / 15, top: h / 4),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: h / 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Form(),
                          SizedBox(height: h / 50),
                          (contador == 0)
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) => PantallaInicio()),
                                    );
                                  },
                                  child: Text(
                                    'Registrarse en el app',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              : new Container(),
                          SizedBox(height: h / 35),
                          const Text(
                            'Términos y condiciones de uso',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final pnPaisApi = GetIt.instance<PnPaisApi>();
  final emailCtrl = TextEditingController(text: "");
  final passCtrl = TextEditingController();
  final passCtrl2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Future LoginUser(usn, psw, rpsw) async {
      //final listarTramaproyecto = await pnPaisApi.listarTramaproyecto();

      var res = await DatabasePr.db
          .getLoginUser(dni: int.parse(usn), contrasenia: psw);
      if (res.length > 0) {
        ConfigPersonal oUserInfo = res[0];

        if (res[0].unidad != 'UPS') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomePagePais()),
          );
          return;
        }

        UserModel oUser;
        try {
          String codigo = res[0].codigo;
          oUser = await mainController.getUserLogin(codigo, '');

          if (oUser.clave == "") {
            if (bRepeat != true) {
              setState(() {
                bRepeat = true;
              });
              return;
            }
          }

          if (bRepeat == true) {
            if (psw != rpsw) {
              mostrarAlerta(
                context,
                'Login incorrecto',
                'Las contraseñas no coinciden. vuelve a intentarlo',
              );
              return '';
            }
          }

          if (bRepeat == true) {
            oUser.clave = psw;

            await mainController.insertUser(oUser);
          } else {
            oUser = await mainController.getUserLogin(codigo, "");
          }

          //setState(() { bRepeat = true; });

          if ((oUser.codigo == codigo &&
              (oUser.clave == psw || oUserInfo.contrasenia == psw))) {
            // mainController.users.value = [oUser];

            //SECCION
            check = _prefs!.getBool("check");
            if (_prefs != null && check == true) {
              _prefs!.setString("clave", oUser.clave!);
            } else {
              _prefs!.setString("clave", "");
            }

            _prefs!.setString("nombres", oUser.nombres!);
            _prefs!.setString("codigo", oUser.codigo!);
            _prefs!.setString("rol", oUser.rol!);
            _prefs!.setString("dni", oUserInfo.numeroDni.toString());

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => HomePagePais()),
            );
            return;
          } else {
            mostrarAlerta(
              context,
              'Login incorrecto',
              'Revise sus credenciales nuevamente',
            );
          }
        } catch (oError) {
          mostrarAlerta(context, 'Login incorrecto', oError.toString());
        }
      }
      /*  if (usn == 'PAIS' && psw == 'PAIS') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomePagePais()),
        );
        return;
      }*/

      UserModel oUser;
      try {
        oUser = await mainController.getUserLogin(usn, '');

        if (oUser.clave == "") {
          if (bRepeat != true) {
            setState(() {
              bRepeat = true;
            });
            return;
          }
        }

        if (bRepeat == true) {
          if (psw != rpsw) {
            mostrarAlerta(
              context,
              'Login incorrecto',
              'Las contraseñas no coinciden. vuelve a intentarlo',
            );
            return '';
          }
        }

        if (bRepeat == true) {
          oUser.clave = psw;

          await mainController.insertUser(oUser);
        } else {
          oUser = await mainController.getUserLogin(usn, psw);
        }

        //setState(() { bRepeat = true; });

        if ((oUser.codigo == usn && oUser.clave == psw)) {
          // mainController.users.value = [oUser];

          //SECCION
          check = _prefs!.getBool("check");
          if (_prefs != null && check == true) {
            _prefs!.setString("clave", oUser.clave!);
          } else {
            _prefs!.setString("clave", "");
          }

          _prefs!.setString("nombres", oUser.nombres!);
          _prefs!.setString("codigo", oUser.codigo!);
          _prefs!.setString("rol", oUser.rol!);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => HomePagePais(),
            ),
          );
        } else {
          mostrarAlerta(
            context,
            'Login incorrecto',
            'Revise sus credenciales nuevamente',
          );
        }
      } catch (oError) {
        mostrarAlerta(context, 'Login incorrecto', oError.toString());
      }

      return;
    }

    return Container(
      margin: EdgeInsets.only(top: h / 20),
      padding: EdgeInsets.symmetric(horizontal: w / 16),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.supervised_user_circle,
            placeholder: 'Ingrerse su DNI',
            keyboardType: TextInputType.text,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Ingrese su Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          if (bRepeat == true)
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Repetir Contraseña',
              textController: passCtrl2,
              isPassword: true,
            ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => ResetContrasenia()),
              );
            },
            child: const Text(
              'Olvido su contraseña?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: h / 50),
          BotonLog(
            text: 'Ingresar',
            onPressed: () {
              LoginUser(emailCtrl.text, passCtrl.text, passCtrl2.text);
            },
          ),
          CheckboxListTile(
            value: checkGuardarDatos,
            title: const Text('Recordar'),
            onChanged: (value) {
              setState(() {
                checkGuardarDatos = value!;
                _prefs!.setBool("check", value);
              });
            },
            secondary: const Icon(Icons.safety_check),
          ),
        ],
      ),
    );
  }
}

// body: SafeArea(
//   child: SingleChildScrollView(
//     physics: BouncingScrollPhysics(),
//     child: Container(
//       height: MediaQuery.of(context).size.height * 0.9,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Logo(titulo: ''),
//           _Form(),
//           Text(
//             'Términos y condiciones de uso',
//             style: TextStyle(fontWeight: FontWeight.w200),
//           )
//         ],
//       ),
//     ),
//   ),
// ),
