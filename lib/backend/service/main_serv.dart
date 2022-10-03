import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:get/get.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';

class MainService {
  /// Returns `true` si existe conexion a internet por wifi.
  Future<bool> isOnline() async {
    bool isDeviceConnected = await CheckConnection.isOnlineWifi();
    return isDeviceConnected;
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
    return await Get.find<MainRepository>().getAllMonitoreoDb();
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
      List<UserModel> aApi = await Get.find<MainRepository>().getAllUserApi();

      for (var oUser in aApi) {
        UserModel? response =
            await Get.find<MainRepository>().insertUserDb(oUser);
        if (response != null) {
          aNewLoadUser.add(response!);
        } else {
          print("Error al ingresar usuario a la Base de Datos");
        }
      }

      //aApi.forEach((element) {});
      List<UserModel> aDb = await Get.find<MainRepository>().getAllUserDb();
    }

    return aNewLoadUser;
  }
}
