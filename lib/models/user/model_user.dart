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
  final List<int>? turnos; 
    final int? grupoId;
    final String? gruponombre;

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
    this.turnos = const [],
       this.grupoId,
        this.gruponombre,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"] ?? 0,
        nombre: json["nombre"].toString().fixSpanishChars() ?? '',
        apePaterno: json["apePaterno"].toString().fixSpanishChars() ?? '',
        apeMaterno: json["apeMaterno"].toString().fixSpanishChars() ?? '',
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
          turnos: json["turnos"] != null 
            ? List<int>.from(json["turnos"].map((x) => x))
            : [],
             grupoId: json["grupoId"],
        gruponombre: json["gruponombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre?.toString().fixSpanishChars(),
        "apePaterno": apePaterno?.toString().fixSpanishChars(),
        "apeMaterno": apeMaterno?.toString().fixSpanishChars(),
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
         "turnos": List<dynamic>.from(turnos!.map((x) => x)),
           "grupoId": grupoId,
        "gruponombre": gruponombre,
      };

       Value copyWith({
    int? id,
    // ... (otros campos)
    List<int>? turnos,
  }) {
    return Value(
      id: id ?? this.id,
      // ... (otros campos)
      turnos: turnos ?? this.turnos,
    );
  }
  
}extension StringUtils on String {
  String fixSpanishChars() {
    const replacements = {
      'Ã¡': 'á',
      'Ã©': 'é',
      'Ã³': 'ó',
      'Ãº': 'ú',
      'Ã±': 'ñ',
      'Ã': 'í',
      'Â': '',
     };
    
    String result = this;
    replacements.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
     return result;
  }
}

