// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:actividades_pais/api/pnpais_api.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Login/widgets/botonLog.dart';
import 'package:actividades_pais/src/pages/Login/customImput.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 43, 162, 114),
                    Color.fromARGB(255, 30, 143, 70),
                  ],
                ),
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
                          SizedBox(height: h / 15),
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Future LoginUser(usn, psw) async {
      //final listarTramaproyecto = await pnPaisApi.listarTramaproyecto();
      if (usn == 'PAIS' && psw == 'PAIS') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePagePais()));
      } else {
        mostrarAlerta(
            context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
      }
      return '';
    }

    return Container(
      margin: EdgeInsets.only(top: h / 20),
      padding: EdgeInsets.symmetric(horizontal: w / 16),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.supervised_user_circle,
            placeholder: 'usuario',
            keyboardType: TextInputType.text,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonLog(
            text: 'Ingrese',
            onPressed: () {
              LoginUser(emailCtrl.text, passCtrl.text);
            },
          )
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
