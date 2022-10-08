import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MainController extends GetxController {
  Logger _log = Logger();

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

  Future<List<TramaProyectoModel>> getProyectoById(
    String sId,
  ) async {
    return await Get.find<MainService>().getProyectoById(sId);
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

  Future<TramaMonitoreoModel> saveMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    DateFormat oDFormat = DateFormat('dd-MM-yyyy');

    if (loading.isTrue) {
      return Future.error(
        'Ya hay un proceso en ejecución, espere a que finalice.',
      );
    }

    loading.value = true;

    if (o.estadoMonitoreo.trim().toUpperCase() ==
        TramaMonitoreoModel.sEstadoENV) {
      loading.value = false;
      return Future.error(
        'Imposible modificar un Monitoreo con el estado: ${TramaMonitoreoModel.sEstadoENV}',
      );
    }

    if (o.cui.trim() == '') {
      loading.value = false;
      return Future.error(
        'Error al procesar el Monitoreo, verifique los siguientes campos: CUI.',
      );
    }

    if (o.fechaMonitoreo.trim() == '') {
      o.fechaMonitoreo = oDFormat.format(DateTime.now());
    }

    String idBuild = '<CUI>_IDE_<FECHA_MONITOREO>';
    idBuild = idBuild.replaceAll('<CIU>', o.cui);
    idBuild = idBuild.replaceAll('<FECHA_MONITOREO>', o.fechaMonitoreo);
    o.idMonitoreo = idBuild;

    /*
      Autocompletar campos con datos del Proyecto
      - snip -> numSnip
      - tambo -> tambo
      - fechaTerminoEstimado -> fechaTerminoEstimado
      - avanceFisicoAcumulado -> avanceFisico
    */
    try {
      List<TramaProyectoModel> aSearh =
          await Get.find<MainService>().getProyectoById(o.cui);
      if (aSearh != null && aSearh.length > 0) {
        TramaProyectoModel oProyecto = aSearh[0];
        if (o.snip.trim() == '') {
          o.snip = oProyecto.numSnip;
        }
        if (o.tambo.trim() == '') {
          o.tambo = oProyecto.tambo;
        }
        if (o.fechaTerminoEstimado.trim() == '') {
          o.fechaTerminoEstimado = oProyecto.fechaTerminoEstimado;
        }
        if (o.avanceFisicoAcumulado.trim() == '') {
          o.avanceFisicoAcumulado = oProyecto.avanceFisico;
        }
      }
    } catch (oError) {
      _log.e(oError);
    }

    /*
      Validar campos OBLIGATORIOS
      - ID: <cui>_IDE_<fechaMonitoreo>
      - latitud
      - longitud
      - fechaTerminoEstimado
      - actividadPartidaEjecutada
      - alternativaSolucion
      - avanceFisicoAcumulado
      - estadoAvance
      - fechaMonitoreo
      - imgActividad
      - problemaIdentificado
    */

    bool isComplete = true;
    if (o.latitud.trim() == '') {
      isComplete = false;
    } else if (o.longitud.trim() == '') {
      isComplete = false;
    } else if (o.fechaTerminoEstimado.trim() == '') {
      isComplete = false;
    } else if (o.actividadPartidaEjecutada.trim() == '') {
      isComplete = false;
    } else if (o.alternativaSolucion.trim() == '') {
      isComplete = false;
    } else if (o.avanceFisicoAcumulado.trim() == '') {
      isComplete = false;
    } else if (o.estadoAvance.trim() == '') {
      isComplete = false;
    } else if (o.imgActividad.trim() == '') {
      isComplete = false;
    } else if (o.problemaIdentificado.trim() == '') {
      isComplete = false;
    }

    if (isComplete) {
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoPEN;
    } else {
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoINC;
    }

    final aResp = await Get.find<MainService>().insertMonitorDb(o);
    moniteos.value = [aResp];
    loading.value = false;

    return aResp;
  }

  /*
    Enviar registros a la nuve
    - Validar que todos los campos requeridos esten completos
    - Validar que el estado esta en: POR ENVIAR
    - Validar que se encuentre con conexion a internet
  */
  Future<List<TramaMonitoreoModel>> sendMonitoreo(
    List<TramaMonitoreoModel> a,
  ) async {
    if (loading.isTrue) {
      return Future.error(
        'Ya hay un proceso en ejecución, espere a que finalice.',
      );
    }

    loading.value = true;

    /// Evaluar que todos los monitoreos de la lista tengan el estado
    /// POR ENVIAR
    bool isOk = true;
    a.forEach((o) {
      if (o.estadoMonitoreo != TramaMonitoreoModel.sEstadoPEN) {
        isOk = false;
      }
    });

    if (isOk) {
      final aResp = await Get.find<MainService>().sendMonitoreo(a);
      return aResp;
    } else {
      loading.value = false;
      return Future.error(
        'Imposible enviar documentos al servidor debido a que tienen estados diferentes a : ${TramaMonitoreoModel.sEstadoPEN}',
      );
    }
  }
}

/**
 * @override
  Widget build(BuildContext context) {
    ...
  final controller = Get.put(MainController()); // Se ejecuta loadInitialData();

  return Scaffold(...

 */
