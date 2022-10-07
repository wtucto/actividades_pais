import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final loading = false.obs;
  final users = <UserModel>[].obs;
  final moniteos = <TramaMonitoreoModel>[].obs;
  final proyectos = <TramaProyectoModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await loadInitialData();
  }

  Future<void> loadInitialData() async {
    loading.value = true;
    /*final serv = Get.put(MainService());
    users.value = await serv.loadAllUser();*/
    proyectos.value = await Get.find<MainService>().loadAllProyecto();
    moniteos.value = await Get.find<MainService>().getAllMonitoreo();
    users.value = await Get.find<MainService>().loadAllUser();
    loading.value = false;
  }

  Future<void> getAllUser() async {
    if (loading.isTrue) return;
    loading.value = true;
    final newUser = await Get.find<MainRepository>().getAllUser();
    users.value = newUser;
    loading.value = false;
  }

  Future<UserModel> getUserLogin(String codigo, String clave) async {
    UserModel oUserLogin =
        await Get.find<MainService>().getUserLogin(codigo, clave);
    return oUserLogin;
  }

  Future<List<TramaProyectoModel>> getAllProyecto() async {
    return await Get.find<MainService>().getAllProyecto();
  }

  Future<List<TramaMonitoreoModel>> getAllMonitor() async {
    return await Get.find<MainService>().getAllMonitoreo();
  }

  Future<bool> saveMonitoreo(TramaMonitoreoModel o) async {
    if (loading.isTrue) return false;
    loading.value = true;
    final newUser = await Get.find<MainRepository>().insertMonitorDb(o);
    moniteos.value = [newUser];
    loading.value = false;

    return true;
  }
}

/**
 * @override
  Widget build(BuildContext context) {
    ...
  final controller = Get.put(MainController()); // Se ejecuta loadInitialData();

  return Scaffold(...

 */
