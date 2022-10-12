import 'package:actividades_pais/helpers/http_responce.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

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
}
