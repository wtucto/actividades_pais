import 'package:get/get.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';

/*
   SAMPLE USE:
   ObsGlobal c = Get.put(ObsGlobal());
   c.proyectos.value //Get
   c.getUsuario() // Get
   */
class ObsGlobal extends GetxController {
  final active = false.obs;
  final users = <UserModel>[].obs;
  final moniteos = <TramaMonitoreoModel>[].obs;
  final proyectos = <TramaProyectoModel>[].obs;

  List<UserModel> getUsuario() {
    return users;
  }

  List<TramaProyectoModel> getProyecto() {
    return proyectos;
  }

  List<TramaMonitoreoModel> getMonitoreo() {
    return moniteos;
  }
}
