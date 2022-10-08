import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  /*
   SAMPLE USE:
   MainController c = Get.put(MainController());
   c.log2.value
   */
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
    final newUser = await Get.find<MainService>().getAllUser();
    users.value = newUser;
    loading.value = false;
  }

  Future<UserModel> getUserLogin(
    String codigo,
    String clave,
  ) async {
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

  Future<List<TramaProyectoModel>> getAllProyectoByUser(
    UserModel o,
  ) async {
    return await Get.find<MainService>().getAllProyectoByUser(o);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoByProyecto(
    TramaProyectoModel o,
  ) async {
    return await Get.find<MainService>().getAllMonitoreoByProyecto(o);
  }

  Future<bool> saveMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    if (loading.isTrue) return false;
    loading.value = true;
    final newUser = await Get.find<MainService>().insertMonitorDb(o);
    moniteos.value = [newUser];
    loading.value = false;

    return true;
  }

/*
  Enviar registros a la nuve
  - Validar que todos los campos requeridos esten completos
  - Validar que el estado esta en: POR ENVIAR
  - Validar que se encuentre con conexion a internet
 */
  Future<List<TramaMonitoreoModel>> sendMonitoreo(
    List<TramaMonitoreoModel> o,
  ) async {
    if (loading.isTrue) return [];
    loading.value = true;
    final newUser = await Get.find<MainService>().sendMonitoreo(o);
    loading.value = false;
    return newUser;
  }
}

/**
 * @override
  Widget build(BuildContext context) {
    ...
  final controller = Get.put(MainController()); // Se ejecuta loadInitialData();

  return Scaffold(...

 */
