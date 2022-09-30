class TramaProyecto {
  final String numSnip;
  final String cui;
  final String latitud;
  final String longitud;
  final String departamento;
  final String provincia;
  final String distrito;
  final String tambo;
  final String centroPoblado;
  final String estado;
  final String subEstado;
  final String estadoSaneamiento;
  final String modalidad;
  final String fechaInicio;
  final String fechaTerminoEstimado;
  final String inversion;
  final String costoEjecutado;
  final String costoEstimadoFinal;
  final String avanceFisico;
  final String residente;
  final String supervisor;
  final String crp;
  final String codResidente;
  final String codSupervisor;
  final String codCrp;

  TramaProyecto({
    required this.numSnip,
    required this.cui,
    required this.latitud,
    required this.longitud,
    required this.departamento,
    required this.provincia,
    required this.distrito,
    required this.tambo,
    required this.centroPoblado,
    required this.estado,
    required this.subEstado,
    required this.estadoSaneamiento,
    required this.modalidad,
    required this.fechaInicio,
    required this.fechaTerminoEstimado,
    required this.inversion,
    required this.costoEjecutado,
    required this.costoEstimadoFinal,
    required this.avanceFisico,
    required this.residente,
    required this.supervisor,
    required this.crp,
    required this.codResidente,
    required this.codSupervisor,
    required this.codCrp,
  });

  static TramaProyecto fromJsonOne(Map<String, dynamic> json) {
    return TramaProyecto(
      numSnip: json['numSnip'],
      cui: json['cui'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      departamento: json['departamento'],
      provincia: json['provincia'],
      distrito: json['distrito'],
      tambo: json['tambo'],
      centroPoblado: json['centroPoblado'],
      estado: json['estado'],
      subEstado: json['subEstado'],
      estadoSaneamiento: json['estadoSaneamiento'],
      modalidad: json['modalidad'],
      fechaInicio: json['fechaInicio'],
      fechaTerminoEstimado: json['fechaTerminoEstimado'],
      inversion: json['inversion'],
      costoEjecutado: json['costoEjecutado'],
      costoEstimadoFinal: json['costoEstimadoFinal'],
      avanceFisico: json['avanceFisico'],
      residente: json['residente'],
      supervisor: json['supervisor'],
      crp: json['crp'],
      codResidente: json['codResidente'],
      codSupervisor: json['codSupervisor'],
      codCrp: json['codCrp'],
    );
  }

  factory TramaProyecto.fromJson(Map<String, dynamic> json) => TramaProyecto(
        numSnip: json['numSnip'],
        cui: json['cui'],
        latitud: json['latitud'],
        longitud: json['longitud'],
        departamento: json['departamento'],
        provincia: json['provincia'],
        distrito: json['distrito'],
        tambo: json['tambo'],
        centroPoblado: json['centroPoblado'],
        estado: json['estado'],
        subEstado: json['subEstado'],
        estadoSaneamiento: json['estadoSaneamiento'],
        modalidad: json['modalidad'],
        fechaInicio: json['fechaInicio'],
        fechaTerminoEstimado: json['fechaTerminoEstimado'],
        inversion: json['inversion'],
        costoEjecutado: json['costoEjecutado'],
        costoEstimadoFinal: json['costoEstimadoFinal'],
        avanceFisico: json['avanceFisico'],
        residente: json['residente'],
        supervisor: json['supervisor'],
        crp: json['crp'],
        codResidente: json['codResidente'],
        codSupervisor: json['codSupervisor'],
        codCrp: json['codCrp'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'numSnip': numSnip,
        'cui': cui,
        'latitud': latitud,
        'longitud': longitud,
        'departamento': departamento,
        'provincia': provincia,
        'distrito': distrito,
        'tambo': tambo,
        'centroPoblado': centroPoblado,
        'estado': estado,
        'subEstado': subEstado,
        'estadoSaneamiento': estadoSaneamiento,
        'modalidad': modalidad,
        'fechaInicio': fechaInicio,
        'fechaTerminoEstimado': fechaTerminoEstimado,
        'inversion': inversion,
        'costoEjecutado': costoEjecutado,
        'costoEstimadoFinal': costoEstimadoFinal,
        'avanceFisico': avanceFisico,
        'residente': residente,
        'supervisor': supervisor,
        'crp': crp,
        'codResidente': codResidente,
        'codSupervisor': codSupervisor,
        'codCrp': codCrp,
      };
}

// return (data as List).map((e) => TramaProyecto.fromJson(e)).toList();
