// To parse this JSON data, do
//
//     final apiResponseDetailUser = apiResponseDetailUserFromJson(jsonString);

import 'dart:convert';

ApiResponseDetailUser apiResponseDetailUserFromJson(String str) =>
    ApiResponseDetailUser.fromJson(json.decode(str));

String apiResponseDetailUserToJson(ApiResponseDetailUser data) =>
    json.encode(data.toJson());

class ApiResponseDetailUser {
  final int id;
  final String name;
  final String area;
  final Map<String, String> roles;
  final int flagNuevoIngreso;
  final String jwt;
  final String? message;
  final String? grupo;
  final int? grupoId;
  
 
  ApiResponseDetailUser({
    required this.id,
    required this.name,
    required this.area,
    required this.roles,
    required this.flagNuevoIngreso,
    required this.jwt,
    this.message,
    this.grupo,
    this.grupoId,
  });

  factory ApiResponseDetailUser.fromJson(Map<String, dynamic> json) =>
      ApiResponseDetailUser(
        id: json["id"],
        name: json["name"],
        area: json["area"],
        roles: Map.from(json["roles"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        flagNuevoIngreso: json["flagNuevoIngreso"],
        jwt: json["jwt"],
        message: json["message"],
        grupo: json["grupo"],
        grupoId: json["grupoid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area": area,
        "roles": Map.from(roles).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "flagNuevoIngreso": flagNuevoIngreso,
        "jwt": jwt,
      };
  factory ApiResponseDetailUser.error({required String message}) {
    return ApiResponseDetailUser(
        message: message,
        id: 1,
        flagNuevoIngreso: 0,
        area: '',
        jwt: '',
        name: '',
        roles: {});
  }

  get roleName => null;
}
