import 'dart:convert';

import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';

String tableNameProgramacionIntervenciones = 'listar_programa_intervenciones';

class ProgramacionIntervencionesFields {
  static final List<String> values = [
    id,
    isEdit,
    time,
    idProgramacionIntervenciones,
    adjuntarArchivo,
    anio,
    convenio,
    descripcionDelEvento,
    detalleNecesidades,
    documentoQueAcreditaElEvento,
    dondeSeRealizoElEvento,
    fecha,
    horaFin,
    horaInicio,
    laIntervencionRespondeAUnConvenio,
    laIntervencionesPerteneceA,
    ndePersonasConvocadasAParticiparEnElEvento,
    nplanDeTrabajo,
    perteneceAUnPlanDeTrabajo,
    plataforma,
    progrmacionParaOtroTambio,
    tipoAccion,
    tipoPlanDeTrabajo,
    unidadTerritoria,
  ];

  static String id = '_id';
  static String isEdit = 'isEdit';
  static String time = 'time';

  static String estadoProgramacion = 'estadoProgramacion';
  static String idProgramacionIntervenciones = "idProgramacionIntervenciones";
  static String adjuntarArchivo = "adjuntarArchivo";
  static String anio = "anio";
  static String convenio = "convenio";
  static String descripcionDelEvento = "descripcionDelEvento";
  static String detalleNecesidades = "detalleNecesidades";
  static String documentoQueAcreditaElEvento = "documentoQueAcreditaElEvento";
  static String dondeSeRealizoElEvento = "dondeSeRealizoElEvento";
  static String fecha = "fecha";
  static String horaFin = "horaFin";
  static String horaInicio = "horaInicio";
  static String laIntervencionRespondeAUnConvenio =
      "laIntervencionRespondeAUnConvenio";
  static String laIntervencionesPerteneceA = "laIntervencionesPerteneceA";
  static String ndePersonasConvocadasAParticiparEnElEvento =
      "ndePersonasConvocadasAParticiparEnElEvento";
  static String nplanDeTrabajo = "nplanDeTrabajo";
  static String perteneceAUnPlanDeTrabajo = "perteneceAUnPlanDeTrabajo";
  static String plataforma = "plataforma";
  static String progrmacionParaOtroTambio = "progrmacionParaOtroTambio";
  static String tipoAccion = "tipoAccion";
  static String tipoPlanDeTrabajo = "tipoPlanDeTrabajo";
  static String unidadTerritoria = "unidadTerritoria";
  static String registroEntidadActividades = "registroEntidadActividades";
}

class ProgramacionIntervencionesModel {
  static const sOptDropdownDefault = 'Seleccione una opción';

  static const sEstadoINC = 'INCOMPLETO';
  static const sEstadoPEN = 'POR ENVIAR';
  static const sEstadoENV = 'ENVIADO';
  static final List<String> aEstadoProgramacion = [
    sEstadoINC,
    sEstadoPEN,
    sEstadoENV,
  ];

  int? id = 0;
  int? isEdit = 0;
  DateTime? createdTime = null;

  String? estadoProgramacion = '';
  String? idProgramacionIntervenciones = '';
  String? adjuntarArchivo = '';
  String? anio = '';
  String? convenio = '';
  String? descripcionDelEvento = '';
  String? detalleNecesidades = '';
  String? documentoQueAcreditaElEvento = '';
  String? dondeSeRealizoElEvento = '';
  String? fecha = '';
  String? horaFin = '';
  String? horaInicio = '';
  String? laIntervencionRespondeAUnConvenio = '';
  String? laIntervencionesPerteneceA = '';
  String? ndePersonasConvocadasAParticiparEnElEvento = '';
  String? nplanDeTrabajo = '';
  String? perteneceAUnPlanDeTrabajo = '';
  String? plataforma = '';
  String? progrmacionParaOtroTambio = '';
  String? tipoAccion = '';
  String? tipoPlanDeTrabajo = '';
  String? unidadTerritoria = '';
  List<RegistroEntidadActividadModel>? registroEntidadActividades = [];

  ProgramacionIntervencionesModel.empty() {}

  ProgramacionIntervencionesModel({
    this.id,
    this.isEdit,
    this.createdTime,
    this.estadoProgramacion,
    this.adjuntarArchivo,
    this.anio,
    this.convenio,
    this.descripcionDelEvento,
    this.detalleNecesidades,
    this.documentoQueAcreditaElEvento,
    this.dondeSeRealizoElEvento,
    this.fecha,
    this.horaFin,
    this.horaInicio,
    this.idProgramacionIntervenciones,
    this.laIntervencionRespondeAUnConvenio,
    this.laIntervencionesPerteneceA,
    this.ndePersonasConvocadasAParticiparEnElEvento,
    this.nplanDeTrabajo,
    this.perteneceAUnPlanDeTrabajo,
    this.plataforma,
    this.progrmacionParaOtroTambio,
    this.tipoAccion,
    this.tipoPlanDeTrabajo,
    this.unidadTerritoria,
    this.registroEntidadActividades,
  });

  ProgramacionIntervencionesModel copy({
    int? id,
    int? isEdit,
    DateTime? createdTime,
    String? estadoProgramacion,
    String? adjuntarArchivo,
    String? anio,
    String? convenio,
    String? descripcionDelEvento,
    String? detalleNecesidades,
    String? documentoQueAcreditaElEvento,
    String? dondeSeRealizoElEvento,
    String? fecha,
    String? horaFin,
    String? horaInicio,
    String? idProgramacionIntervenciones,
    String? laIntervencionRespondeAUnConvenio,
    String? laIntervencionesPerteneceA,
    String? ndePersonasConvocadasAParticiparEnElEvento,
    String? nplanDeTrabajo,
    String? perteneceAUnPlanDeTrabajo,
    String? plataforma,
    String? progrmacionParaOtroTambio,
    String? tipoAccion,
    String? tipoPlanDeTrabajo,
    String? unidadTerritoria,
  }) =>
      ProgramacionIntervencionesModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        createdTime: createdTime ?? this.createdTime,
        estadoProgramacion: estadoProgramacion ?? this.estadoProgramacion,
        adjuntarArchivo: adjuntarArchivo ?? this.adjuntarArchivo,
        anio: anio ?? this.anio,
        convenio: convenio ?? this.convenio,
        descripcionDelEvento: descripcionDelEvento ?? this.descripcionDelEvento,
        detalleNecesidades: detalleNecesidades ?? this.detalleNecesidades,
        documentoQueAcreditaElEvento:
            documentoQueAcreditaElEvento ?? this.documentoQueAcreditaElEvento,
        dondeSeRealizoElEvento:
            dondeSeRealizoElEvento ?? this.dondeSeRealizoElEvento,
        fecha: fecha ?? this.fecha,
        horaFin: horaFin ?? this.horaFin,
        horaInicio: horaInicio ?? this.horaInicio,
        idProgramacionIntervenciones:
            idProgramacionIntervenciones ?? this.idProgramacionIntervenciones,
        laIntervencionRespondeAUnConvenio: laIntervencionRespondeAUnConvenio ??
            this.laIntervencionRespondeAUnConvenio,
        laIntervencionesPerteneceA:
            laIntervencionesPerteneceA ?? this.laIntervencionesPerteneceA,
        ndePersonasConvocadasAParticiparEnElEvento:
            ndePersonasConvocadasAParticiparEnElEvento ??
                this.ndePersonasConvocadasAParticiparEnElEvento,
        nplanDeTrabajo: nplanDeTrabajo ?? this.nplanDeTrabajo,
        perteneceAUnPlanDeTrabajo:
            perteneceAUnPlanDeTrabajo ?? this.perteneceAUnPlanDeTrabajo,
        plataforma: plataforma ?? this.plataforma,
        progrmacionParaOtroTambio:
            progrmacionParaOtroTambio ?? this.progrmacionParaOtroTambio,
        tipoAccion: tipoAccion ?? this.tipoAccion,
        tipoPlanDeTrabajo: tipoPlanDeTrabajo ?? this.tipoPlanDeTrabajo,
        unidadTerritoria: unidadTerritoria ?? this.unidadTerritoria,
      );

  static ProgramacionIntervencionesModel fromJson(Map<String, Object?> json) =>
      ProgramacionIntervencionesModel(
        id: json[ProgramacionIntervencionesFields.id] as int?,
        isEdit: json[ProgramacionIntervencionesFields.isEdit] == null
            ? 0
            : json[ProgramacionIntervencionesFields.isEdit] as int,
        createdTime: json[ProgramacionIntervencionesFields.time] != null
            ? DateTime.parse(
                json[ProgramacionIntervencionesFields.time] as String)
            : null,
        estadoProgramacion: _getString(
            json[ProgramacionIntervencionesFields.estadoProgramacion]),
        adjuntarArchivo:
            _getString(json[ProgramacionIntervencionesFields.adjuntarArchivo]),
        anio: _getString(json[ProgramacionIntervencionesFields.anio]),
        convenio: _getString(json[ProgramacionIntervencionesFields.convenio]),
        descripcionDelEvento: _getString(
            json[ProgramacionIntervencionesFields.descripcionDelEvento]),
        detalleNecesidades: _getString(
            json[ProgramacionIntervencionesFields.detalleNecesidades]),
        documentoQueAcreditaElEvento: _getString(json[
            ProgramacionIntervencionesFields.documentoQueAcreditaElEvento]),
        dondeSeRealizoElEvento: _getString(
            json[ProgramacionIntervencionesFields.dondeSeRealizoElEvento]),
        fecha: _getString(json[ProgramacionIntervencionesFields.fecha]),
        horaFin: _getString(json[ProgramacionIntervencionesFields.horaFin]),
        horaInicio:
            _getString(json[ProgramacionIntervencionesFields.horaInicio]),
        idProgramacionIntervenciones: _getString(json[
            ProgramacionIntervencionesFields.idProgramacionIntervenciones]),
        laIntervencionRespondeAUnConvenio: _getString(json[
            ProgramacionIntervencionesFields
                .laIntervencionRespondeAUnConvenio]),
        laIntervencionesPerteneceA: _getString(
            json[ProgramacionIntervencionesFields.laIntervencionesPerteneceA]),
        ndePersonasConvocadasAParticiparEnElEvento: _getString(json[
            ProgramacionIntervencionesFields
                .ndePersonasConvocadasAParticiparEnElEvento]),
        nplanDeTrabajo:
            _getString(json[ProgramacionIntervencionesFields.nplanDeTrabajo]),
        perteneceAUnPlanDeTrabajo: _getString(
            json[ProgramacionIntervencionesFields.perteneceAUnPlanDeTrabajo]),
        plataforma:
            _getString(json[ProgramacionIntervencionesFields.plataforma]),
        progrmacionParaOtroTambio: _getString(
            json[ProgramacionIntervencionesFields.progrmacionParaOtroTambio]),
        tipoAccion:
            _getString(json[ProgramacionIntervencionesFields.tipoAccion]),
        tipoPlanDeTrabajo: _getString(
            json[ProgramacionIntervencionesFields.tipoPlanDeTrabajo]),
        unidadTerritoria:
            _getString(json[ProgramacionIntervencionesFields.unidadTerritoria]),
        registroEntidadActividades: parseList(
            json[ProgramacionIntervencionesFields.registroEntidadActividades]
                as List),
      );

  Map<String, dynamic> toJson() => {
        //ProgramacionIntervencionesFields.id: id,
        ProgramacionIntervencionesFields.isEdit: isEdit,
        //ProgramacionIntervencionesFields.time: createdTime.toIso8601String(),
        ProgramacionIntervencionesFields.estadoProgramacion: estadoProgramacion,
        ProgramacionIntervencionesFields.adjuntarArchivo: adjuntarArchivo,
        ProgramacionIntervencionesFields.anio: anio,
        ProgramacionIntervencionesFields.convenio: convenio,
        ProgramacionIntervencionesFields.descripcionDelEvento:
            descripcionDelEvento,
        ProgramacionIntervencionesFields.detalleNecesidades: detalleNecesidades,
        ProgramacionIntervencionesFields.documentoQueAcreditaElEvento:
            documentoQueAcreditaElEvento,
        ProgramacionIntervencionesFields.dondeSeRealizoElEvento:
            dondeSeRealizoElEvento,
        ProgramacionIntervencionesFields.fecha: fecha,
        ProgramacionIntervencionesFields.horaFin: horaFin,
        ProgramacionIntervencionesFields.horaInicio: horaInicio,
        ProgramacionIntervencionesFields.idProgramacionIntervenciones:
            idProgramacionIntervenciones,
        ProgramacionIntervencionesFields.laIntervencionRespondeAUnConvenio:
            laIntervencionRespondeAUnConvenio,
        ProgramacionIntervencionesFields.laIntervencionesPerteneceA:
            laIntervencionesPerteneceA,
        ProgramacionIntervencionesFields
                .ndePersonasConvocadasAParticiparEnElEvento:
            ndePersonasConvocadasAParticiparEnElEvento,
        ProgramacionIntervencionesFields.nplanDeTrabajo: nplanDeTrabajo,
        ProgramacionIntervencionesFields.perteneceAUnPlanDeTrabajo:
            perteneceAUnPlanDeTrabajo,
        ProgramacionIntervencionesFields.plataforma: plataforma,
        ProgramacionIntervencionesFields.progrmacionParaOtroTambio:
            progrmacionParaOtroTambio,
        ProgramacionIntervencionesFields.tipoAccion: tipoAccion,
        ProgramacionIntervencionesFields.tipoPlanDeTrabajo: tipoPlanDeTrabajo,
        ProgramacionIntervencionesFields.unidadTerritoria: unidadTerritoria,
      };

  static Map<String, dynamic> toJsonObject(ProgramacionIntervencionesModel o) {
    return {
      ProgramacionIntervencionesFields.adjuntarArchivo: o.adjuntarArchivo,
      ProgramacionIntervencionesFields.anio: o.anio,
      ProgramacionIntervencionesFields.convenio: o.convenio,
      ProgramacionIntervencionesFields.descripcionDelEvento:
          o.descripcionDelEvento,
      ProgramacionIntervencionesFields.detalleNecesidades: o.detalleNecesidades,
      ProgramacionIntervencionesFields.documentoQueAcreditaElEvento:
          o.documentoQueAcreditaElEvento,
      ProgramacionIntervencionesFields.dondeSeRealizoElEvento:
          o.dondeSeRealizoElEvento,
      ProgramacionIntervencionesFields.fecha: o.fecha,
      ProgramacionIntervencionesFields.horaFin: o.horaFin,
      ProgramacionIntervencionesFields.horaInicio: o.horaInicio,
      ProgramacionIntervencionesFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones,
      ProgramacionIntervencionesFields.laIntervencionRespondeAUnConvenio:
          o.laIntervencionRespondeAUnConvenio,
      ProgramacionIntervencionesFields.laIntervencionesPerteneceA:
          o.laIntervencionesPerteneceA,
      ProgramacionIntervencionesFields
              .ndePersonasConvocadasAParticiparEnElEvento:
          o.ndePersonasConvocadasAParticiparEnElEvento,
      ProgramacionIntervencionesFields.nplanDeTrabajo: o.nplanDeTrabajo,
      ProgramacionIntervencionesFields.perteneceAUnPlanDeTrabajo:
          o.perteneceAUnPlanDeTrabajo,
      ProgramacionIntervencionesFields.plataforma: o.plataforma,
      ProgramacionIntervencionesFields.progrmacionParaOtroTambio:
          o.progrmacionParaOtroTambio,
      ProgramacionIntervencionesFields.tipoAccion: o.tipoAccion,
      ProgramacionIntervencionesFields.tipoPlanDeTrabajo: o.tipoPlanDeTrabajo,
      ProgramacionIntervencionesFields.unidadTerritoria: o.unidadTerritoria,
    };
  }

  static Map<String, String> toJsonObjectApi(
      ProgramacionIntervencionesModel o) {
    return {
      ProgramacionIntervencionesFields.adjuntarArchivo:
          o.adjuntarArchivo as String,
      ProgramacionIntervencionesFields.anio: o.anio as String,
      ProgramacionIntervencionesFields.convenio: o.convenio as String,
      ProgramacionIntervencionesFields.descripcionDelEvento:
          o.descripcionDelEvento as String,
      ProgramacionIntervencionesFields.detalleNecesidades:
          o.detalleNecesidades as String,
      ProgramacionIntervencionesFields.documentoQueAcreditaElEvento:
          o.documentoQueAcreditaElEvento as String,
      ProgramacionIntervencionesFields.dondeSeRealizoElEvento:
          o.dondeSeRealizoElEvento as String,
      ProgramacionIntervencionesFields.fecha: o.fecha as String,
      ProgramacionIntervencionesFields.horaFin: o.horaFin as String,
      ProgramacionIntervencionesFields.horaInicio: o.horaInicio as String,
      ProgramacionIntervencionesFields.idProgramacionIntervenciones:
          o.idProgramacionIntervenciones as String,
      ProgramacionIntervencionesFields.laIntervencionRespondeAUnConvenio:
          o.laIntervencionRespondeAUnConvenio as String,
      ProgramacionIntervencionesFields.laIntervencionesPerteneceA:
          o.laIntervencionesPerteneceA as String,
      ProgramacionIntervencionesFields
              .ndePersonasConvocadasAParticiparEnElEvento:
          o.ndePersonasConvocadasAParticiparEnElEvento as String,
      ProgramacionIntervencionesFields.nplanDeTrabajo:
          o.nplanDeTrabajo as String,
      ProgramacionIntervencionesFields.perteneceAUnPlanDeTrabajo:
          o.perteneceAUnPlanDeTrabajo as String,
      ProgramacionIntervencionesFields.plataforma: o.plataforma as String,
      ProgramacionIntervencionesFields.progrmacionParaOtroTambio:
          o.progrmacionParaOtroTambio as String,
      ProgramacionIntervencionesFields.tipoAccion: o.tipoAccion as String,
      ProgramacionIntervencionesFields.tipoPlanDeTrabajo:
          o.tipoPlanDeTrabajo as String,
      ProgramacionIntervencionesFields.unidadTerritoria:
          o.unidadTerritoria as String,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<ProgramacionIntervencionesModel> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(ProgramacionIntervencionesModel.toJsonObject(item));
    }
    return aList;
  }

  List<ProgramacionIntervencionesModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<ProgramacionIntervencionesModel>.from(
        jsonData.map((x) => ProgramacionIntervencionesModel.fromJson(x)));
  }

  String userToJson(List<ProgramacionIntervencionesModel> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }

  static List<RegistroEntidadActividadModel> parseList(List a) {
    if (a == null) return [];

    List<RegistroEntidadActividadModel> aListFormat = a
        .map((tagJson) => RegistroEntidadActividadModel.fromJson(tagJson))
        .toList();
    return aListFormat;
  }

  static String _getString(dynamic data) {
    return data != null ? data as String : '';
  }
}
