import 'dart:convert';

class TramaMonitoreoRespApiFields {
  static final List<String> values = [
    codResultado,
    msgResultado,
    total,
    response,
    idPerfil,
  ];

  static String codResultado = 'codResultado';
  static String msgResultado = 'msgResultado';
  static String total = 'total';
  static String response = 'response';
  static String idPerfil = 'idPerfil';
}

class TramaMonitoreoRespApiDto {
  int? codResultado = 0;
  int? total = 0;
  String? msgResultado = '';
  Map<String, dynamic>? response = {};
  int? idPerfil = 0;

  TramaMonitoreoRespApiDto.empty() {}

  TramaMonitoreoRespApiDto({
    this.codResultado,
    this.msgResultado,
    this.total,
    this.response,
    this.idPerfil,
  });

  TramaMonitoreoRespApiDto copy({
    int? codResultado,
    int? total,
    String? msgResultado,
    Map<String, dynamic>? response,
    int? idPerfil,
  }) =>
      TramaMonitoreoRespApiDto(
        codResultado: codResultado ?? this.codResultado,
        msgResultado: msgResultado ?? this.msgResultado,
        total: total ?? this.total,
        response: response ?? this.response,
        idPerfil: idPerfil ?? this.idPerfil,
      );

  static TramaMonitoreoRespApiDto fromJson(Map<String, Object?> json) =>
      TramaMonitoreoRespApiDto(
        codResultado: json[TramaMonitoreoRespApiFields.codResultado] == null
            ? 0
            : json[TramaMonitoreoRespApiFields.codResultado] as int,
        msgResultado: json[TramaMonitoreoRespApiFields.msgResultado] as String,
        total: json[TramaMonitoreoRespApiFields.total] as int,
        response: json[TramaMonitoreoRespApiFields.response] as dynamic,
        idPerfil: json[TramaMonitoreoRespApiFields.idPerfil] as int,
      );

  Map<String, dynamic> toJson() => {
        TramaMonitoreoRespApiFields.codResultado: codResultado,
        TramaMonitoreoRespApiFields.msgResultado: msgResultado,
        TramaMonitoreoRespApiFields.total: total,
        TramaMonitoreoRespApiFields.response: response,
        TramaMonitoreoRespApiFields.idPerfil: idPerfil,
      };

  static Map<String, dynamic> toJsonObject(TramaMonitoreoRespApiDto o) {
    return {
      TramaMonitoreoRespApiFields.codResultado: o.codResultado,
      TramaMonitoreoRespApiFields.msgResultado: o.msgResultado,
      TramaMonitoreoRespApiFields.total: o.total,
      TramaMonitoreoRespApiFields.response: o.response,
      TramaMonitoreoRespApiFields.idPerfil: o.idPerfil,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(
      List<TramaMonitoreoRespApiDto> aTramaMonitoreo) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aTramaMonitoreo) {
      aList.add(TramaMonitoreoRespApiDto.toJsonObject(item));
    }
    return aList;
  }

  List<TramaMonitoreoRespApiDto> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return List<TramaMonitoreoRespApiDto>.from(
        jsonData.map((x) => TramaMonitoreoRespApiDto.fromJson(x)));
  }

  String userToJson(List<TramaMonitoreoRespApiDto> aTramaMonitoreo) {
    final dyn = List<dynamic>.from(aTramaMonitoreo.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
