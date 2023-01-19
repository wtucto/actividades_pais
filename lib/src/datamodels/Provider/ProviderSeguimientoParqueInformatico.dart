import 'dart:io';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaMarca.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaModelo.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class ProviderSeguimientoParqueInformatico {
  final Logger _log = Logger();

  Future<List<ListaEquipoInformatico>>? listaParqueInformatico() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    print(headers);
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listaEquipoInformatico'),
        headers: headers,
        body: json.encode({
          "codigoPatrimonial": "",
          "id_marca": "",
          "id_modelo": "",
          "id_ubicacion": "",
          "responsableactual": "",
          "pageIndex": 1,
          "pageSize": 10
        }));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoEquipos =
          new ListaEquipoInformaticos.fromJsonList(jsonResponse["data"]);
      return listadoEquipos.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Marca>>? listaMarcas() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor + '/seguimientoequipo/marcas'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoMarcas = new ListaMarcas.fromJsonList(jsonResponse);
      return listadoMarcas.items;
    } else {
      return List.empty();
    }
  }

  Future<List<Modelo>>? listaModelos() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(AppConfig.backendsismonitor + '/seguimientoequipo/modelo'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoModelo = new ListaModelos.fromJsonList(jsonResponse);
      return listadoModelo.items;
    } else {
      return List.empty();
    }
  }
}
