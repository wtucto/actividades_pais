class UsuariosApp {
  final String codigo;
  final String nombres;
  final String rol;

  UsuariosApp({
    required this.codigo,
    required this.nombres,
    required this.rol,
  });

  static UsuariosApp fromJsonOne(Map<String, dynamic> json) {
    return UsuariosApp(
      codigo: json['codigo'],
      nombres: json['nombres'],
      rol: json['rol'],
    );
  }

  factory UsuariosApp.fromJson(Map<String, dynamic> json) => UsuariosApp(
        codigo: json['codigo'],
        nombres: json['nombres'],
        rol: json['rol'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'codigo': codigo,
        'nombres': nombres,
        'rol': rol,
      };
}
