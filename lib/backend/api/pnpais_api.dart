import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/model/dto/trama_monitoreo_response_api.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

class PnPaisApi {
  final String basePathApp = "/api-pnpais/app/";
  final Http _http;

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ' + base64.encode(utf8.encode('${username}:${password}'));

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi(this._http);

  Future<HttpResponse<List<UserModel>>> listarUsuariosApp() async {
    return await _http.request<List<UserModel>>(
      '${basePathApp}listarUsuariosApp',
      method: "GET",
      //headers: headers,
      parser: (data) {
        return (data as List).map((e) => UserModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TramaProyectoModel>>> listarTramaProyecto() async {
    return await _http.request<List<TramaProyectoModel>>(
      '${basePathApp}listarTramaproyecto',
      method: "GET",
      //headers: headers,
      parser: (data) {
        return (data as List)
            .map((e) => TramaProyectoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<List<TramaMonitoreoModel>>> listarTramaMonitoreo() async {
    return await _http.request<List<TramaMonitoreoModel>>(
      '${basePathApp}listarTramaMonitoreo',
      method: "GET",
      //headers: headers,
      parser: (data) {
        return (data as List)
            .map((e) => TramaMonitoreoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<TramaMonitoreoRespApiDto>> insertarMonitoreo({
    required TramaMonitoreoModel oBody,
  }) {
    List<Map<String, String>> aFile = [];

    if (oBody.imgActividad != '') {
      final aImgActividad =
          oBody.imgActividad!.split(','); // Notice the whitespace after colon
      for (var oValue in aImgActividad) {
        aFile.add({TramaMonitoreoFields.imgActividad: oValue.trim()});
      }
    }

    if (oBody.imgProblema != '') {
      final aImgProblema =
          oBody.imgProblema!.split(','); // Notice the whitespace after colon
      for (var oValue in aImgProblema) {
        aFile.add({TramaMonitoreoFields.imgProblema: oValue.trim()});
      }
    }

    if (oBody.imgRiesgo != '') {
      final aImgRiesgo =
          oBody.imgRiesgo!.split(','); // Notice the whitespace after colon
      for (var oValue in aImgRiesgo) {
        aFile.add({TramaMonitoreoFields.imgRiesgo: oValue.trim()});
      }
    }

    return _http.postMultipartFile2<TramaMonitoreoRespApiDto>(
      '${basePathApp}insertarMonitoreo',
      data: TramaMonitoreoModel.toJsonObjectApi(oBody),
      aFile: aFile,
      parser: (data) {
        return TramaMonitoreoRespApiDto.fromJson(data);
      },
    );
  }

  /*Future<HttpResponse<TramaMonitoreoModel>> insertarMonitoreo({
    required TramaMonitoreoModel oBody,
  }) {
    return _http.request<TramaMonitoreoModel>(
      '${basePathApp}insertarMonitoreo',
      method: "POST",
      data: TramaMonitoreoModel.toJsonObject(oBody),
      parser: (data) {
        return TramaMonitoreoModel.fromJson(data);
      },
    );
  }*/
}
