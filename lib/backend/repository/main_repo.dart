import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:actividades_pais/backend/database/pnpais_db.dart';
import 'package:actividades_pais/backend/model/dto/trama_monitoreo_response_api.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:logger/logger.dart';

class MainRepository {
  Logger _log = Logger();
  //final coon = DatabasePnPais.instance;

  final DatabasePnPais _dbPnPais;
  final PnPaisApi _pnPaisApi;

  MainRepository(this._pnPaisApi, this._dbPnPais);

  /// PROYECTO
  Future<List<TramaProyectoModel>> getAllProyectoDb(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllProyecto(limit, offset);
  }

  Future<List<TramaProyectoModel>> getAllProyectoByUser(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllProyectoByUser(o, limit, offset);
  }

  Future<List<TramaProyectoModel>> getAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllProyectoByUserSearch(o, search, limit, offset);
  }

  Future<List<TramaProyectoModel>> getProyectoByCUI(
    String cui,
  ) async {
    return _dbPnPais.readAProyectoByCUI(cui);
  }

  Future<List<TramaMonitoreoModel>> getMonitoreoByIdMonitor(
    String idMonitoreo,
  ) async {
    return _dbPnPais.readMonitoreoByIdMonitor(idMonitoreo);
  }

  Future<List<TramaProyectoModel>> getAllProyectoApi() async {
    List<TramaProyectoModel> oUserUp = [];
    final response = await _pnPaisApi.listarTramaProyecto();
    if (response.error == null) {
      oUserUp = response.data!;
    } else {
      _log.e(response.error.message);
    }

    return oUserUp;
  }

  Future<TramaProyectoModel> insertProyectoDb(
    TramaProyectoModel o,
  ) async {
    return await _dbPnPais.insertProyecto(o);
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> getAllMonitoreoDb(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllMonitoreo(limit, offset);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitorPorEnviarDB(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllMonitoreoPorEnviar(limit, offset);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoByIdProyectoDb(
    TramaProyectoModel o,
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllMonitoreoByIdProyecto(limit, offset, o);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoApi() async {
    List<TramaMonitoreoModel> aResp = [];
    final response = await _pnPaisApi.listarTramaMonitoreo();
    if (response.error == null) {
      aResp = response.data!;
    } else {
      _log.e(response.error.message);
    }

    return aResp;
  }

  Future<TramaMonitoreoModel> insertMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    return await _dbPnPais.insertMonitoreo(o);
  }

  Future<int> updateMonitoreoDb(
    TramaMonitoreoModel o,
  ) async {
    return await _dbPnPais.updateMonitoreo(o);
  }

  Future<List<TramaMonitoreoModel>> uploadAllMonitoreo(
    List<TramaMonitoreoModel> o,
  ) async {
    List<TramaMonitoreoModel> aResp = [];

    for (var oMonit in o) {
      final response = await _pnPaisApi.insertarMonitoreo(oBody: oMonit);

      if (response.error == null) {
        TramaMonitoreoRespApiDto? oResp = response.data;
        if (oResp != null) {
          aResp.add(oMonit);
        }
      } else {
        _log.e(response.error.message);
      }
    }
    return aResp;
  }

  /* API RESPONDE
  {
    "codResultado": 0,
    "idPerfil": 0,
    "msgResultado": "string",
    "response": {},
    "total": 0
  }
  */
  Future<TramaMonitoreoModel> insertarMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    TramaMonitoreoRespApiDto? oResp;
    final response = await _pnPaisApi.insertarMonitoreo(oBody: o);
    if (response.error == null) {
      oResp = response.data;
    } else {
      _log.e(response.error.message);
      return Future.error(
        response.error.message,
      );
    }

    return o;
  }

  /// USUARIO APP
  Future<List<UserModel>> getAllUser() async {
    final dbClient = await _dbPnPais.database;
    List<UserModel> aUser = [];
    try {
      final maps = await dbClient.query(tableNameUsers);
      for (var item in maps) {
        aUser.add(UserModel.fromJson(item));
      }
    } catch (oError) {
      _log.e(oError.toString());
    }
    return aUser;
  }

  Future<List<UserModel>> getAllUserDb(
    int? limit,
    int? offset,
  ) async {
    return _dbPnPais.readAllUser(limit, offset);
  }

  Future<List<UserModel>> getAllUserApi() async {
    List<UserModel> oUserUp = [];
    final response = await _pnPaisApi.listarUsuariosApp();
    if (response.error == null) {
      oUserUp = response.data!;
    } else {
      _log.e(response.error.message);
    }
    return oUserUp;
  }

  Future<UserModel> readUserByCode(
    String codigo,
  ) async {
    UserModel oUser = await _dbPnPais.readUserByCode(codigo);
    return oUser;
  }

  Future<List<UserModel>> readUser(
    String codigo,
  ) async {
    List<UserModel> aUserFilter = [];
    List<UserModel> aUser = await _dbPnPais.readEditUser(true);
    if (aUser.length > 0) {
      aUserFilter.add(aUser.firstWhere((o) => o.codigo == codigo));
    }
    return aUserFilter;
  }

  Future<List<UserModel>> readEditUser(
    String codigo,
    String clave,
  ) async {
    List<UserModel> aUserFilter = [];
    List<UserModel> aUser = await _dbPnPais.readEditUser(true);
    if (aUser.length > 0) {
      if (clave.trim() == "") {
        aUserFilter.add(aUser.firstWhere((o) => o.codigo == codigo));
      } else {
        aUserFilter.add(
            aUser.firstWhere((o) => o.codigo == codigo && o.clave == clave));
      }
    }
    return aUserFilter;
  }

  Future<UserModel> insertUserDb(
    UserModel o,
  ) async {
    if (o.id != null && o.id! > 0) {
      o.isEdit = 1;
      await _dbPnPais.updateUser(o);
      return o;
    } else {
      return await _dbPnPais.insertUser(o);
    }
  }

  Future<bool> deleteUserDb(
    UserModel o,
  ) async {
    final result = await _dbPnPais.deleteUser(o.id!);
    return result == 1;
  }
}
