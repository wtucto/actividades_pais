// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:actividades_pais/api/pnpais_api.dart';
import 'package:actividades_pais/util/log.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Login/widgets/botonLog.dart';
import 'package:actividades_pais/src/pages/Login/customImput.dart';
import 'package:actividades_pais/src/pages/Login/mostrarAlerta.dart';
import 'package:actividades_pais/src/pages/Login/widgets/logo.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(titulo: ''),
                  _Form(),
                  Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
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
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
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
