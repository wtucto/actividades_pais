import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:get/instance_manager.dart';

class SyncronizeData {
  Future<bool> isOnline() async {
    bool isDeviceConnected = await CheckConnection.isOnlineWifi();
    return isDeviceConnected;
  }

  Future<void> syncAllMonitoreoByStatusPorEnviar(TramaMonitoreoModel o) async {
    if (await isOnline()) {
      Get.find<MainService>().syncAllMonitoreoByStatusPorEnviar(0, 0);
    } else {
      return Future.error(
        '¡Ups! Algo salió mal, verifica tu conexión a Internet.',
      );
    }
  }
}
