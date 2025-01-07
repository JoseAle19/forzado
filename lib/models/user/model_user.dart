import 'dart:convert';

UserModelResponse userModelResponseFromJson(String str) =>
    UserModelResponse.fromJson(json.decode(str));

String userModelResponseToJson(UserModelResponse data) =>
    json.encode(data.toJson());

class UserModelResponse {
  final bool? success;
  final List<Value>? values;

  UserModelResponse({
    this.success,
    this.values,
  });

  factory UserModelResponse.fromJson(Map<String, dynamic> json) =>
      UserModelResponse(
        success: json["success"],
        values: json["values"] == null
            ? []
            : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class Value {
  final int? id;
  final String? nombre;
  final String? apePaterno;
  final String? apeMaterno;
  final int? areaId;
  final String? areaDescripcion;
  final int? rolId;
  final String? rolDescripcion;
  final Map<String, String>? roles;
  final int? estado;
  final String? dni;
  final int? puestoId;
  final String? puestoDescripcion;
  final String? correo;
  final String? usuario;

  Value({
    this.id,
    this.nombre,
    this.apePaterno,
    this.apeMaterno,
    this.areaId,
    this.areaDescripcion,
    this.rolId,
    this.rolDescripcion,
    this.roles,
    this.estado,
    this.dni,
    this.puestoId,
    this.puestoDescripcion,
    this.correo,
    this.usuario,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"] ?? 0,
        nombre: json["nombre"] ?? '',
        apePaterno: json["apePaterno"] ?? '',
        apeMaterno: json["apeMaterno"] ?? '',
        areaId: json["areaId"] ?? 0,
        areaDescripcion: json["areaDescripcion"] ?? '',
        rolId: json["rolId"] ?? 0,
        rolDescripcion: json["rolDescripcion"] ?? '',
        roles: json["roles"] != null
            ? Map<String, String>.from(json["roles"])
            : {},
        estado: json["estado"] ?? 0,
        dni: json["dni"] ?? '',
        puestoId: json["puestoId"] ?? 0,
        puestoDescripcion: json["puestoDescripcion"] ?? '',
        correo: json["correo"] ?? '',
        usuario: json["usuario"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apePaterno": apePaterno,
        "apeMaterno": apeMaterno,
        "areaId": areaId,
        "areaDescripcion": areaDescripcion,
        "rolId": rolId,
        "rolDescripcion": rolDescripcion,
        "roles": roles != null ? Map<String, dynamic>.from(roles!) : {},
        "estado": estado,
        "dni": dni,
        "puestoId": puestoId,
        "puestoDescripcion": puestoDescripcion,
        "correo": correo,
        "usuario": usuario,
      };
}
