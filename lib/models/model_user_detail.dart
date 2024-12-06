// To parse this JSON data, do
//
//     final apiResponseDetailUser = apiResponseDetailUserFromJson(jsonString);

import 'dart:convert';

ApiResponseDetailUser apiResponseDetailUserFromJson(String str) => ApiResponseDetailUser.fromJson(json.decode(str));

String apiResponseDetailUserToJson(ApiResponseDetailUser data) => json.encode(data.toJson());

class ApiResponseDetailUser {
    final int id;
    final String name;
    final String area;
    final int role;
    final int flagNuevoIngreso;
    final String jwt;

    ApiResponseDetailUser({
        required this.id,
        required this.name,
        required this.area,
        required this.role,
        required this.flagNuevoIngreso,
        required this.jwt,
    });

    factory ApiResponseDetailUser.fromJson(Map<String, dynamic> json) => ApiResponseDetailUser(
        id: json["id"],
        name: json["name"],
        area: json["area"],
        role: json["role"],
        flagNuevoIngreso: json["flagNuevoIngreso"],
        jwt: json["jwt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area": area,
        "role": role,
        "flagNuevoIngreso": flagNuevoIngreso,
        "jwt": jwt,
    };
}
