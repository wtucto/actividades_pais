class PorcentajesEnvio {
  int? id;
  int? tipo;
  String? codigoIntervencion;
  double? porcentaje;

  PorcentajesEnvio(
      {this.id,
      this.tipo = 0,
      this.codigoIntervencion = "",
      this.porcentaje = 0.0});

  PorcentajesEnvio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    codigoIntervencion = json['codigoIntervencion'];
    porcentaje = json['porcentaje'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['codigoIntervencion'] = this.codigoIntervencion;
    data['porcentaje'] = this.porcentaje;
    return data;
  }

  factory PorcentajesEnvio.fromMap(Map<String, dynamic> json) =>
      PorcentajesEnvio(
        id: json['id'],
        tipo: json['tipo'],
        codigoIntervencion: json['codigoIntervencion'],
        porcentaje: json['porcentaje'],
      );

  Map<String, dynamic> toMap() {
    return {
      "tipo": tipo,
      "codigoIntervencion": codigoIntervencion,
      "porcentaje": porcentaje
    };
  }
}
