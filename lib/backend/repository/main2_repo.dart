import 'package:actividades_pais/backend/api/pnpais2_api.dart';
import 'package:actividades_pais/backend/database/pnpais_db.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:logger/logger.dart';

class Main2Repository {
  final Logger _log = Logger();

  final DatabasePnPais _dbPnPais;
  final PnPaisApi2 _pnPaisApi;

  Main2Repository(this._pnPaisApi, this._dbPnPais);

  Future<List<TamboModel>> searchTambo(String? palabra) async {
    List<TamboModel> oUserUp = [];
    final response = await _pnPaisApi.searchTambo(palabra);
    if (response.error == null) {
      oUserUp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oUserUp;
  }
}
