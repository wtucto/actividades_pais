import 'package:actividades_pais/backend/api/pnpais_api.dart';
import 'package:actividades_pais/backend/database/pnpais_db.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

class MainRepository {
  //final coon = DatabasePnPais.instance;

  final DatabasePnPais _dbPnPais;
  final PnPaisApi _pnPaisApi;

  MainRepository(this._pnPaisApi, this._dbPnPais);

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
    final response = await _pnPaisApi.listarUsuarios();
    if (response.data != null) {
      oUserUp = response.data!;
    } else {
      print(response.error.message);
    }

    return oUserUp;
  }

  Future<UserModel> getNewUser() async {
    final RespUsers = await _pnPaisApi.listarUsuarios();
    List<UserModel> aUser = RespUsers.data!;
    UserModel oUser = aUser.firstWhere((o) => o.isEdit == true);

    final user = UserModel(
        id: oUser.id,
        rol: oUser.rol,
        codigo: oUser.codigo,
        nombres: oUser.nombres,
        createdTime: oUser.createdTime,
        isEdit: true);
    await _dbPnPais.createUser(user);
    return user;
  }

  Future<UserModel> insertUserDb(UserModel o) async {
    return await _dbPnPais.createUser(o);
  }

  Future<List<UserModel>> upLoadAllUser(List<UserModel> aUser) async {
    List<UserModel> aUserUp = [];

    for (var oUser in aUser) {
      final response = await _pnPaisApi.insertarUsuario(oBody: oUser);

      if (response != null) {
        UserModel? oUserUp = response.data;
        aUserUp.add(oUserUp!);
      } else {
        print(response.error.message);
      }
    }
    return aUserUp;
  }

  Future<bool> deleteUser(UserModel toDelete) async {
    final result = await _dbPnPais.deleteUser(toDelete.id!);
    return result == 1;
  }
}
