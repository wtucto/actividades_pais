import 'dart:convert';

final String tableNameTramaMonitoreos = 'listar_trama_monitoreo';

class TramaMonitoreoFields {
  static final List<String> values = [
    /// Add all fields
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
    rol,
    usuario,
  ];

  static final String id = '_id';
  static final String isEdit = 'isEdit';
  static final String time = 'time';

  static final String snip = 'snip';
  static final String cui = 'cui';
  static final String latitud = 'latitud';
  static final String longitud = 'longitud';
  static final String tambo = 'tambo';
  static final String fechaTerminoEstimado = 'fechaTerminoEstimado';
  static final String actividadPartidaEjecutada = 'actividadPartidaEjecutada';
  static final String alternativaSolucion = 'alternativaSolucion';
  static final String avanceFisicoAcumulado = 'avanceFisicoAcumulado';
  static final String avanceFisicoPartida = 'avanceFisicoPartida';
  static final String estadoAvance = 'estadoAvance';
  static final String estadoMonitoreo = 'estadoMonitoreo';
  static final String fechaMonitoreo = 'fechaMonitoreo';
  static final String idMonitoreo = 'idMonitoreo';
  static final String idUsuario = 'idUsuario';
  static final String imgActividad = 'imgActividad';
  static final String imgProblema = 'imgProblema';
  static final String imgRiesgo = 'imgRiesgo';
  static final String observaciones = 'observaciones';
  static final String problemaIdentificado = 'problemaIdentificado';
  static final String riesgoIdentificado = 'riesgoIdentificado';
  static final String rol = 'rol';
  static final String usuario = 'usuario';
}

class TramaMonitoreoModel {
  final int? id;
  final bool isEdit;
  final DateTime? createdTime;

  final String snip;
  final String cui;
  final String latitud;
  final String longitud;
  final String tambo;
  final String fechaTerminoEstimado;
  final String actividadPartidaEjecutada;
  final String alternativaSolucion;
  final String avanceFisicoAcumulado;
  final String avanceFisicoPartida;
  final String estadoAvance;
  final String estadoMonitoreo;
  final String fechaMonitoreo;
  final String idMonitoreo;
  final String idUsuario;
  final String imgActividad;
  final String imgProblema;
  final String imgRiesgo;
  final String observaciones;
  final String problemaIdentificado;
  final String riesgoIdentificado;
  final String rol;
  final String usuario;

  const TramaMonitoreoModel({
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
    required this.rol,
    required this.usuario,
  });

  TramaMonitoreoModel copy({
    int? id,
    bool? isEdit,
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
        rol: rol ?? this.rol,
        usuario: usuario ?? this.usuario,
      );

  static TramaMonitoreoModel fromJson(Map<String, Object?> json) =>
      TramaMonitoreoModel(
        id: json[TramaMonitoreoFields.id] as int?,
        isEdit: json[TramaMonitoreoFields.isEdit] == 1,
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
        rol: json[TramaMonitoreoFields.rol] as String,
        usuario: json[TramaMonitoreoFields.usuario] as String,
      );

  Map<String, dynamic> toJson() => {
        //TramaMonitoreoFields.id: id,
        TramaMonitoreoFields.isEdit: isEdit ? 1 : 0,
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
    return new List<TramaMonitoreoModel>.from(
        jsonData.map((x) => TramaMonitoreoModel.fromJson(x)));
  }

  String userToJson(List<TramaMonitoreoModel> aTramaMonitoreo) {
    final dyn = new List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
