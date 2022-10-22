import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/model/dto/trama_response_api_dto.dart';
import 'package:actividades_pais/backend/model/listar_programa_intervenciones_model.dart';
import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

class PnPaisApi {
  final Http _http;
  final String basePathApp = "/api-pnpais/app/";

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi(this._http);

  Future<HttpResponse<List<UserModel>>> listarUsuariosApp() async {
    return await _http.request<List<UserModel>>(
      '${basePathApp}listarUsuariosApp',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => UserModel.fromJson(e)).toList();
      },
    );
  }

  Future<HttpResponse<List<TramaProyectoModel>>> listarTramaProyecto() async {
    return await _http.request<List<TramaProyectoModel>>(
      '${basePathApp}listarTramaproyecto',
      method: "GET",
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
      parser: (data) {
        return (data as List)
            .map((e) => TramaMonitoreoModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<HttpResponse<TramaRespApiDto>> insertProgramaIntervencion({
    required ProgramacionIntervencionesModel oBody,
  }) async {
    List<Map<String, String>> aFile = [];

    if (oBody.adjuntarArchivo != '') {
      final aImgActividad = oBody.adjuntarArchivo!.split(',');
      for (var oValue in aImgActividad) {
        aFile.add(
            {ProgramacionIntervencionesFields.adjuntarArchivo: oValue.trim()});
      }
    }

    var prog = ProgramacionIntervencionesModel.toJsonObjectApi(oBody);

    var aAct = (oBody.registroEntidadActividades as List)
        .map((e) => RegistroEntidadActividadModel.toJsonObjectApi(e))
        .toList();

    var aActFormat = await formDataList(
      aAct,
      ProgramacionIntervencionesFields.registroEntidadActividades,
    );

    var oBodyFormData = {
      ...prog,
      ...aActFormat,
    };

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp}insertarProgramaIntervenciones',
      data: oBodyFormData,
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  Future<HttpResponse<TramaRespApiDto>> insertarMonitoreo({
    required TramaMonitoreoModel oBody,
  }) {
    List<Map<String, String>> aFile = [];

    if (oBody.imgActividad != '') {
      final aImgActividad = oBody.imgActividad!.split(',');
      for (var oValue in aImgActividad) {
        aFile.add({TramaMonitoreoFields.imgActividad: oValue.trim()});
      }
    }

    if (oBody.imgProblema != '') {
      final aImgProblema = oBody.imgProblema!.split(',');
      for (var oValue in aImgProblema) {
        aFile.add({TramaMonitoreoFields.imgProblema: oValue.trim()});
      }
    }

    if (oBody.imgRiesgo != '') {
      final aImgRiesgo = oBody.imgRiesgo!.split(',');
      for (var oValue in aImgRiesgo) {
        aFile.add({TramaMonitoreoFields.imgRiesgo: oValue.trim()});
      }
    }

    return _http.postMultipartFile2<TramaRespApiDto>(
      '${basePathApp}insertarMonitoreo',
      data: TramaMonitoreoModel.toJsonObjectApi(oBody),
      aFile: aFile,
      parser: (data) {
        return TramaRespApiDto.fromJson(data);
      },
    );
  }

  Future<Map<String, String>> formDataList(
    List<Map<String, String>> a,
    String field,
  ) async {
    var index = 0;
    Map<String, String> mapFormData = {};
    for (var o in a) {
      o.forEach((key, value) {
        mapFormData.putIfAbsent('$field[$index].$key', () => value);
      });
      index++;
    }

    return mapFormData;
  }
}
