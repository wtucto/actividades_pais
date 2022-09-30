import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/dto/trama_proyecto_dto.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:actividades_pais/util/log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PnPaisApi {
  final Http _http;
  final Logger _logger = new Logger();

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ' + base64.encode(utf8.encode('${username}:${password}'));

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi(this._http);

  Future<HttpResponse<List<TramaProyecto>>> listarTramaproyecto() async {
    final oResp = await _http.request<List<TramaProyecto>>(
      '/api-pnpais/app/listarTramaproyecto',
      method: "GET",
      //headers: headers,
      parser: (data) {
        return (data as List).map((e) => TramaProyecto.fromJson(e)).toList();
      },
    );
    return oResp;
  }

  Future<HttpResponse<TramaProyecto>> register({
    required String username,
    required String email,
    required String password,
  }) {
    return _http.request<TramaProyecto>(
      '/api/v1/register',
      method: "POST",
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
      parser: (data) {
        return TramaProyecto.fromJson(data);
      },
    );
  }
}
/**
 * SAMPLE USE:
final PnPaisApi _pnPaisApi = PnPaisApi();

final response = await _pnPaisApi.register(
  username: _username,
  email: _email,
  password: _password,
);

if(response != null) {
  print(response.data);
} else {
  print(response.error.message);
}
 */


