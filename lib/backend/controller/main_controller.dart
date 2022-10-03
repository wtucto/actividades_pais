import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final loading = false.obs;
  final users = <UserModel>[].obs;
  final moniteos = <TramaMonitoreoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    users.value = await Get.find<MainService>().loadAllUser();
    moniteos.value = await Get.find<MainService>().getAllMonitoreo();
  }

  Future<void> getUser() async {
    if (loading.isTrue) return;
    loading.value = true;
    final newUser = await Get.find<MainRepository>().getNewUser();
    users.insert(0, newUser);
    loading.value = false;
  }

  Future<void> deleteUser(UserModel toDelete) async {
    users.remove(toDelete);
    Get.find<MainRepository>().deleteUser(toDelete);
  }
}

/**
 * @override
  Widget build(BuildContext context) {
    ...
  final controller = Get.put(MainController()); // Se ejecuta loadInitialData();

  return Scaffold(...

 */
