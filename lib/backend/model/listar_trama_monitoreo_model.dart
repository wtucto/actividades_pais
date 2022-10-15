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
    imgActividad1,
    imgActividad2,
    imgActividad3,
    imgActividad4,
    imgProblema,
    imgProblema1,
    imgProblema2,
    imgProblema3,
    imgProblema4,
    imgRiesgo,
    imgRiesgo1,
    imgRiesgo2,
    imgRiesgo3,
    imgRiesgo4,
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
  static String imgActividad1 = 'imgActividad1';
  static String imgActividad2 = 'imgActividad2';
  static String imgActividad3 = 'imgActividad3';
  static String imgActividad4 = 'imgActividad4';
  static String imgProblema = 'imgProblema';
  static String imgProblema1 = 'imgProblema1';
  static String imgProblema2 = 'imgProblema2';
  static String imgProblema3 = 'imgProblema3';
  static String imgProblema4 = 'imgProblema4';
  static String imgRiesgo = 'imgRiesgo';
  static String imgRiesgo1 = 'imgRiesgo1';
  static String imgRiesgo2 = 'imgRiesgo2';
  static String imgRiesgo3 = 'imgRiesgo3';
  static String imgRiesgo4 = 'imgRiesgo4';
  static String observaciones = 'observaciones';
  static String problemaIdentificado = 'problemaIdentificado';
  static String riesgoIdentificado = 'riesgoIdentificado';
  static String nivelRiesgo = 'nivelRiesgo';
  static String rol = 'rol';
  static String usuario = 'usuario';
}

class TramaMonitoreoModel {
  static const sOptDropdownDefault = 'Seleccione una opción';

  static const sEstadoINC = 'INCOMPLETO';
  static const sEstadoPEN = 'POR ENVIAR';
  static const sEstadoENV = 'ENVIADO';
  static final List<String> aEstadoMonitoreo = [
    sEstadoINC,
    sEstadoPEN,
    sEstadoENV,
  ];

  static const sAltSol01 = 'Solicitar modificación de Exp. Técnico';
  static const sAltSol02 = 'Gestionar reunión de coordinación con UPS';
  static const sAltSol03 = 'Modificar programación de tareas (Fast track)';
  static const sAltSol04 = 'Modificar programación de tareas (Crashing)';
  static const sAltSol05 = 'Coordinación con el núcleo ejecutor';
  static const sAltSol06 = 'Gestionar recursos adicionales';
  static const sAltSol07 = 'Coordinar reunión con asesoría legal';
  static const sAltSol08 = 'Incrementar presupuesto para saneamiento legal';
  static final List<String> aAlternativaSolucion = [
    sOptDropdownDefault,
    sAltSol01,
    sAltSol02,
    sAltSol03,
    sAltSol04,
    sAltSol05,
    sAltSol06,
    sAltSol07,
    sAltSol08,
  ];

  static const sActPartEjec01 = 'Cimentación';
  static const sActPartEjec02 = 'Muros y Columnas';
  static const sActPartEjec03 = 'Techo y Acabados';
  static const sActPartEjec04 = 'obras Exteriores';
  static const sActPartEjec05 = 'Equipamiento';
  static final List<String> aActividadPartidaEjecutada = [
    sOptDropdownDefault,
    sActPartEjec01,
    sActPartEjec02,
    sActPartEjec03,
    sActPartEjec04,
    sActPartEjec05,
  ];

  static const sEstAvan01 = 'Ejecución';
  static const sEstAvan02 = 'Reinicio';
  static const sEstAvan03 = 'Paralizado';
  static const sEstAvan04 = 'Por iniciar';
  static final List<String> aEstadoAvance = [
    sOptDropdownDefault,
    sEstAvan01,
    sEstAvan02,
    sEstAvan03,
    sEstAvan04,
  ];

  static const sProbIden01 = 'Calculo inexacto en duración de las tareas';
  static const sProbIden02 = 'Retraso en plazos establecidos en el proyecto';
  static const sProbIden03 = 'Estimación inexacta de los costos';
  static const sProbIden04 = 'Núcleo ejector no rinde gastos';
  static const sProbIden05 = 'Limitados recursos y sobre utilizados';
  static const sProbIden06 = 'Terreno con problemas de saneamiento legal';
  static final List<String> aProblemaIdentificado = [
    sOptDropdownDefault,
    sProbIden01,
    sProbIden02,
    sProbIden03,
    sProbIden04,
    sProbIden05,
    sProbIden06,
  ];

  static const sRiesIden01 =
      'Incumplimiento de las características de los componentes';
  static const sRiesIden02 = 'Lluvias 1 deslizamientos / Clima';
  static const sRiesIden03 = 'Asignación de recursos y fondos fuera plazo';
  static const sRiesIden04 = 'Inadecuada estimación de costos';
  static const sRiesIden05 = 'Inadecuada programación';
  static const sRiesIden06 = 'Inadecuada comunicación con UPS';
  static final List<String> aRiesgoIdentificado = [
    sOptDropdownDefault,
    sRiesIden01,
    sRiesIden02,
    sRiesIden03,
    sRiesIden04,
    sRiesIden05,
    sRiesIden06,
  ];

  static const sNivelRies01 = 'Muy Bajo';
  static const sNivelRies02 = 'Bajo';
  static const sNivelRies03 = 'Medio';
  static const sNivelRies04 = 'Medio Alto';
  static const sNivelRies05 = 'Alto';
  static const sNivelRies06 = 'Muy Alto';
  static final List<String> aNivelRiesgo = [
    sOptDropdownDefault,
    sNivelRies01,
    sNivelRies02,
    sNivelRies03,
    sNivelRies04,
    sNivelRies05,
    sNivelRies06,
  ];

/*
"fechaMonitoreo": "2022-06-01 00:00:00.0",



"imgActividad1": "/opt/uploads/8000002492.docx",
"imgActividad2": "/opt/uploads/8000002497.docx",
"imgActividad3": "/opt/uploads/8000002765.docx",
"imgActividad4": "/opt/uploads/8000002765.docx",

"imgProblema1": "/opt/uploads/8000002492.docx",
"imgProblema2": "/opt/uploads/8000002497.docx",
"imgProblema3": "/opt/uploads/8000002765.docx",
"imgProblema4": "/opt/uploads/8000002765.docx",

"imgRiesgo1": "/opt/uploads/8000002765.docx",
"imgRiesgo2": "/opt/uploads/8000002497.docx",
"imgRiesgo3": "",
"imgRiesgo4": "",
*/
  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime = null;

  ///identificador autogenerado (CUI_IDE_FechaMonitoreo)
  String? idMonitoreo = '';

  /// Código único del proyecto
  String? cui = '';

  /// Código de SNIP del proyecto
  String? snip = '';

  /// nombre del proyecto
  String? tambo = '';

  ///(Obligatorio) Latitud del monitoreo: si el APP está en OnLine: se debe obtener automáticamente. Si el APP está en Offline: no se muestra valor.
  String? latitud = '';

  /// (Obligatorio) Longitud del monitoreo: si el APP está en OnLine: se debe obtener automáticamente. Si el APP está en Offline: no se muestra valor.
  String? longitud = '';

  /// (Obligatorio) Fecha Termino Estimada Obra: se obtiene de los datos generales del proyecto como referencia, y luego el usuario puede modificar su valor.
  String? fechaTerminoEstimado = '';

  /// (Obligatorio) Partida ejecutada: selección de partida
  String? actividadPartidaEjecutada = '';

  /// (Obligatorio) Alternativa de Solución: selección de la solución.
  String? alternativaSolucion = '';

  /// (Obligatorio) % Avance Físico Estimado Acumulado: se obtiene de los datos generales del proyecto como referencia, y luego el usuario puede modificar su valor.
  double? avanceFisicoAcumulado = 0;

  ///% Av. Físico Acum. Partida: % Avance Físico acumulado de la partida
  double? avanceFisicoPartida = 0;

  /// (Obligatorio) Estado de Avance: selección del estado.
  String? estadoAvance = '';

  /// Estado del Registro del Monitoreo
  String? estadoMonitoreo = '';

  /// (Obligatorio) se muestra la fecha del sistema APP por defecto (sólo lectura).
  String? fechaMonitoreo = '';

  // (Obligatorio) Fotos de la partida ejecutada
  String? imgActividad = '';
  String? imgActividad1 = '';
  String? imgActividad2 = '';
  String? imgActividad3 = '';
  String? imgActividad4 = '';

  /// (Opcional) Fotos del problema identificado
  String? imgProblema = '';
  String? imgProblema1 = '';
  String? imgProblema2 = '';
  String? imgProblema3 = '';
  String? imgProblema4 = '';

  /// (Opcional) Fotos del riesgo identificado
  String? imgRiesgo = '';
  String? imgRiesgo1 = '';
  String? imgRiesgo2 = '';
  String? imgRiesgo3 = '';
  String? imgRiesgo4 = '';

  /// Observaciones: descripción de la observación sobre la ejecución de la partida
  String? observaciones = '';

  /// (Obligatorio) Problema identificado: selección del problema identificado en la obra.
  String? problemaIdentificado = '';

  /// (Opcional) Riesgo Identificado: selección del riesgo identificado.
  String? riesgoIdentificado = '';

  /// (Opcional) Nivel de Riesgo: selección del nivel de riesgo.
  String? nivelRiesgo = '';

  String? idUsuario = '';
  String? usuario = '';
  String? rol = '';

  TramaMonitoreoModel.empty() {}

  TramaMonitoreoModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.snip,
    this.cui,
    this.latitud,
    this.longitud,
    this.tambo,
    this.fechaTerminoEstimado,
    this.actividadPartidaEjecutada,
    this.alternativaSolucion,
    this.avanceFisicoAcumulado,
    this.avanceFisicoPartida,
    this.estadoAvance,
    this.estadoMonitoreo,
    this.fechaMonitoreo,
    this.idMonitoreo,
    this.idUsuario,
    this.imgActividad,
    this.imgActividad1,
    this.imgActividad2,
    this.imgActividad3,
    this.imgActividad4,
    this.imgProblema,
    this.imgProblema1,
    this.imgProblema2,
    this.imgProblema3,
    this.imgProblema4,
    this.imgRiesgo,
    this.imgRiesgo1,
    this.imgRiesgo2,
    this.imgRiesgo3,
    this.imgRiesgo4,
    this.observaciones,
    this.problemaIdentificado,
    this.riesgoIdentificado,
    this.nivelRiesgo,
    this.rol,
    this.usuario,
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
    double? avanceFisicoAcumulado,
    double? avanceFisicoPartida,
    String? estadoAvance,
    String? estadoMonitoreo,
    String? fechaMonitoreo,
    String? idMonitoreo,
    String? idUsuario,
    String? imgActividad,
    String? imgActividad1,
    String? imgActividad2,
    String? imgActividad3,
    String? imgActividad4,
    String? imgProblema,
    String? imgProblema1,
    String? imgProblema2,
    String? imgProblema3,
    String? imgProblema4,
    String? imgRiesgo,
    String? imgRiesgo1,
    String? imgRiesgo2,
    String? imgRiesgo3,
    String? imgRiesgo4,
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
        imgActividad1: imgActividad ?? this.imgActividad1,
        imgActividad2: imgActividad ?? this.imgActividad2,
        imgActividad3: imgActividad ?? this.imgActividad3,
        imgActividad4: imgActividad ?? this.imgActividad4,
        imgProblema: imgProblema ?? this.imgProblema,
        imgProblema1: imgProblema ?? this.imgProblema1,
        imgProblema2: imgProblema ?? this.imgProblema2,
        imgProblema3: imgProblema ?? this.imgProblema3,
        imgProblema4: imgProblema ?? this.imgProblema4,
        imgRiesgo: imgRiesgo ?? this.imgRiesgo,
        imgRiesgo1: imgRiesgo ?? this.imgRiesgo1,
        imgRiesgo2: imgRiesgo ?? this.imgRiesgo2,
        imgRiesgo3: imgRiesgo ?? this.imgRiesgo3,
        imgRiesgo4: imgRiesgo ?? this.imgRiesgo4,
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
        avanceFisicoAcumulado: double.parse(
            (json[TramaMonitoreoFields.avanceFisicoAcumulado] ?? "0")
                .toString()),
        avanceFisicoPartida: double.parse(
            (json[TramaMonitoreoFields.avanceFisicoPartida] ?? "0").toString()),
        estadoAvance: json[TramaMonitoreoFields.estadoAvance] as String,
        estadoMonitoreo: json[TramaMonitoreoFields.estadoMonitoreo] as String,
        fechaMonitoreo: json[TramaMonitoreoFields.fechaMonitoreo] as String,
        idMonitoreo: json[TramaMonitoreoFields.idMonitoreo] as String,
        idUsuario: json[TramaMonitoreoFields.idUsuario] as String,
        imgActividad: json[TramaMonitoreoFields.imgActividad] as String?,
        imgActividad1: json[TramaMonitoreoFields.imgActividad1] as String?,
        imgActividad2: json[TramaMonitoreoFields.imgActividad2] as String?,
        imgActividad3: json[TramaMonitoreoFields.imgActividad3] as String?,
        imgActividad4: json[TramaMonitoreoFields.imgActividad4] as String?,
        imgProblema: json[TramaMonitoreoFields.imgProblema] as String?,
        imgProblema1: json[TramaMonitoreoFields.imgProblema1] as String?,
        imgProblema2: json[TramaMonitoreoFields.imgProblema2] as String?,
        imgProblema3: json[TramaMonitoreoFields.imgProblema3] as String?,
        imgProblema4: json[TramaMonitoreoFields.imgProblema4] as String?,
        imgRiesgo: json[TramaMonitoreoFields.imgRiesgo] as String?,
        imgRiesgo1: json[TramaMonitoreoFields.imgRiesgo1] as String?,
        imgRiesgo2: json[TramaMonitoreoFields.imgRiesgo2] as String?,
        imgRiesgo3: json[TramaMonitoreoFields.imgRiesgo3] as String?,
        imgRiesgo4: json[TramaMonitoreoFields.imgRiesgo4] as String?,
        observaciones: json[TramaMonitoreoFields.observaciones] as String,
        problemaIdentificado:
            json[TramaMonitoreoFields.problemaIdentificado] as String,
        riesgoIdentificado:
            json[TramaMonitoreoFields.riesgoIdentificado] as String,
        nivelRiesgo: json[TramaMonitoreoFields.nivelRiesgo] != null
            ? json[TramaMonitoreoFields.nivelRiesgo] as String
            : '',
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
        TramaMonitoreoFields.imgActividad1: imgActividad1,
        TramaMonitoreoFields.imgActividad2: imgActividad2,
        TramaMonitoreoFields.imgActividad3: imgActividad3,
        TramaMonitoreoFields.imgActividad4: imgActividad4,
        TramaMonitoreoFields.imgProblema: imgProblema,
        TramaMonitoreoFields.imgProblema1: imgProblema1,
        TramaMonitoreoFields.imgProblema2: imgProblema2,
        TramaMonitoreoFields.imgProblema3: imgProblema3,
        TramaMonitoreoFields.imgProblema4: imgProblema4,
        TramaMonitoreoFields.imgRiesgo: imgRiesgo,
        TramaMonitoreoFields.imgRiesgo1: imgRiesgo1,
        TramaMonitoreoFields.imgRiesgo2: imgRiesgo2,
        TramaMonitoreoFields.imgRiesgo3: imgRiesgo3,
        TramaMonitoreoFields.imgRiesgo4: imgRiesgo4,
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
      TramaMonitoreoFields.imgActividad1: o.imgActividad1,
      TramaMonitoreoFields.imgActividad2: o.imgActividad2,
      TramaMonitoreoFields.imgActividad3: o.imgActividad3,
      TramaMonitoreoFields.imgActividad4: o.imgActividad4,
      TramaMonitoreoFields.imgProblema: o.imgProblema,
      TramaMonitoreoFields.imgProblema1: o.imgProblema1,
      TramaMonitoreoFields.imgProblema2: o.imgProblema2,
      TramaMonitoreoFields.imgProblema3: o.imgProblema3,
      TramaMonitoreoFields.imgProblema4: o.imgProblema4,
      TramaMonitoreoFields.imgRiesgo: o.imgRiesgo,
      TramaMonitoreoFields.imgRiesgo1: o.imgRiesgo1,
      TramaMonitoreoFields.imgRiesgo2: o.imgRiesgo2,
      TramaMonitoreoFields.imgRiesgo3: o.imgRiesgo3,
      TramaMonitoreoFields.imgRiesgo4: o.imgRiesgo4,
      TramaMonitoreoFields.observaciones: o.observaciones,
      TramaMonitoreoFields.problemaIdentificado: o.problemaIdentificado,
      TramaMonitoreoFields.riesgoIdentificado: o.riesgoIdentificado,
      TramaMonitoreoFields.nivelRiesgo: o.nivelRiesgo,
      TramaMonitoreoFields.rol: o.rol,
      TramaMonitoreoFields.usuario: o.usuario,
    };
  }

  static Map<String, dynamic> toJsonObjectApi(TramaMonitoreoModel o) {
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
      TramaMonitoreoFields.observaciones: o.observaciones,
      TramaMonitoreoFields.problemaIdentificado: o.problemaIdentificado,
      TramaMonitoreoFields.riesgoIdentificado: o.riesgoIdentificado,
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
