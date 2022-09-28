import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:actividades_pais/src/datamodels/Clases/ConsultarTambosPiasxUnidadTerritorial.dart';
import 'package:actividades_pais/util/app-config.dart';

class ProviderConfiguracion {
  Future<List<RspoTambosPiasxUnidadTerritorial>?>
      listaTambosPiasxUnidadTerritorial(tambo, idUnidadTerr) async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/consultarTambosPiasxUnidadTerritorial/$tambo/$idUnidadTerr'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ConsultarTambosPiasxUnidadTerritorial.fromJson(jsonResponse);

      return listadostraba.response;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }
}
