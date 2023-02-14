
class IntentosRegistrosFallecidos {
  int? id;
  int? idPlataforma;
  int? idProgramacion;
  String? dni;
  String? idUsuarioReg;
  String? fechaReg;
  String? ipmaqReg;

  IntentosRegistrosFallecidos(
      {
        this.id,
        this.idPlataforma,
        this.idProgramacion,
        this.dni,
        this.idUsuarioReg,
        this.fechaReg,
        this.ipmaqReg,

      });

  Map<String, dynamic> toMap() {
    return {
      "id_plataforma": idPlataforma,
      "id_programacion": idProgramacion,
      "dni": dni,
      "id_usuario_reg": idUsuarioReg,
      "fecha_reg": fechaReg,
      "ipmaq_reg": ipmaqReg,

    };
  }
}
