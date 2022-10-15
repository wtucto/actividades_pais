import 'dart:convert';

import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class Http {
  late Dio _dio;
  late Logger _logger;
  late bool _logsEnabled;

  Http({
    required Dio dio,
    required Logger logger,
    required bool logsEnabled,
  }) {
    _dio = dio;
    _logger = logger;
    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, String>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: formData != null ? FormData.fromMap(formData) : data,
      );

      final oData = response.data["response"];

      if (parser != null) {
        return HttpResponse.success<T>(parser(oData));
      }
      return HttpResponse.success<T>(oData);
    } catch (e) {
      //_logger.e(e);

      int statusCode = 0;
      String message = "Unknown error";
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          if (e.response!.statusMessage! != "") {
            message = e.response!.statusMessage!;
          }
          data = e.response!.data;
        }
      }

      return HttpResponse.fail<T>(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }

  Future<HttpResponse<T>> postMultipartFile2<T>(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    List<Map<String, String>>? aFile,
    T Function(dynamic data)? parser,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(path));
      request.headers.addAll(headers!);
      request.fields.addAll(data as Map<String, String>);

      for (var oFile in aFile!) {
        for (final entry in oFile.entries) {
          ///request.files.add(await http.MultipartFile.fromPath('imgActividad', '/Users/egarciti/Downloads/8000002492.docx'));
          request.files
              .add(await http.MultipartFile.fromPath(entry.key, entry.value));
        }
      }

      http.StreamedResponse response = await request.send();
      var oData;
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((value) {
          oData = json.decode(value.toString());
        });

        if (parser != null) {
          return HttpResponse.success<T>(parser(oData));
        }
        return HttpResponse.success<T>(oData);
      } else {
        print(response.reasonPhrase);
        return oData;
      }
    } catch (e) {
      //_logger.e(e);

      int statusCode = 0;
      String message = "Unknown error";
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          if (e.response!.statusMessage! != "") {
            message = e.response!.statusMessage!;
          }
          data = e.response!.data;
        }
      }

      return HttpResponse.fail<T>(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }

  Future<HttpResponse<T>> postMultipartFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, dynamic>? formData,
    Map<String, String>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {
      /*var data = {
        'name': 'wendux',
        'age': 25,
        'file':
            await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
        'files': [
          await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
          await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
        ]
      };*/

      final response = await _dio.post(
        path,
        options: Options(
          //method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: FormData.fromMap(data!),
      );

      /*
      RESPONSE:
      {
        "codResultado": 1,
        "msgResultado": "OK",
        "total": null,
        "response": null,
        "idPerfil": null
      }*/
      final oData = response.data;

      if (parser != null) {
        return HttpResponse.success<T>(parser(oData));
      }
      return HttpResponse.success<T>(oData);
    } catch (e) {
      //_logger.e(e);

      int statusCode = 0;
      String message = "Unknown error";
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          if (e.response!.statusMessage! != "") {
            message = e.response!.statusMessage!;
          }
          data = e.response!.data;
        }
      }

      return HttpResponse.fail<T>(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
