class PorcentajesEnvioPias {
  int? id;
  int? tipo;
  String? idUnicoReporte;
  double? porcentaje;

  PorcentajesEnvioPias(
      {this.id,
      this.tipo = 0,
      this.idUnicoReporte = "",
      this.porcentaje = 0.0});

  PorcentajesEnvioPias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    idUnicoReporte = json['idUnicoReporte'];
    porcentaje = json['porcentaje'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['idUnicoReporte'] = this.idUnicoReporte;
    data['porcentaje'] = this.porcentaje;
    return data;
  }

  factory PorcentajesEnvioPias.fromMap(Map<String, dynamic> json) =>
      PorcentajesEnvioPias(
        id: json['id'],
        tipo: json['tipo'],
        idUnicoReporte: json['idUnicoReporte'],
        porcentaje: json['porcentaje'],
      );

  Map<String, dynamic> toMap() {
    return {
      "tipo": tipo,
      "idUnicoReporte": idUnicoReporte,
      "porcentaje": porcentaje
    };
  }
}
