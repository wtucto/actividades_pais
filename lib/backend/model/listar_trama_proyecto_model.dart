import 'dart:convert';

final String tableNameTramaProyectos = 'listar_trama_proyecto';

class TramaProyectoFields {
  static final List<String> values = [
    /// Add all fields
    id,
    isEdit,
    time,
    numSnip,
    cui,
    latitud,
    longitud,
    departamento,
    provincia,
    distrito,
    tambo,
    centroPoblado,
    estado,
    subEstado,
    estadoSaneamiento,
    modalidad,
    fechaInicio,
    fechaTerminoEstimado,
    inversion,
    costoEjecutado,
    costoEstimadoFinal,
    avanceFisico,
    residente,
    supervisor,
    crp,
    codResidente,
    codSupervisor,
    codCrp,
  ];

  static final String id = '_id';
  static final String isEdit = 'isEdit';
  static final String time = 'time';

  static final String numSnip = 'numSnip';
  static final String cui = 'cui';
  static final String latitud = 'latitud';
  static final String longitud = 'longitud';
  static final String departamento = 'departamento';
  static final String provincia = 'provincia';
  static final String distrito = 'distrito';
  static final String tambo = 'tambo';
  static final String centroPoblado = 'centroPoblado';
  static final String estado = 'estado';
  static final String subEstado = 'subEstado';
  static final String estadoSaneamiento = 'estadoSaneamiento';
  static final String modalidad = 'modalidad';
  static final String fechaInicio = 'fechaInicio';
  static final String fechaTerminoEstimado = 'fechaTerminoEstimado';
  static final String inversion = 'inversion';
  static final String costoEjecutado = 'costoEjecutado';
  static final String costoEstimadoFinal = 'costoEstimadoFinal';
  static final String avanceFisico = 'avanceFisico';
  static final String residente = 'residente';
  static final String supervisor = 'supervisor';
  static final String crp = 'crp';
  static final String codResidente = 'codResidente';
  static final String codSupervisor = 'codSupervisor';
  static final String codCrp = 'codCrp';
}

class TramaProyectoModel {
  final int? id;
  final bool isEdit;
  final DateTime? createdTime;

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

  const TramaProyectoModel({
    required this.id,
    required this.isEdit,
    required this.createdTime,
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

  TramaProyectoModel copy({
    int? id,
    bool? isEdit,
    DateTime? createdTime,
    String? numSnip,
    String? cui,
    String? latitud,
    String? longitud,
    String? departamento,
    String? provincia,
    String? distrito,
    String? tambo,
    String? centroPoblado,
    String? estado,
    String? subEstado,
    String? estadoSaneamiento,
    String? modalidad,
    String? fechaInicio,
    String? fechaTerminoEstimado,
    String? inversion,
    String? costoEjecutado,
    String? costoEstimadoFinal,
    String? avanceFisico,
    String? residente,
    String? supervisor,
    String? crp,
    String? codResidente,
    String? codSupervisor,
    String? codCrp,
  }) =>
      TramaProyectoModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        numSnip: numSnip ?? this.numSnip,
        cui: cui ?? this.cui,
        latitud: latitud ?? this.latitud,
        longitud: longitud ?? this.longitud,
        departamento: departamento ?? this.departamento,
        provincia: provincia ?? this.provincia,
        distrito: distrito ?? this.distrito,
        tambo: tambo ?? this.tambo,
        centroPoblado: centroPoblado ?? this.centroPoblado,
        estado: estado ?? this.estado,
        subEstado: subEstado ?? this.subEstado,
        estadoSaneamiento: estadoSaneamiento ?? this.estadoSaneamiento,
        modalidad: modalidad ?? this.modalidad,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        fechaTerminoEstimado: fechaTerminoEstimado ?? this.fechaTerminoEstimado,
        inversion: inversion ?? this.inversion,
        costoEjecutado: costoEjecutado ?? this.costoEjecutado,
        costoEstimadoFinal: costoEstimadoFinal ?? this.costoEstimadoFinal,
        avanceFisico: avanceFisico ?? this.avanceFisico,
        residente: residente ?? this.residente,
        supervisor: supervisor ?? this.supervisor,
        crp: crp ?? this.crp,
        codResidente: codResidente ?? this.codResidente,
        codSupervisor: codSupervisor ?? this.codSupervisor,
        codCrp: codCrp ?? this.codCrp,
      );

  static TramaProyectoModel fromJson(Map<String, Object?> json) =>
      TramaProyectoModel(
        id: json[TramaProyectoFields.id] as int?,
        isEdit: json[TramaProyectoFields.isEdit] == 1,
        createdTime: json[TramaProyectoFields.time] != null
            ? DateTime.parse(json[TramaProyectoFields.time] as String)
            : null,
        numSnip: json[TramaProyectoFields.numSnip] as String,
        cui: json[TramaProyectoFields.cui] as String,
        latitud: json[TramaProyectoFields.latitud] as String,
        longitud: json[TramaProyectoFields.longitud] as String,
        departamento: json[TramaProyectoFields.departamento] as String,
        provincia: json[TramaProyectoFields.provincia] as String,
        distrito: json[TramaProyectoFields.distrito] as String,
        tambo: json[TramaProyectoFields.tambo] as String,
        centroPoblado: json[TramaProyectoFields.centroPoblado] as String,
        estado: json[TramaProyectoFields.estado] as String,
        subEstado: json[TramaProyectoFields.subEstado] as String,
        estadoSaneamiento:
            json[TramaProyectoFields.estadoSaneamiento] as String,
        modalidad: json[TramaProyectoFields.modalidad] as String,
        fechaInicio: json[TramaProyectoFields.fechaInicio] as String,
        fechaTerminoEstimado:
            json[TramaProyectoFields.fechaTerminoEstimado] as String,
        inversion: json[TramaProyectoFields.inversion] as String,
        costoEjecutado: json[TramaProyectoFields.costoEjecutado] as String,
        costoEstimadoFinal:
            json[TramaProyectoFields.costoEstimadoFinal] as String,
        avanceFisico: json[TramaProyectoFields.avanceFisico] as String,
        residente: json[TramaProyectoFields.residente] as String,
        supervisor: json[TramaProyectoFields.supervisor] as String,
        crp: json[TramaProyectoFields.crp] as String,
        codResidente: json[TramaProyectoFields.codResidente] as String,
        codSupervisor: json[TramaProyectoFields.codSupervisor] as String,
        codCrp: json[TramaProyectoFields.codCrp] as String,
      );

  Map<String, dynamic> toJson() => {
        //TramaProyectoFields.id: id,
        TramaProyectoFields.isEdit: isEdit ? 1 : 0,
        //TramaProyectoFields.time: createdTime.toIso8601String(),

        TramaProyectoFields.numSnip: numSnip,
        TramaProyectoFields.cui: cui,
        TramaProyectoFields.latitud: latitud,
        TramaProyectoFields.longitud: longitud,
        TramaProyectoFields.departamento: departamento,
        TramaProyectoFields.provincia: provincia,
        TramaProyectoFields.distrito: distrito,
        TramaProyectoFields.tambo: tambo,
        TramaProyectoFields.centroPoblado: centroPoblado,
        TramaProyectoFields.estado: estado,
        TramaProyectoFields.subEstado: subEstado,
        TramaProyectoFields.estadoSaneamiento: estadoSaneamiento,
        TramaProyectoFields.modalidad: modalidad,
        TramaProyectoFields.fechaInicio: fechaInicio,
        TramaProyectoFields.fechaTerminoEstimado: fechaTerminoEstimado,
        TramaProyectoFields.inversion: inversion,
        TramaProyectoFields.costoEjecutado: costoEjecutado,
        TramaProyectoFields.costoEstimadoFinal: costoEstimadoFinal,
        TramaProyectoFields.avanceFisico: avanceFisico,
        TramaProyectoFields.residente: residente,
        TramaProyectoFields.supervisor: supervisor,
        TramaProyectoFields.crp: crp,
        TramaProyectoFields.codResidente: codResidente,
        TramaProyectoFields.codSupervisor: codSupervisor,
        TramaProyectoFields.codCrp: codCrp,
      };

  static Map<String, dynamic> toJsonObject(TramaProyectoModel o) {
    return {
      TramaProyectoFields.numSnip: o.numSnip,
      TramaProyectoFields.cui: o.cui,
      TramaProyectoFields.latitud: o.latitud,
      TramaProyectoFields.longitud: o.longitud,
      TramaProyectoFields.departamento: o.departamento,
      TramaProyectoFields.provincia: o.provincia,
      TramaProyectoFields.distrito: o.distrito,
      TramaProyectoFields.tambo: o.tambo,
      TramaProyectoFields.centroPoblado: o.centroPoblado,
      TramaProyectoFields.estado: o.estado,
      TramaProyectoFields.subEstado: o.subEstado,
      TramaProyectoFields.estadoSaneamiento: o.estadoSaneamiento,
      TramaProyectoFields.modalidad: o.modalidad,
      TramaProyectoFields.fechaInicio: o.fechaInicio,
      TramaProyectoFields.fechaTerminoEstimado: o.fechaTerminoEstimado,
      TramaProyectoFields.inversion: o.inversion,
      TramaProyectoFields.costoEjecutado: o.costoEjecutado,
      TramaProyectoFields.costoEstimadoFinal: o.costoEstimadoFinal,
      TramaProyectoFields.avanceFisico: o.avanceFisico,
      TramaProyectoFields.residente: o.residente,
      TramaProyectoFields.supervisor: o.supervisor,
      TramaProyectoFields.crp: o.crp,
      TramaProyectoFields.codResidente: o.codResidente,
      TramaProyectoFields.codSupervisor: o.codSupervisor,
      TramaProyectoFields.codCrp: o.codCrp,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<TramaProyectoModel> aTramaProyecto) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaProyecto) {
      aList.add(TramaProyectoModel.toJsonObject(item));
    }
    return aList;
  }

  List<TramaProyectoModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return new List<TramaProyectoModel>.from(
        jsonData.map((x) => TramaProyectoModel.fromJson(x)));
  }

  String userToJson(List<TramaProyectoModel> aTramaProyecto) {
    final dyn = new List<dynamic>.from(aTramaProyecto.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
