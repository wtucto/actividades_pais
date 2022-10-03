import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:actividades_pais/helpers/http.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class DependencyInjection {
  static void initialize(String sAmbiente) {
    String baseUrl = "";
    switch (sAmbiente) {
      case "DEV":
        baseUrl = "https://backend.pais.gob.pe:8075";
        break;
      case "QAS":
        baseUrl = "";
        break;
      case "PRD":
        baseUrl = "";
        break;
    }
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );

    Logger logger = Logger();
    Http http = Http(
      dio: dio,
      logger: logger,
      logsEnabled: true,
    );

    final PnPaisApi pnPaisApi = PnPaisApi(http);

    GetIt.instance.registerSingleton<PnPaisApi>(pnPaisApi);
  }
}

/**
 * SAMPLE USE:



final pnPaisApi = GetIt.instance<PnPaisApi>();
final response = await pnPaisApi.register(
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