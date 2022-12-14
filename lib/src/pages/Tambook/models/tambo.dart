class Tambo {
  String? imagen;
  String? id_tambo;
  String? id_departamento;
  String? departamento;
  String? gestor;
  String? palabra;
  String? clase;
  String? value;
  String? label;

  Tambo.empty() {}

  Tambo({
    this.imagen,
    this.id_tambo,
    this.id_departamento,
    this.departamento,
    this.gestor,
    this.palabra,
    this.clase,
    this.value,
    this.label,
  });

  factory Tambo.fromJson(Map<String, dynamic> json) {
    return Tambo(
      imagen: json['imagen'],
      id_tambo: json['id_tambo'],
      id_departamento: json['id_departamento'],
      departamento: json['departamento'],
      gestor: json['gestor'],
      palabra: json['palabra'],
      clase: json['clase'],
      value: json['value'],
      label: json['label'],
    );
  }
}
