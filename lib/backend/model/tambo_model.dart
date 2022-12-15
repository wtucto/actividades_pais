class TamboFields {
  static String imagen = 'imagen';
  static String id_tambo = 'id_tambo';
  static String id_departamento = 'id_departamento';
  static String departamento = 'departamento';
  static String gestor = 'gestor';
  static String palabra = 'palabra';
  static String clase = 'clase';
  static String value = 'value';
  static String label = 'label';
}

class TamboModel {
  String? imagen;
  String? id_tambo;
  String? id_departamento;
  String? departamento;
  String? gestor;
  String? palabra;
  String? clase;
  String? value;
  String? label;

  TamboModel.empty() {}

  TamboModel({
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

  factory TamboModel.fromJson(Map<String, dynamic> json) {
    return TamboModel(
      imagen: json[TamboFields.imagen],
      id_tambo: json[TamboFields.id_tambo],
      id_departamento: json[TamboFields.id_departamento],
      departamento: json[TamboFields.departamento],
      gestor: json[TamboFields.gestor],
      palabra: json[TamboFields.palabra],
      clase: json[TamboFields.clase],
      value: json[TamboFields.value],
      label: json[TamboFields.label],
    );
  }
}
