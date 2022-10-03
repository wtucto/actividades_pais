import 'dart:convert';

final String tableNameMonitoreo = 'listar_trama_monitoreo';

class TramaMonitoreoFields {
  static final List<String> values = [
    // Add all fields
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

  TramaMonitoreoModel({
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

  static TramaMonitoreoModel fromJsonOne(Map<String, dynamic> json) {
    return TramaMonitoreoModel(
      snip: json[TramaMonitoreoFields.snip],
      cui: json[TramaMonitoreoFields.cui],
      latitud: json[TramaMonitoreoFields.latitud],
      longitud: json[TramaMonitoreoFields.longitud],
      tambo: json[TramaMonitoreoFields.tambo],
      fechaTerminoEstimado: json[TramaMonitoreoFields.fechaTerminoEstimado],
      actividadPartidaEjecutada:
          json[TramaMonitoreoFields.actividadPartidaEjecutada],
      alternativaSolucion: json[TramaMonitoreoFields.alternativaSolucion],
      avanceFisicoAcumulado: json[TramaMonitoreoFields.avanceFisicoAcumulado],
      avanceFisicoPartida: json[TramaMonitoreoFields.avanceFisicoPartida],
      estadoAvance: json[TramaMonitoreoFields.estadoAvance],
      estadoMonitoreo: json[TramaMonitoreoFields.estadoMonitoreo],
      fechaMonitoreo: json[TramaMonitoreoFields.fechaMonitoreo],
      idMonitoreo: json[TramaMonitoreoFields.idMonitoreo],
      idUsuario: json[TramaMonitoreoFields.idUsuario],
      imgActividad: json[TramaMonitoreoFields.imgActividad],
      imgProblema: json[TramaMonitoreoFields.imgProblema],
      imgRiesgo: json[TramaMonitoreoFields.imgRiesgo],
      observaciones: json[TramaMonitoreoFields.observaciones],
      problemaIdentificado: json[TramaMonitoreoFields.problemaIdentificado],
      riesgoIdentificado: json[TramaMonitoreoFields.riesgoIdentificado],
      rol: json[TramaMonitoreoFields.rol],
      usuario: json[TramaMonitoreoFields.usuario],
    );
  }

  factory TramaMonitoreoModel.fromJson(Map<String, dynamic> json) =>
      TramaMonitoreoModel(
        snip: json[TramaMonitoreoFields.snip],
        cui: json[TramaMonitoreoFields.cui],
        latitud: json[TramaMonitoreoFields.latitud],
        longitud: json[TramaMonitoreoFields.longitud],
        tambo: json[TramaMonitoreoFields.tambo],
        fechaTerminoEstimado: json[TramaMonitoreoFields.fechaTerminoEstimado],
        actividadPartidaEjecutada:
            json[TramaMonitoreoFields.actividadPartidaEjecutada],
        alternativaSolucion: json[TramaMonitoreoFields.alternativaSolucion],
        avanceFisicoAcumulado: json[TramaMonitoreoFields.avanceFisicoAcumulado],
        avanceFisicoPartida: json[TramaMonitoreoFields.avanceFisicoPartida],
        estadoAvance: json[TramaMonitoreoFields.estadoAvance],
        estadoMonitoreo: json[TramaMonitoreoFields.estadoMonitoreo],
        fechaMonitoreo: json[TramaMonitoreoFields.fechaMonitoreo],
        idMonitoreo: json[TramaMonitoreoFields.idMonitoreo],
        idUsuario: json[TramaMonitoreoFields.idUsuario],
        imgActividad: json[TramaMonitoreoFields.imgActividad],
        imgProblema: json[TramaMonitoreoFields.imgProblema],
        imgRiesgo: json[TramaMonitoreoFields.imgRiesgo],
        observaciones: json[TramaMonitoreoFields.observaciones],
        problemaIdentificado: json[TramaMonitoreoFields.problemaIdentificado],
        riesgoIdentificado: json[TramaMonitoreoFields.riesgoIdentificado],
        rol: json[TramaMonitoreoFields.rol],
        usuario: json[TramaMonitoreoFields.usuario],
      );

  Map<String, Object?> toJson() => {
        //TramaMonitoreoFields.id: id,
        //TramaMonitoreoFields.isEdit: isEdit ? 1 : 0,
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

  static Map<String, dynamic?> toJsonObject(TramaMonitoreoModel o) {
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

  static List<Map<String, dynamic?>> toJsonArray(List<TramaMonitoreoModel> a) {
    List<Map<String, dynamic?>> aList = [];
    for (var item in a) {
      aList.add(TramaMonitoreoModel.toJsonObject(item));
    }
    return aList;
  }

  List<TramaMonitoreoModel> userFromJson(String sO) {
    final jsonData = json.decode(sO);
    return new List<TramaMonitoreoModel>.from(
        jsonData.map((x) => TramaMonitoreoModel.fromJson(x)));
  }

  String userToJson(List<TramaMonitoreoModel> a) {
    final dyn = new List<dynamic>.from(a.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}

// return (data as List).map((e) => TramaMonitoreo.fromJson(e)).toList();
