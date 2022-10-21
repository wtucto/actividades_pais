import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:get/get.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';
import 'package:logger/logger.dart';

class MainService {
  final Logger _log = Logger();

  /// Returns `true` si existe conexion a internet por wifi/Mobile.
  Future<bool> isOnline() async {
    bool isDeviceConnected = await CheckConnection.isOnlineWifiMobile();
    return isDeviceConnected;
  }

  /*
  Enviar los registros de monitoreo a la Base de datos central mediante el 
  API REST.

  @TramaMonitoreoModel a : Listado de Monitoreos para enviar registros a la nuve
  @TramaMonitoreoModel e : Listado de Monitoreos que fallaron al enviar
                           (Parametro solo valido para el metodo recursivo)

  CONSIDERACIONES:
  - Los estados del Monitoreo deben de tener el estado: POR ENVIAR

  SECUENCIAS:
    LOOP ... 
      (1) - Se envia el registros de monitoreo al API REST 
      (2) - Si el envio es correcto, se actualiza el registro en la DB Local al estado
        ENVIADO
      (3) - Responder con todos los registros enviados a la API REST
      (4) - Responder con todos los registros que generaron Error en la API REST
    END LOOP.
  */
  Future<List<TramaMonitoreoModel>> sendAllMonitoreo(
    List<TramaMonitoreoModel> a,
    List<TramaMonitoreoModel>? e,
  ) async {
    bool isOnlines = await isOnline();
    if (isOnlines) {
      List<TramaMonitoreoModel> aResp = [];
      List<TramaMonitoreoModel> aError = e ?? [];
      List<TramaMonitoreoModel> aNoConect = [];

      for (var oMonit in a) {
        /// (1)...
        String estadoMonitoreo = oMonit.estadoMonitoreo!;
        oMonit.estadoMonitoreo = TramaMonitoreoModel.sEstadoENV;

        if (isOnlines) {
          try {
            final oResp =
                await Get.find<MainRepository>().insertarMonitoreo(oMonit);
            if (oResp.idMonitoreo != "") {
              /// (2)...
              TramaMonitoreoModel? oSend = oResp;
              oSend.id = oMonit.id;
              await Get.find<MainRepository>().updateMonitoreoDb(oSend);

              /// (3)...
              aResp.add(oSend);
            }
          } catch (oError) {
            oMonit.estadoMonitoreo = estadoMonitoreo;

            /// (4)...
            aError.add(oMonit);

            ///Si falla volver a consultar si existe conexión
            isOnlines = await isOnline();
          }
        } else {
          /// (4)...
          oMonit.estadoMonitoreo = estadoMonitoreo;
          aNoConect.add(oMonit);
        }
      }

      if (aNoConect.length > 0) {
        /**
         * Metodo recursivo: Solo reintentar los registros que no se enviaron
         * por perdida de conexión despues de 3 segundos
         */
        await Future.delayed(const Duration(seconds: 3));
        sendAllMonitoreo(aNoConect, aError);
      }

      return aError;
    } else {
      return Future.error(
        '¡Ups! Algo salió mal, verifica tu conexión a Internet.',
      );
    }
  }

  Future<List<TramaProyectoModel>> getAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind = await Get.find<MainRepository>()
        .getAllProyectoByUserSearch(o, search, limit, offset);
    return aFind;
  }

  Future<List<TramaProyectoModel>> getAllProyectoByNeUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind = await Get.find<MainRepository>()
        .getAllProyectoByNeUserSearch(o, search, limit, offset);
    return aFind;
  }

  Future<List<TramaProyectoModel>> getProyectoByCUI(
    String cui,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind =
        await Get.find<MainRepository>().getProyectoByCUI(cui);
    return aFind;
  }

  Future<List<TramaMonitoreoModel>> readAllOtherMonitoreo(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local de los monitoreos cuyo proyecto no pertence al usuario
    List<TramaMonitoreoModel> aFind = await Get.find<MainRepository>()
        .readAllOtherMonitoreo(o, limit, offset);
    return aFind;
  }

  Future<List<TramaMonitoreoModel>> getMonitoreoByIdMonitor(
    String idMonitoreo,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind =
        await Get.find<MainRepository>().getMonitoreoByIdMonitor(idMonitoreo);
    return aFind;
  }

  Future<List<TramaProyectoModel>> loadAllProyecto(
    int? limit,
    int? offset,
  ) async {
    List<TramaProyectoModel> aNewProject = [];

    ///Verifica que tenga conexion a internet
    if (await isOnline()) {
      ///Obtiene los registros de la DB Local
      List<TramaProyectoModel> aDb =
          await Get.find<MainRepository>().getAllProyectoDb(limit, offset);

      ///Obtiene los registros de la nuve consumiento la API REST
      List<TramaProyectoModel> aApi =
          await Get.find<MainRepository>().getAllProyectoApi();

      /**
       * Se realiza:
       * Matach entre los dos registros (DB y API),
       * Si los registros de la API teniendo como base el ID @CUI (Código único del proyecto)
       * (1) - existe en la DB local se ignora el registro
       * (2) - caso contrario se procede a registrar a la DB local.
       */
      for (TramaProyectoModel oApi in aApi) {
        if (aDb.isNotEmpty) {
          TramaProyectoModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere((o) => o.cui == oApi.cui,
                orElse: () => TramaProyectoModel.empty());
          } catch (oError) {
            _log.e(oError);
          }

          /// (1)
          if (oDataFind != null || oDataFind!.id == 0) {
            continue;
          }
        }

        /// (2)
        TramaProyectoModel? response =
            await Get.find<MainRepository>().insertProyectoDb(oApi);
        if (response != null) {
          aNewProject.add(response!);
        } else {
          _log.e('Error al ingresar proyectos a la Base de Datos');
        }
      }

      _log.i('Nuevos proyectos cargados: ${aNewProject.length}');
    }

    return aNewProject;
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> loadAllMonitoreo(
    int? limit,
    int? offset,
  ) async {
    List<TramaMonitoreoModel> aNewMonitoreo = [];
    if (await isOnline()) {
      List<TramaMonitoreoModel> aDb =
          await Get.find<MainRepository>().getAllMonitoreoDb(limit, offset);
      List<TramaMonitoreoModel> aApi =
          await Get.find<MainRepository>().getAllMonitoreoApi();

      for (TramaMonitoreoModel oApi in aApi) {
        if (aDb.isNotEmpty) {
          TramaMonitoreoModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere((o) => o.idMonitoreo == oApi.idMonitoreo,
                orElse: () => TramaMonitoreoModel.empty());
          } catch (oError) {
            _log.e(oError);
          }
          if (oDataFind != null || oDataFind!.id == 0) {
            if (oDataFind.estadoMonitoreo != TramaMonitoreoModel.sEstadoENV) {
              /*
                Si el estado del monitoreo en la nuve es diferente a la data local, 
                se actualiza el registro local.
               */
              oApi.id = oDataFind.id;
              oApi.isEdit = 0;
              await Get.find<MainRepository>().updateMonitoreoDb(oApi);
            }
            continue;
          }
        }

        TramaMonitoreoModel? response =
            await Get.find<MainRepository>().insertMonitorDb(oApi);
        if (response != null) {
          aNewMonitoreo.add(response!);
        } else {
          _log.e('Error al ingresar monitoreo a la Base de Datos');
        }
      }
      _log.i('Nuevos monitoreos cargados: ${aNewMonitoreo.length}');
    }

    return aNewMonitoreo;
  }

  Future<List<TramaMonitoreoModel>> getAllMonitorPorEnviar(
    int? limit,
    int? offset,
    TramaProyectoModel? o,
  ) async {
    //if (await isOnline()) {}
    return await Get.find<MainRepository>()
        .getAllMonitorPorEnviarDB(limit, offset, o!);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoByProyecto(
    TramaProyectoModel o,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind = await Get.find<MainRepository>()
        .getAllMonitoreoByIdProyectoDb(o, limit, offset);

    return aFind;
  }

  Future<TramaMonitoreoModel> insertMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    return await Get.find<MainRepository>().insertMonitorDb(o);
  }

  Future<int> deleteMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    final result = await Get.find<MainRepository>().deleteMonitorDb(o);
    return result;
  }

  /// USUARIO APP

  Future<UserModel> insertUserDb(UserModel o) async {
    UserModel? response = await Get.find<MainRepository>().insertUserDb(o);

    return response;
  }

  Future<List<UserModel>> loadAllUser(
    int? limit,
    int? offset,
  ) async {
    List<UserModel> aNewLoadUser = [];
    if (await isOnline()) {
      List<UserModel> aDb =
          await Get.find<MainRepository>().getAllUserDb(limit, offset);
      List<UserModel> aApi = await Get.find<MainRepository>().getAllUserApi();

      for (UserModel oApi in aApi) {
        if (aDb.length > 0) {
          UserModel oUserFind = aDb.firstWhere((o) => o.codigo == oApi.codigo);
          if (oUserFind != null) {
            continue;
          }
        }

        UserModel? response =
            await Get.find<MainRepository>().insertUserDb(oApi);
        if (response != null) {
          aNewLoadUser.add(response!);
        } else {
          _log.e('Error al ingresar usuario a la Base de Datos');
        }
      }
      _log.i('Nuevos usuarios cargados: ${aNewLoadUser.length}');
    }
    return aNewLoadUser;
  }

  Future<UserModel> getUserByCode(
    String codigo,
  ) async {
    try {
      UserModel oUser = await Get.find<MainRepository>().readUserByCode(codigo);
      return oUser;
    } catch (oError) {
      _log.e(oError);
    }
    return Future.error(
      'Usuario incorrecto, vuelve a intentarlo mas tarde.',
    );
  }
}
