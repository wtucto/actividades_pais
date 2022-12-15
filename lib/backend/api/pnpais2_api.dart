import 'dart:convert';
import 'dart:io';

import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:actividades_pais/helpers/http_responce.dart';

class PnPaisApi2 {
  final Http _http;
  final String basePathTambook = "/tambook/tambo/default/";

  static String username = "username";
  static String password = "password";
  static String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: basicAuth,
  };

  PnPaisApi2(this._http);

  Future<HttpResponse<List<TamboModel>>> searchTambo(String? palabra) async {
    var sFilter = palabra != null ? '?term=$palabra' : '';
    return await _http.request<List<TamboModel>>(
      '${basePathTambook}buscarportambo$sFilter',
      method: "GET",
      parser: (data) {
        return (data as List).map((e) => TamboModel.fromJson(e)).toList();
      },
    );
  }
}
