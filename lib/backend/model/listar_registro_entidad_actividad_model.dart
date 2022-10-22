import 'dart:convert';

String tableNameRegistroEntidadActividad = 'listar_registro_entidad_actividad';

class RegistroEntidadActividadFields {
  static final List<String> values = [
    id,
    isEdit,
    time,
    idRegistroEntidadesYActividades,
    idProgramacionIntervenciones,
    categoria,
    descripcionDeLaActividadProgramada,
    programa,
    sector,
    servicio,
    subCategoria,
    tipoActividad,
    tipoDeUsuario,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';
  static String categoria = 'categoria';
  static String descripcionDeLaActividadProgramada =
      'descripcionDeLaActividadProgramada';
  static String idRegistroEntidadesYActividades =
      'idRegistroEntidadesYActividades';
  static String idProgramacionIntervenciones = 'idProgramacionIntervenciones';
  static String programa = 'programa';
  static String sector = 'sector';
  static String servicio = 'servicio';
  static String subCategoria = 'subCategoria';
  static String tipoActividad = 'tipoActividad';
  static String tipoDeUsuario = 'tipoDeUsuario';
}

class RegistroEntidadActividadModel {
  static const sOptDropdownDefault = 'Seleccione una opción';

  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime = null;

  String? idRegistroEntidadesYActividades = '';
  String? idProgramacionIntervenciones = '';
  String? categoria = '';
  String? descripcionDeLaActividadProgramada = '';
  String? programa = '';
  String? sector = '';
  String? servicio = '';
  String? subCategoria = '';
  String? tipoActividad = '';
  String? tipoDeUsuario = '';

  RegistroEntidadActividadModel.empty() {}

  RegistroEntidadActividadModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.categoria,
    this.descripcionDeLaActividadProgramada,
    this.idRegistroEntidadesYActividades,
    this.idProgramacionIntervenciones,
    this.programa,
    this.sector,
    this.servicio,
    this.subCategoria,
    this.tipoActividad,
    this.tipoDeUsuario,
  });

  RegistroEntidadActividadModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? categoria,
    String? descripcionDeLaActividadProgramada,
    String? idRegistroEntidadesYActividades,
    String? idProgramacionIntervenciones,
    String? programa,
    String? sector,
    String? servicio,
    String? subCategoria,
    String? tipoActividad,
    String? tipoDeUsuario,
  }) =>
      RegistroEntidadActividadModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        categoria: categoria ?? this.categoria,
        descripcionDeLaActividadProgramada:
            descripcionDeLaActividadProgramada ??
                this.descripcionDeLaActividadProgramada,
        idRegistroEntidadesYActividades: idRegistroEntidadesYActividades ??
            this.idRegistroEntidadesYActividades,
        idProgramacionIntervenciones:
            idProgramacionIntervenciones ?? this.idProgramacionIntervenciones,
        programa: programa ?? this.programa,
        sector: sector ?? this.sector,
        servicio: servicio ?? this.servicio,
        subCategoria: subCategoria ?? this.subCategoria,
        tipoActividad: tipoActividad ?? this.tipoActividad,
        tipoDeUsuario: tipoDeUsuario ?? this.tipoDeUsuario,
      );

  static RegistroEntidadActividadModel fromJson(Map<String, Object?> json) =>
      RegistroEntidadActividadModel(
        id: json[RegistroEntidadActividadFields.id] as int?,
        isEdit: json[RegistroEntidadActividadFields.isEdit] == null
            ? 0
            : json[RegistroEntidadActividadFields.isEdit] as int,
        createdTime: json[RegistroEntidadActividadFields.time] != null
            ? DateTime.parse(
                json[RegistroEntidadActividadFields.time] as String)
            : null,
        categoria: _getString(json[RegistroEntidadActividadFields.categoria]),
        descripcionDeLaActividadProgramada: _getString(json[
            RegistroEntidadActividadFields.descripcionDeLaActividadProgramada]),
        idRegistroEntidadesYActividades: _getString(json[
            RegistroEntidadActividadFields.idRegistroEntidadesYActividades]),
        idProgramacionIntervenciones: _getString(
            json[RegistroEntidadActividadFields.idProgramacionIntervenciones]),
        programa: _getString(json[RegistroEntidadActividadFields.programa]),
        sector: _getString(json[RegistroEntidadActividadFields.sector]),
        servicio: _getString(json[RegistroEntidadActividadFields.servicio]),
        subCategoria:
            _getString(json[RegistroEntidadActividadFields.subCategoria]),
        tipoActividad:
            _getString(json[RegistroEntidadActividadFields.tipoActividad]),
        tipoDeUsuario:
            _getString(json[RegistroEntidadActividadFields.tipoDeUsuario]),
      );

  Map<String, dynamic> toJson() => {
        //ProgramacionIntervencionesFields.id: id,
        RegistroEntidadActividadFields.isEdit: isEdit,
        //ProgramacionIntervencionesFields.time: createdTime.toIso8601String(),

        RegistroEntidadActividadFields.categoria: categoria,
        RegistroEntidadActividadFields.descripcionDeLaActividadProgramada:
            descripcionDeLaActividadProgramada,
        RegistroEntidadActividadFields.idRegistroEntidadesYActividades:
            idRegistroEntidadesYActividades,
        RegistroEntidadActividadFields.idProgramacionIntervenciones:
            idProgramacionIntervenciones,
        RegistroEntidadActividadFields.programa: programa,
        RegistroEntidadActividadFields.sector: sector,
        RegistroEntidadActividadFields.servicio: servicio,
        RegistroEntidadActividadFields.subCategoria: subCategoria,
        RegistroEntidadActividadFields.tipoActividad: tipoActividad,
        RegistroEntidadActividadFields.tipoDeUsuario: tipoDeUsuario,
      };

  static Map<String, dynamic> toJsonObject(RegistroEntidadActividadModel o) {
    return {
      RegistroEntidadActividadFields.categoria: o.categoria,
      RegistroEntidadActividadFields.descripcionDeLaActividadProgramada:
          o.descripcionDeLaActividadProgramada,
      RegistroEntidadActividadFields.idRegistroEntidadesYActividades:
          o.idRegistroEntidadesYActividades,
      RegistroEntidadActividadFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones,
      RegistroEntidadActividadFields.programa: o.programa,
      RegistroEntidadActividadFields.sector: o.sector,
      RegistroEntidadActividadFields.servicio: o.servicio,
      RegistroEntidadActividadFields.subCategoria: o.subCategoria,
      RegistroEntidadActividadFields.tipoActividad: o.tipoActividad,
      RegistroEntidadActividadFields.tipoDeUsuario: o.tipoDeUsuario,
    };
  }

  static Map<String, String> toJsonObjectApi(RegistroEntidadActividadModel o) {
    return {
      RegistroEntidadActividadFields.categoria: o.categoria as String,
      RegistroEntidadActividadFields.descripcionDeLaActividadProgramada:
          o.descripcionDeLaActividadProgramada as String,
      RegistroEntidadActividadFields.idRegistroEntidadesYActividades:
          o.idRegistroEntidadesYActividades as String,
      RegistroEntidadActividadFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones as String,
      RegistroEntidadActividadFields.programa: o.programa as String,
      RegistroEntidadActividadFields.sector: o.sector as String,
      RegistroEntidadActividadFields.servicio: o.servicio as String,
      RegistroEntidadActividadFields.subCategoria: o.subCategoria as String,
      RegistroEntidadActividadFields.tipoActividad: o.tipoActividad as String,
      RegistroEntidadActividadFields.tipoDeUsuario: o.tipoDeUsuario as String,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<RegistroEntidadActividadModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(RegistroEntidadActividadModel.toJsonObject(item));
    }
    return aList;
  }

  List<RegistroEntidadActividadModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<RegistroEntidadActividadModel>.from(
        jsonData.map((x) => RegistroEntidadActividadModel.fromJson(x)));
  }

  String userToJson(List<RegistroEntidadActividadModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }
}
