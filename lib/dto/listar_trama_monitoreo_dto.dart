class TramaMonitoreo {
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

  TramaMonitoreo({
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

  static TramaMonitoreo fromJsonOne(Map<String, dynamic> json) {
    return TramaMonitoreo(
      snip: json['snip'],
      cui: json['cui'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      tambo: json['tambo'],
      fechaTerminoEstimado: json['fechaTerminoEstimado'],
      actividadPartidaEjecutada: json['actividadPartidaEjecutada'],
      alternativaSolucion: json['alternativaSolucion'],
      avanceFisicoAcumulado: json['avanceFisicoAcumulado'],
      avanceFisicoPartida: json['avanceFisicoPartida'],
      estadoAvance: json['estadoAvance'],
      estadoMonitoreo: json['estadoMonitoreo'],
      fechaMonitoreo: json['fechaMonitoreo'],
      idMonitoreo: json['idMonitoreo'],
      idUsuario: json['idUsuario'],
      imgActividad: json['imgActividad'],
      imgProblema: json['imgProblema'],
      imgRiesgo: json['imgRiesgo'],
      observaciones: json['observaciones'],
      problemaIdentificado: json['problemaIdentificado'],
      riesgoIdentificado: json['riesgoIdentificado'],
      rol: json['rol'],
      usuario: json['usuario'],
    );
  }

  factory TramaMonitoreo.fromJson(Map<String, dynamic> json) => TramaMonitoreo(
        snip: json['snip'],
        cui: json['cui'],
        latitud: json['latitud'],
        longitud: json['longitud'],
        tambo: json['tambo'],
        fechaTerminoEstimado: json['fechaTerminoEstimado'],
        actividadPartidaEjecutada: json['actividadPartidaEjecutada'],
        alternativaSolucion: json['alternativaSolucion'],
        avanceFisicoAcumulado: json['avanceFisicoAcumulado'],
        avanceFisicoPartida: json['avanceFisicoPartida'],
        estadoAvance: json['estadoAvance'],
        estadoMonitoreo: json['estadoMonitoreo'],
        fechaMonitoreo: json['fechaMonitoreo'],
        idMonitoreo: json['idMonitoreo'],
        idUsuario: json['idUsuario'],
        imgActividad: json['imgActividad'],
        imgProblema: json['imgProblema'],
        imgRiesgo: json['imgRiesgo'],
        observaciones: json['observaciones'],
        problemaIdentificado: json['problemaIdentificado'],
        riesgoIdentificado: json['riesgoIdentificado'],
        rol: json['rol'],
        usuario: json['usuario'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'snip': snip,
        'cui': cui,
        'latitud': latitud,
        'longitud': longitud,
        'tambo': tambo,
        'fechaTerminoEstimado': fechaTerminoEstimado,
        'actividadPartidaEjecutada': actividadPartidaEjecutada,
        'alternativaSolucion': alternativaSolucion,
        'avanceFisicoAcumulado': avanceFisicoAcumulado,
        'avanceFisicoPartida': avanceFisicoPartida,
        'estadoAvance': estadoAvance,
        'estadoMonitoreo': estadoMonitoreo,
        'fechaMonitoreo': fechaMonitoreo,
        'idMonitoreo': idMonitoreo,
        'idUsuario': idUsuario,
        'imgActividad': imgActividad,
        'imgProblema': imgProblema,
        'imgRiesgo': imgRiesgo,
        'observaciones': observaciones,
        'problemaIdentificado': problemaIdentificado,
        'riesgoIdentificado': riesgoIdentificado,
        'rol': rol,
        'usuario': usuario,
      };
}

// return (data as List).map((e) => TramaMonitoreo.fromJson(e)).toList();
