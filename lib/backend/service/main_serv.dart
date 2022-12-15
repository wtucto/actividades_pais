import 'package:actividades_pais/backend/model/listar_combo_item.dart';
import 'package:actividades_pais/backend/model/listar_programa_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/model/tambo_model.dart';
import 'package:actividades_pais/backend/repository/main2_repo.dart';
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
   Obtiene los Items para los Combos
   @String sType 
   */
  Future<List<ComboItemModel>> getComboItemByType(
    String search,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<ComboItemModel> aFind = await Get.find<MainRepository>()
        .getAllComboItemByType(search, limit, offset);
    return aFind;
  }

/*
  Enviar los registros de Programacion a la Base de datos central mediante el 
  API REST.

  @ProgramacionIntervencionesModel a : Listado de Programaciones para enviar registros a la nube
  @ProgramacionIntervencionesModel e : Listado de Programaciones que fallaron al enviar
                           (Parametro solo valido para el metodo recursivo)

  CONSIDERACIONES:
  - Los estados de la Programacion deben de tener el estado: POR ENVIAR

  SECUENCIAS:
    LOOP ... 
      (1) - Se envia el registros de Programacion al API REST 
      (2) - Si el envio es correcto, se actualiza el registro en la DB Local al estado
        ENVIADO
      (3) - Responder con todos los registros enviados a la API REST
      (4) - Responder con todos los registros que generaron Error en la API REST
    END LOOP.
  */
  Future<List<ProgramacionActividadModel>> sendAllProgramaIntervencion(
    List<ProgramacionActividadModel> a,
    List<ProgramacionActividadModel>? e,
  ) async {
    bool isOnlines = await isOnline();
    if (isOnlines) {
      List<ProgramacionActividadModel> aResp = [];
      List<ProgramacionActividadModel> aError = e ?? [];
      List<ProgramacionActividadModel> aNoConect = [];

      for (var oMonit in a) {
        /// (1)...
        String estadoMonitoreo = oMonit.estadoProgramacion!;
        oMonit.estadoProgramacion = ProgramacionActividadModel.sEstadoPEN;

        if (isOnlines) {
          try {
            final oResp = await Get.find<MainRepository>()
                .insertProgramaIntervencion(oMonit);
            if (oResp.idProgramacionIntervenciones != "") {
              /// (2)...
              ProgramacionActividadModel? oSend = oResp;
              oSend.id = oMonit.id;
              await Get.find<MainRepository>()
                  .insertProgramaIntervencionDb(oSend);

              /// (3)...
              aResp.add(oSend);
            }
          } catch (oError) {
            oMonit.estadoProgramacion = estadoMonitoreo;

            /// (4)...
            aError.add(oMonit);

            ///Si falla volver a consultar si existe conexión
            isOnlines = await isOnline();
          }
        } else {
          /// (4)...
          oMonit.estadoProgramacion = estadoMonitoreo;
          aNoConect.add(oMonit);
        }
      }

      if (aNoConect.length > 0) {
        /**
         * Metodo recursivo: Solo reintentar los registros que no se enviaron
         * por perdida de conexión despues de 3 segundos
         */
        await Future.delayed(const Duration(seconds: 3));
        sendAllProgramaIntervencion(aNoConect, aError);
      }

      return aError;
    } else {
      return Future.error(
        '¡Ups! Algo salió mal, verifica tu conexión a Internet.',
      );
    }
  }

  /*
  Enviar los registros de monitoreo a la Base de datos central mediante el 
  API REST.

  @TramaMonitoreoModel a : Listado de Monitoreos para enviar registros a la nube
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
              await Get.find<MainRepository>().insertMonitorDb(oSend);

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

  Future<List<TramaMonitoreoModel>> getMonitoreoByTypePartida(
    TramaProyectoModel o,
    String sTypePartida,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind = await Get.find<MainRepository>()
        .getMonitoreoByTypePartida(o, sTypePartida);
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

      ///Obtiene los registros de la nube consumiento la API REST
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

  /// MAESTRAS
  Future<List<ComboItemModel>> loadAllMaestra(
    int? limit,
    int? offset,
  ) async {
    List<ComboItemModel> aNewMonitoreo = [];
    if (await isOnline()) {
      List<ComboItemModel> aDb = await Get.find<MainRepository>()
          .getAllComboItemByType('', limit, offset);

      List<ComboItemModel> aApi1 = await Get.find<MainRepository>()
          .getMaestraByType(ComboItemModel.cbASOLU);

      List<ComboItemModel> aApi2 = await Get.find<MainRepository>()
          .getMaestraByType(ComboItemModel.cbEAVAN);

      List<ComboItemModel> aApi3 = await Get.find<MainRepository>()
          .getMaestraByType(ComboItemModel.cbEMONI);

      List<ComboItemModel> aApi4 = await Get.find<MainRepository>()
          .getMaestraByType(ComboItemModel.cbNRIES);

      List<ComboItemModel> aApi5 = await Get.find<MainRepository>()
          .getMaestraByType(ComboItemModel.cbPEJEC);

      List<ComboItemModel> aApi6 = await Get.find<MainRepository>()
          .getMaestraByType(ComboItemModel.cbPIDEO);

      List<ComboItemModel> aApi7 = await Get.find<MainRepository>()
          .getMaestraByType(ComboItemModel.cbRIDEN);

      List<ComboItemModel> aApi = [];

      aApi.addAll(aApi1);
      aApi.addAll(aApi2);
      aApi.addAll(aApi3);
      aApi.addAll(aApi4);
      aApi.addAll(aApi5);
      aApi.addAll(aApi6);
      aApi.addAll(aApi7);

      for (ComboItemModel oApi in aApi) {
        if (aDb.isNotEmpty) {
          ComboItemModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere(
              (o) =>
                  o.idTypeItem == oApi.idTypeItem && o.codigo1 == oApi.codigo1,
              orElse: () => ComboItemModel.empty(),
            );
          } catch (oError) {
            _log.e(oError);
          }
          if (oDataFind != null || oDataFind!.id == 0) {
            oApi.id = oDataFind.id;
            oApi.isEdit = 0;
            await Get.find<MainRepository>().insertMaestraDb(oApi);

            continue;
          }
        }

        ComboItemModel? response =
            await Get.find<MainRepository>().insertMaestraDb(oApi);
        if (response != null) {
          aNewMonitoreo.add(response!);
        } else {
          _log.e('Error al ingresar Maestros a la Base de Datos');
        }
      }
      _log.i('Nuevos Maestros cargados: ${aNewMonitoreo.length}');
    }

    return aNewMonitoreo;
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
                Si el estado del monitoreo en la nube es diferente a la data local, 
                se actualiza el registro local.
               */
              oApi.id = oDataFind.id;
              oApi.isEdit = 0;
              await Get.find<MainRepository>().insertMonitorDb(oApi);
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

  Future<List<ProgramacionActividadModel>> getAllProgramaIntervencion(
    String id,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<ProgramacionActividadModel> aFind = await Get.find<MainRepository>()
        .getProgramaIntervencionDb(id, limit, offset);

    return aFind;
  }

  Future<ProgramacionActividadModel> insertProgramaIntervencionDb(
    ProgramacionActividadModel o,
  ) async {
    var oProgResp =
        await Get.find<MainRepository>().insertProgramaIntervencionDb(o);

    if (o.registroEntidadActividades!.isNotEmpty) {
      o.registroEntidadActividades!.forEach((object) {
        object.idProgramacionIntervenciones =
            oProgResp.idProgramacionIntervenciones;
      });

      var aActResp = await Get.find<MainRepository>()
          .insertRegistroEntidadActividadMasiveDb(
              o.registroEntidadActividades!);
      oProgResp.registroEntidadActividades = aActResp;
    }

    return oProgResp;
  }

  Future<int> deleteProgramaIntervencionDb(
    ProgramacionActividadModel o,
  ) async {
    final result =
        await Get.find<MainRepository>().deleteProgramaIntervencionDb(o);
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

  Future deleteAllData() async {
    return await Get.find<MainRepository>().deleteAllData();
  }

  Future deleteAllMonitorByEstadoENV() async {
    return await Get.find<MainRepository>().deleteAllMonitorByEstadoENV();
  }

  /*
   Obtiene todas las considencias de Tambos buscados por:
   @String search 
   */
  Future<List<TamboModel>> searchTambo(
    String? search,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TamboModel> aFind =
        await Get.find<Main2Repository>().searchTambo(search);
    return aFind;
  }
}
