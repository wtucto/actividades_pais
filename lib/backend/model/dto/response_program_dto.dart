import 'dart:convert';

class ProgramRespFld {
  static String estado = 'estado';
  static String mensaje = 'mensaje';
}

class ProgramRespDto {
  bool? estado = false;
  String? mensaje = '';

  ProgramRespDto.empty() {}

  ProgramRespDto({
    this.mensaje,
    this.estado,
  });

  ProgramRespDto copy({
    bool? estado,
    String? mensaje,
  }) =>
      ProgramRespDto(
        mensaje: mensaje ?? this.mensaje,
        estado: estado ?? this.estado,
      );

  static ProgramRespDto fromJson(Map<String, Object?> o) => ProgramRespDto(
        mensaje: _getString(o[ProgramRespFld.estado]),
        estado: o[ProgramRespFld.mensaje] as bool,
      );

  Map<String, dynamic> toJson() => {
        ProgramRespFld.estado: mensaje,
        ProgramRespFld.mensaje: estado,
      };

  static Map<String, dynamic> toJsonObject(ProgramRespDto o) {
    return {
      ProgramRespFld.estado: o.mensaje,
      ProgramRespFld.mensaje: o.estado,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<ProgramRespDto> o) {
    List<Map<String, dynamic>> aList = [];
    for (var item in o) {
      aList.add(ProgramRespDto.toJsonObject(item));
    }
    return aList;
  }

  static String _getString(dynamic data, {String? type}) {
    String resp = data != null ? data.toString() : '';
    if (type != null && type == "I") {
      if (resp == '') resp = '0';
    } else if (type != null && type == "D") {
      if (resp == '') resp = '0.00';
    }
    return resp;
  }
}
