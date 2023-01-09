class LoginClass {
  int? id;
  String? name;
  String? token;
  String? rol;
  String? username;
  String? password;

  LoginClass({ this.id, this.name, this.token, this.rol, this.password,this.username});

  factory LoginClass.fromJson(Map<String, dynamic> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled

    print("holas");
    print(data['id']);
    final id = data['id'];
    final name = data['name'];
    final  token = data['token'];
    final rol = data['rol'];
    final username = data['username'];
    final password = data['password'];

    return LoginClass(name: name, id: id, password: password, rol: rol, token: token,username: username);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['token'] = this.token;
    data['rol'] = this.rol;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }

  factory LoginClass.fromMap(Map<String, dynamic> json) =>
      LoginClass(
        id: json['id'],
        name: json['name'],
        token: json['token'],
        rol: json['rol'],
        username: json['username'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "token": token,
      "rol": rol,
      "username": username,
      "password": password,
    };
  }}

