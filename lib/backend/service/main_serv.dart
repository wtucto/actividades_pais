import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:get/get.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';

class MainService {
  //final MainRepository _repository;
  //MainService(this._repository);

  /// Returns `true` si existe conexion a internet por wifi.
  Future<bool> isOnline() async {
    bool isDeviceConnected = await CheckConnection.isOnlineWifi();
    return isDeviceConnected;
  }

  /**
   * PROYECTO SERVICES
   */

  Future<List<TramaProyectoModel>> getAllProyecto() async {
    return await Get.find<MainRepository>().getAllProyectoDb();
  }

  Future<List<TramaProyectoModel>> loadAllProyecto() async {
    List<TramaProyectoModel> aNewProject = [];
    if (await isOnline()) {
      List<TramaProyectoModel> aDb =
          await Get.find<MainRepository>().getAllProyectoDb();
      List<TramaProyectoModel> aApi =
          await Get.find<MainRepository>().getAllProyectoApi();

      for (TramaProyectoModel oUser in aApi) {
        if (aDb.length > 0) {
          TramaProyectoModel? oUserFind;
          try {
            oUserFind = aDb.firstWhere((o) => o.numSnip == oUser.numSnip,
                orElse: () => TramaProyectoModel.empty());
          } catch (oError) {
            print(oError);
          }
          if (oUserFind != null || oUserFind!.id == 0) {
            continue;
          }
        }

        TramaProyectoModel? response =
            await Get.find<MainRepository>().insertProyectoDb(oUser);
        if (response != null) {
          aNewProject.add(response!);
        } else {
          print("Error al ingresar proyectos a la Base de Datos");
        }
      }
    }

    print("Nuevos proyectos cargados: ${aNewProject.length}");

    List<TramaProyectoModel> aDbExist =
        await Get.find<MainRepository>().getAllProyectoDb();
    return aDbExist;
  }

  /**
   * MONITOREO SERVICES
   */

  Future<List<TramaMonitoreoModel>> fetchAllTramaMonitoreoModel() async {
    List<TramaMonitoreoModel> aTramaMonitoreoModel = [];
    aTramaMonitoreoModel = await Get.find<MainRepository>().getAllMonitoreoDb();
    return aTramaMonitoreoModel;
  }

  Future<List<TramaMonitoreoModel>> mergeAllTramaMonitoreoModel(
      List<TramaMonitoreoModel> a) async {
    List<TramaMonitoreoModel> aTramaMonitoreoModel = [];
    aTramaMonitoreoModel =
        await Get.find<MainRepository>().saveAllMonitoreo(aTramaMonitoreoModel);
    return aTramaMonitoreoModel;
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreo() async {
    //if (await isOnline()) {}

    return await Get.find<MainRepository>().getAllMonitoreoDb();
  }

  Future<TramaMonitoreoModel> insertMonitorDb(TramaMonitoreoModel o) async {
    return await Get.find<MainRepository>().insertMonitorDb(o);
  }

  Future syncAllTramaMonitoreoModel() async {
    await fetchAllTramaMonitoreoModel().then((a) async {
      await mergeAllTramaMonitoreoModel(a);
    });
  }

  /**
   * USER SERVICES
   */

  Future<List<UserModel>> loadAllUser() async {
    List<UserModel> aNewLoadUser = [];
    if (await isOnline()) {
      List<UserModel> aDb = await Get.find<MainRepository>().getAllUserDb();
      List<UserModel> aApi = await Get.find<MainRepository>().getAllUserApi();

      for (UserModel oUser in aApi) {
        if (aDb.length > 0) {
          UserModel oUserFind = aDb.firstWhere((o) => o.codigo == oUser.codigo);
          if (oUserFind != null) {
            continue;
          }
        }

        UserModel? response =
            await Get.find<MainRepository>().insertUserDb(oUser);
        if (response != null) {
          aNewLoadUser.add(response!);
        } else {
          print("Error al ingresar usuario a la Base de Datos");
        }
      }
    }

    print("Nuevos usuarios cargados: ${aNewLoadUser.length}");

    List<UserModel> aDbExist = await Get.find<MainRepository>().getAllUserDb();
    return aDbExist;
  }

  Future<List<UserModel>> getAllUser() async {
    List<UserModel> aDbExist = await Get.find<MainRepository>().getAllUserDb();
    return aDbExist;
  }

  Future<UserModel> getUserLogin(String codigo, String clave) async {
    try {
      List<UserModel> oUserLogin =
          await Get.find<MainRepository>().readEditUser(codigo, clave);
      return oUserLogin[0];
    } catch (oError) {
      print(oError);
    }
    return Future.error(
        'Usuario y/o Clave incorrecto, vuelve a intentarlo mas tarde.');
  }
}
