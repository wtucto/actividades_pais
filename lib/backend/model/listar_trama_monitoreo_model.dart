import 'dart:convert';

String tableNameTramaMonitoreos = 'listar_trama_monitoreo';

class TramaMonitoreoFields {
  static final List<String> values = [
    ////Add all fields
    id,
    isEdit,
    time,

    snip,
    cui,
    latitud,
    longitud,
    tambo,
    fechaTerminoEstimado,
    actividadPartidaEjecutada,
    alternativaSolucion,
    avanceFisicoAcumulado,
    avanceFisicoPartida,
    estadoAvance,
    estadoMonitoreo,
    fechaMonitoreo,
    idMonitoreo,
    idUsuario,
    imgActividad,
    imgProblema,
    imgRiesgo,
    observaciones,
    problemaIdentificado,
    riesgoIdentificado,
    nivelRiesgo,
    rol,
    usuario,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String snip = 'snip';
  static String cui = 'cui';
  static String latitud = 'latitud';
  static String longitud = 'longitud';
  static String tambo = 'tambo';
  static String fechaTerminoEstimado = 'fechaTerminoEstimado';
  static String actividadPartidaEjecutada = 'actividadPartidaEjecutada';
  static String alternativaSolucion = 'alternativaSolucion';
  static String avanceFisicoAcumulado = 'avanceFisicoAcumulado';
  static String avanceFisicoPartida = 'avanceFisicoPartida';
  static String estadoAvance = 'estadoAvance';
  static String estadoMonitoreo = 'estadoMonitoreo';
  static String fechaMonitoreo = 'fechaMonitoreo';
  static String idMonitoreo = 'idMonitoreo';
  static String idUsuario = 'idUsuario';
  static String imgActividad = 'imgActividad';
  static String imgProblema = 'imgProblema';
  static String imgRiesgo = 'imgRiesgo';
  static String observaciones = 'observaciones';
  static String problemaIdentificado = 'problemaIdentificado';
  static String riesgoIdentificado = 'riesgoIdentificado';
  static String nivelRiesgo = 'nivelRiesgo';
  static String rol = 'rol';
  static String usuario = 'usuario';
}

class TramaMonitoreoModel {
  static final sEstadoINC = "INCOMPLETO";
  static final sEstadoPEN = "POR ENVIAR";
  static final sEstadoENV = "ENVIADO";

  static final List<String> statusLocal = [
    sEstadoINC,
    sEstadoPEN,
    sEstadoENV,
  ];

  int? id = 0;
  int isEdit = 0;
  DateTime? createdTime = null;

  ///identificador autogenerado (CUI_IDE_FechaMonitoreo)
  String idMonitoreo = "";

  /// Código de SNIP del proyecto
  String snip = "";

  /// Código único del proyecto
  String cui = "";

  /// nombre del proyecto
  String tambo = "";

  ///(Obligatorio) Latitud del monitoreo: si el APP está en OnLine: se debe obtener automáticamente. Si el APP está en Offline: no se muestra valor.
  String latitud = "";

  /// (Obligatorio) Longitud del monitoreo: si el APP está en OnLine: se debe obtener automáticamente. Si el APP está en Offline: no se muestra valor.
  String longitud = "";

  /// (Obligatorio) Fecha Termino Estimada Obra: se obtiene de los datos generales del proyecto como referencia, y luego el usuario puede modificar su valor.
  String fechaTerminoEstimado = "";

  /// (Obligatorio) Partida ejecutada: selección de partida (Cimentación, Muros y Columnas, Techo y Acabados, bras Exteriores, Equipamiento)
  String actividadPartidaEjecutada = "";

  /// (Obligatorio) Alternativa de Solución: selección de la solución (Solicitar modificación de Exp. Técnico, Gestionar reunión de coordinación con UPS, Modificar programación de tareas (Fast track), Modificar programación de tareas (Crashing), Coordinación con el núcleo ejecutor, Gestionar recursos adicionales, Coordinar reunión con asesoría legal, Incrementar presupuesto para saneamiento legal ).
  String alternativaSolucion = "";

  /// (Obligatorio) % Avance Físico Estimado Acumulado: se obtiene de los datos generales del proyecto como referencia, y luego el usuario puede modificar su valor.
  String avanceFisicoAcumulado = "";

  ///% Av. Físico Acum. Partida: % Avance Físico acumulado de la partida
  String avanceFisicoPartida = "";

  /// (Obligatorio) Estado de Avance: selección del estado: Ejecución, Reinicio, Paralizado, Por iniciar.
  String estadoAvance = "";

  ///Estado del Registro del Monitoreo: incompleto, por Enviar, Enviado
  String estadoMonitoreo = "";

  /// (Obligatorio) se muestra la fecha del sistema APP por defecto (sólo lectura).
  String fechaMonitoreo = "";

  // (Obligatorio) Fotos de la partida ejecutada
  String imgActividad = "";

  /// (Opcional) Fotos del problema identificado
  String imgProblema = "";

  /// (Opcional) Fotos del riesgo identificado
  String imgRiesgo = "";

  /// Observaciones: descripción de la observación sobre la ejecución de la partida
  String observaciones = "";

  /// (Obligatorio) Problema identificado: selección del problema identificado en la obra (Calculo inexacto en duración de las tareas, Retraso en plazos establecidos en el proyecto, Estimación inexacta de los costos, Núcleo ejector no rinde gastos, Limitados recursos y sobre utilizados, Terreno con problemas de saneamiento legal).
  String problemaIdentificado = "";

  /// (Opcional) Riesgo Identificado: selección del riesgo identificado (Incumplimiento de las características de los componentes, Lluvias 1 deslizamientos / Clima, Asignación de recursos y fondos fuera plazo, Inadecuada estimación de costos, Inadecuada programación, Inadecuada comunicación con UPS).
  String riesgoIdentificado = "";

  /// (Opcional) Nivel de Riesgo: selección del nivel de riesgo: Muy Bajo, Bajo, Medio, Medio Alto, Alto, Muy Alto.
  String nivelRiesgo = "";

  String idUsuario = "";
  String usuario = "";
  String rol = "";

  TramaMonitoreoModel.empty() {}

  TramaMonitoreoModel({
    required this.id,
    required this.isEdit,
    required this.createdTime,
    required this.snip,
    required this.cui,
    required this.latitud,
    required this.longitud,
    required this.tambo,
    required this.fechaTerminoEstimado,
    required this.actividadPartidaEjecutada,
    required this.alternativaSolucion,
    required this.avanceFisicoAcumulado,
    required this.avanceFisicoPartida,
    required this.estadoAvance,
    required this.estadoMonitoreo,
    required this.fechaMonitoreo,
    required this.idMonitoreo,
    required this.idUsuario,
    required this.imgActividad,
    required this.imgProblema,
    required this.imgRiesgo,
    required this.observaciones,
    required this.problemaIdentificado,
    required this.riesgoIdentificado,
    required this.nivelRiesgo,
    required this.rol,
    required this.usuario,
  });

  TramaMonitoreoModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? snip,
    String? cui,
    String? latitud,
    String? longitud,
    String? tambo,
    String? fechaTerminoEstimado,
    String? actividadPartidaEjecutada,
    String? alternativaSolucion,
    String? avanceFisicoAcumulado,
    String? avanceFisicoPartida,
    String? estadoAvance,
    String? estadoMonitoreo,
    String? fechaMonitoreo,
    String? idMonitoreo,
    String? idUsuario,
    String? imgActividad,
    String? imgProblema,
    String? imgRiesgo,
    String? observaciones,
    String? problemaIdentificado,
    String? riesgoIdentificado,
    String? nivelRiesgo,
    String? rol,
    String? usuario,
  }) =>
      TramaMonitoreoModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        snip: snip ?? this.snip,
        cui: cui ?? this.cui,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        tambo: tambo ?? this.tambo,
        fechaTerminoEstimado: fechaTerminoEstimado ?? this.fechaTerminoEstimado,
        actividadPartidaEjecutada:
            actividadPartidaEjecutada ?? this.actividadPartidaEjecutada,
        alternativaSolucion: alternativaSolucion ?? this.alternativaSolucion,
        avanceFisicoAcumulado:
            avanceFisicoAcumulado ?? this.avanceFisicoAcumulado,
        avanceFisicoPartida: avanceFisicoPartida ?? this.avanceFisicoPartida,
        estadoAvance: estadoAvance ?? this.estadoAvance,
        estadoMonitoreo: estadoMonitoreo ?? this.estadoMonitoreo,
        fechaMonitoreo: fechaMonitoreo ?? this.fechaMonitoreo,
        idMonitoreo: idMonitoreo ?? this.idMonitoreo,
        idUsuario: idUsuario ?? this.idUsuario,
        imgActividad: imgActividad ?? this.imgActividad,
        imgProblema: imgProblema ?? this.imgProblema,
        imgRiesgo: imgRiesgo ?? this.imgRiesgo,
        observaciones: observaciones ?? this.observaciones,
        problemaIdentificado: problemaIdentificado ?? this.problemaIdentificado,
        riesgoIdentificado: riesgoIdentificado ?? this.riesgoIdentificado,
        nivelRiesgo: nivelRiesgo ?? this.nivelRiesgo,
        rol: rol ?? this.rol,
        usuario: usuario ?? this.usuario,
      );

  static TramaMonitoreoModel fromJson(Map<String, Object?> json) =>
      TramaMonitoreoModel(
        id: json[TramaMonitoreoFields.id] as int?,
        isEdit: json[TramaMonitoreoFields.isEdit] == null
            ? 0
            : json[TramaMonitoreoFields.isEdit] as int,
        createdTime: json[TramaMonitoreoFields.time] != null
            ? DateTime.parse(json[TramaMonitoreoFields.time] as String)
            : null,
        snip: json[TramaMonitoreoFields.snip] as String,
        cui: json[TramaMonitoreoFields.cui] as String,
        latitud: json[TramaMonitoreoFields.latitud] as String,
        longitud: json[TramaMonitoreoFields.longitud] as String,
        tambo: json[TramaMonitoreoFields.tambo] as String,
        fechaTerminoEstimado:
            json[TramaMonitoreoFields.fechaTerminoEstimado] as String,
        actividadPartidaEjecutada:
            json[TramaMonitoreoFields.actividadPartidaEjecutada] as String,
        alternativaSolucion:
            json[TramaMonitoreoFields.alternativaSolucion] as String,
        avanceFisicoAcumulado:
            json[TramaMonitoreoFields.avanceFisicoAcumulado] as String,
        avanceFisicoPartida:
            json[TramaMonitoreoFields.avanceFisicoPartida] as String,
        estadoAvance: json[TramaMonitoreoFields.estadoAvance] as String,
        estadoMonitoreo: json[TramaMonitoreoFields.estadoMonitoreo] as String,
        fechaMonitoreo: json[TramaMonitoreoFields.fechaMonitoreo] as String,
        idMonitoreo: json[TramaMonitoreoFields.idMonitoreo] as String,
        idUsuario: json[TramaMonitoreoFields.idUsuario] as String,
        imgActividad: json[TramaMonitoreoFields.imgActividad] as String,
        imgProblema: json[TramaMonitoreoFields.imgProblema] as String,
        imgRiesgo: json[TramaMonitoreoFields.imgRiesgo] as String,
        observaciones: json[TramaMonitoreoFields.observaciones] as String,
        problemaIdentificado:
            json[TramaMonitoreoFields.problemaIdentificado] as String,
        riesgoIdentificado:
            json[TramaMonitoreoFields.riesgoIdentificado] as String,
        nivelRiesgo: json[TramaMonitoreoFields.nivelRiesgo] != null
            ? json[TramaMonitoreoFields.nivelRiesgo] as String
            : "",
        rol: json[TramaMonitoreoFields.rol] as String,
        usuario: json[TramaMonitoreoFields.usuario] as String,
      );

  Map<String, dynamic> toJson() => {
        //TramaMonitoreoFields.id: id,
        TramaMonitoreoFields.isEdit: isEdit,
        //TramaMonitoreoFields.time: createdTime.toIso8601String(),
        TramaMonitoreoFields.snip: snip,
        TramaMonitoreoFields.cui: cui,
        TramaMonitoreoFields.latitud: latitud,
        TramaMonitoreoFields.longitud: longitud,
        TramaMonitoreoFields.tambo: tambo,
        TramaMonitoreoFields.fechaTerminoEstimado: fechaTerminoEstimado,
        TramaMonitoreoFields.actividadPartidaEjecutada:
            actividadPartidaEjecutada,
        TramaMonitoreoFields.alternativaSolucion: alternativaSolucion,
        TramaMonitoreoFields.avanceFisicoAcumulado: avanceFisicoAcumulado,
        TramaMonitoreoFields.avanceFisicoPartida: avanceFisicoPartida,
        TramaMonitoreoFields.estadoAvance: estadoAvance,
        TramaMonitoreoFields.estadoMonitoreo: estadoMonitoreo,
        TramaMonitoreoFields.fechaMonitoreo: fechaMonitoreo,
        TramaMonitoreoFields.idMonitoreo: idMonitoreo,
        TramaMonitoreoFields.idUsuario: idUsuario,
        TramaMonitoreoFields.imgActividad: imgActividad,
        TramaMonitoreoFields.imgProblema: imgProblema,
        TramaMonitoreoFields.imgRiesgo: imgRiesgo,
        TramaMonitoreoFields.observaciones: observaciones,
        TramaMonitoreoFields.problemaIdentificado: problemaIdentificado,
        TramaMonitoreoFields.riesgoIdentificado: riesgoIdentificado,
        TramaMonitoreoFields.nivelRiesgo: nivelRiesgo,

        TramaMonitoreoFields.rol: rol,
        TramaMonitoreoFields.usuario: usuario,
      };

  static Map<String, dynamic> toJsonObject(TramaMonitoreoModel o) {
    return {
      TramaMonitoreoFields.snip: o.snip,
      TramaMonitoreoFields.cui: o.cui,
      TramaMonitoreoFields.latitud: o.latitud,
      TramaMonitoreoFields.longitud: o.longitud,
      TramaMonitoreoFields.tambo: o.tambo,
      TramaMonitoreoFields.fechaTerminoEstimado: o.fechaTerminoEstimado,
      TramaMonitoreoFields.actividadPartidaEjecutada:
          o.actividadPartidaEjecutada,
      TramaMonitoreoFields.alternativaSolucion: o.alternativaSolucion,
      TramaMonitoreoFields.avanceFisicoAcumulado: o.avanceFisicoAcumulado,
      TramaMonitoreoFields.avanceFisicoPartida: o.avanceFisicoPartida,
      TramaMonitoreoFields.estadoAvance: o.estadoAvance,
      TramaMonitoreoFields.estadoMonitoreo: o.estadoMonitoreo,
      TramaMonitoreoFields.fechaMonitoreo: o.fechaMonitoreo,
      TramaMonitoreoFields.idMonitoreo: o.idMonitoreo,
      TramaMonitoreoFields.idUsuario: o.idUsuario,
      TramaMonitoreoFields.imgActividad: o.imgActividad,
      TramaMonitoreoFields.imgProblema: o.imgProblema,
      TramaMonitoreoFields.imgRiesgo: o.imgRiesgo,
      TramaMonitoreoFields.observaciones: o.observaciones,
      TramaMonitoreoFields.problemaIdentificado: o.problemaIdentificado,
      TramaMonitoreoFields.riesgoIdentificado: o.riesgoIdentificado,
      TramaMonitoreoFields.nivelRiesgo: o.nivelRiesgo,
      TramaMonitoreoFields.rol: o.rol,
      TramaMonitoreoFields.usuario: o.usuario,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<TramaMonitoreoModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(TramaMonitoreoModel.toJsonObject(item));
    }
    return aList;
  }

  List<TramaMonitoreoModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<TramaMonitoreoModel>.from(
        jsonData.map((x) => TramaMonitoreoModel.fromJson(x)));
  }

  String userToJson(List<TramaMonitoreoModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
