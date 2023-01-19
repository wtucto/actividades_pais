import 'dart:io';
import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroListaEquipos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/FiltroTicketEquipo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaMarca.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaModelo.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaPersonalSoporte.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTicketEquipos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaTicketEstado.dart';
import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaUbicacion.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class ProviderSeguimientoParqueInformatico {
  final Logger _log = Logger();

  Future<List<ListaEquipoInformatico>>? listaParqueInformatico(
      FiltroParqueInformatico filtroParqueInformatico) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    print(json.encode(filtroParqueInformatico));
    http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listaEquipoInformatico'),
        headers: headers,
        body: json.encode(filtroParqueInformatico));
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

  Future<List<Ubicacion>>? listaUbicacion() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.get(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/listasUbicacion'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listaUbicacion = new ListaUbicacion.fromJsonList(jsonResponse);
      return listaUbicacion.items;
    } else {
      return List.empty();
    }
  }

  Future<String> consultaEquipo(idEquipo) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
    http.Response response = await http.post(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/consultaEquipo'),
        headers: headers,
        body: json.encode({"id_equipo": idEquipo}));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
       if(jsonResponse[0]["path"] == null){
          return '0';
       } else{
         return jsonResponse[0]["path"];
       }
    } else {
      return "0";
    }
  }
  Future<List<ListaPersonalSoporte>>? getListaPersonalSoporte() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
        Uri.parse(
            AppConfig.backendsismonitor + '/seguimientoequipo/listaPersonalSoporte'),
        headers: headers,
       );

    if (response.statusCode == 200) {
       final jsonResponse = json.decode(response.body);
      final listaPersonalSoporte =
      new ListaPersonalSoportes.fromJsonList(jsonResponse);
      return listaPersonalSoporte.items;
    } else {
      return List.empty();
    }
  }

  Future<List<ListaTicketEstado>>? getListaTicketEstado() async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };

    http.Response response = await http.get(
      Uri.parse(
          AppConfig.backendsismonitor + '/seguimientoequipo/ticketEstado'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listaTicketEstados =
      new ListaTicketEstados.fromJsonList(jsonResponse);
      return listaTicketEstados.items;
    } else {
      return List.empty();
    }
  }

  //
  Future<List<ListaEquiposInformaticosTicket>>? getListaEquiposInformaticosTicket(
  {required FiltroTicketEquipo
  filtroTicketEquipo}) async {
    var logUser = await DatabasePr.db.loginUser();
    var headers = {
      'Authorization': 'Bearer ${logUser[0].token}',
      'Content-Type': 'application/json'
    };
     http.Response response = await http.post(
        Uri.parse(AppConfig.backendsismonitor +
            '/seguimientoequipo/listaEquiposInformaticosTicket'),
        headers: headers,
        body: json.encode(filtroTicketEquipo));
     if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadoEquiposInformaticosTickets =
      new ListaEquiposInformaticosTickets.fromJsonList(jsonResponse);
      return listadoEquiposInformaticosTickets.items;
    } else {
      return List.empty();
    }
  }

}
