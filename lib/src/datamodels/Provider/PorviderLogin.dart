import 'dart:io';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/dto/login_dto.dart';
import 'package:actividades_pais/backend/model/dto/response_token_dto.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigInicio.dart';
import 'package:actividades_pais/src/datamodels/Clases/ConfigPersonal.dart';
import 'package:actividades_pais/src/datamodels/Clases/LoginClass.dart';
import 'package:actividades_pais/src/datamodels/Provider/Pias/ProviderServiciosRest.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class ProviderLogin {
  final Logger _log = Logger();

  bool _isOnline = false;

  Future<bool> _checkInternetConnection() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final result = await InternetAddress.lookup('www.google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
        return _isOnline;
      } else {
        _isOnline = false;
        return _isOnline;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    return _isOnline;
  }

  Login({username, password}) async {
    MainController mainController = MainController();
    LoginDto oLogin = LoginDto.empty();
    oLogin.username = username;
    oLogin.password = password;

    var chekInternet = await _checkInternetConnection();
    if (chekInternet == true) {
      var headers = {'Content-Type': 'application/json'};

      RespTokenDto oToken = await mainController.login(oLogin);
      /*http.Response response = await http.post(
          Uri.parse(
              'https://www.pais.gob.pe/backendsismonitor/public/seguridad/login'),
          headers: headers,
          body: json.encode({
            "username": username,
            "password": password,
          }));*/

      if (oToken != null) {
        //final parsedJson = jsonDecode(response.body);
        //final log = new LoginClass.fromJson(parsedJson);
        var loginClass = LoginClass();
        loginClass.username = username;
        loginClass.password = password;
        loginClass.name = oToken.name;
        loginClass.rol = oToken.rol;
        loginClass.token = oToken.token;
        loginClass.id = oToken.id;
        var a = await DatabasePr.db.Login(loginClass);

        http.Response responseUsuario = await http.get(
            Uri.parse(AppConfig.urlBackndServicioSeguro +
                '/api-pnpais/app/datosLoginUsuario/${loginClass.id}'),
            headers: headers);
        final parsedJson2 = jsonDecode(responseUsuario.body);
        final data = parsedJson2["response"];

        if (responseUsuario.statusCode == 200) {
          if (parsedJson2["total"] > 0) {
            var r2 = ConfigPersonal(
                unidad: '',
                nombres: data[0]["empleado_nombre"] ?? '',
                apellidoMaterno: data[0]["empleado_apellido_materno"] ?? '',
                apellidoPaterno: data[0]["empleado_apellido_paterno"] ?? '',
                contrasenia: password ?? '',
                fechaNacimento: data[0]["empleado_fecha_nacimiento"] ?? '',
                numeroDni: int.parse(username ?? 0));

            await DatabasePr.db.insertConfigPersonal(r2);

            for (var i = 0; i < data.length; i++) {
              _log.i(data[0]["empleado_nombre"]);
              var configIni = ConfigInicio(
                  idLugarPrestacion: 0,
                  idPuesto: data[i]["id_puesto"] ?? 0,
                  idTambo: data[i]["id_plataforma"] ?? 0,
                  idUnidTerritoriales: data[i]["id_unidad_territorial"] ?? 0,
                  idUnidadesOrganicas: 0,
                  lugarPrestacion: "",
                  nombreTambo: data[i]["plataforma_descripcion"] ?? '',
                  puesto: data[i]["puesto_descripcion"] ?? '',
                  unidTerritoriales:
                      data[i]["unidad_territorial_descripcion"] ?? '',
                  unidadesOrganicas: "",
                  snip: data[i]["plataforma_codigo_snip"] ?? 0,
                  tipoPlataforma: data[i]["tipoPlataforma"] ?? '',
                  campania: '',
                  codCampania: '',
                  modalidad: data[i]["modalidad"] ?? '');

              if (configIni.tipoPlataforma == 'PIAS') {
                await ProviderServiciosRest().listarPuntoAtencionPias(
                    '0', data[i]["id_plataforma"] ?? 0, 0);
              }

              await DatabasePr.db.insertConfigInicio(configIni);
            }

            if (data[0]["unidad_territorial_descripcion"] != null) {
              await ProviderDatos().getInsertParticipantesIntervencionesMovil(
                  data[0]["unidad_territorial_descripcion"]);
            }
          }
        }
        return a;
      }
    } else if (chekInternet == false) {
      var rsp = await DatabasePr.db
          .getLoginUser(dni: username, contrasenia: password);

      return rsp.length;
    }
  }
}
