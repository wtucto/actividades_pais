import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:actividades_pais/backend/database/pnpais_db.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

class MainRepository {
  //final coon = DatabasePnPais.instance;

  final DatabasePnPais _dbPnPais;
  final PnPaisApi _pnPaisApi;

  MainRepository(this._pnPaisApi, this._dbPnPais);

  /**
   * PROYECTO RESPOSITORY
   */

  Future<List<TramaProyectoModel>> getAllProyectoDb() async {
    return _dbPnPais.readAllProyecto();
  }

  Future<List<TramaProyectoModel>> getAllProyectoApi() async {
    List<TramaProyectoModel> oUserUp = [];
    final response = await _pnPaisApi.listarTramaProyectoModel();
    if (response.data != null) {
      oUserUp = response.data!;
    } else {
      print(response.error.message);
    }

    return oUserUp;
  }

  Future<TramaProyectoModel> insertProyectoDb(TramaProyectoModel o) async {
    return await _dbPnPais.insertProyecto(o);
  }

  /**
   * MONITOREO RESPOSITORY
   */

  Future<List<TramaMonitoreoModel>> getAllMonitoreoDb() async {
    return _dbPnPais.readAllMonitoreo();
  }

  Future<List<TramaMonitoreoModel>> saveAllMonitoreo(
      List<TramaMonitoreoModel> aUser) async {
    List<TramaMonitoreoModel> aUserUp = [];

    for (var oUser in aUser) {
      final response = await _pnPaisApi.insertarMonitoreo(oBody: oUser);

      if (response != null) {
        TramaMonitoreoModel? oUserUp = response.data;
        aUserUp.add(oUserUp!);
      } else {
        print(response.error.message);
      }
    }
    return aUserUp;
  }

  Future<TramaMonitoreoModel> insertMonitorDb(TramaMonitoreoModel o) async {
    return await _dbPnPais.insertMonitoreo(o);
  }

  Future<List<TramaMonitoreoModel>> upLoadAllMonitoreo(
      List<TramaMonitoreoModel> aUser) async {
    List<TramaMonitoreoModel> aUserUp = [];

    for (var oUser in aUser) {
      final response = await _pnPaisApi.insertarMonitoreo(oBody: oUser);

      if (response != null) {
        TramaMonitoreoModel? oUserUp = response.data;
        aUserUp.add(oUserUp!);
      } else {
        print(response.error.message);
      }
    }
    return aUserUp;
  }

  /**
   * USER RESPOSITORY
   */

  Future<List<UserModel>> getAllUser() async {
    final dbClient = await _dbPnPais.database;
    List<UserModel> aUser = [];
    try {
      final maps = await dbClient.query(tableNameUsers);
      for (var item in maps) {
        aUser.add(UserModel.fromJson(item));
      }
    } catch (oError) {
      print(oError.toString());
    }
    return aUser;
  }

  Future<List<UserModel>> getAllUserDb() async {
    return _dbPnPais.readAllUser();
  }

  Future<List<UserModel>> getAllUserApi() async {
    List<UserModel> oUserUp = [];
    final response = await _pnPaisApi.listarUsuariosApp();
    if (response.data != null) {
      oUserUp = response.data!;
    } else {
      print(response.error.message);
    }

    return oUserUp;
  }

  Future<List<UserModel>> readEditUser(String codigo, String clave) async {
    List<UserModel> aUserFilter = [];
    List<UserModel> aUser = await _dbPnPais.readEditUser(true);
    if (aUser.length > 0) {
      aUserFilter
          .add(aUser.firstWhere((o) => o.codigo == codigo && o.clave == clave));
    }
    return aUserFilter;
  }

  Future<UserModel> insertUserDb(UserModel o) async {
    return await _dbPnPais.insertUser(o);
  }

  Future<bool> deleteUserDb(UserModel toDelete) async {
    final result = await _dbPnPais.deleteUser(toDelete.id!);
    return result == 1;
  }
}
