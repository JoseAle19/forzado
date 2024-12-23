// To parse this JSON data, do
//
//     final jwtModel = jwtModelFromJson(jsonString);

import 'dart:convert';

JwtModel jwtModelFromJson(String str) => JwtModel.fromJson(json.decode(str));

String jwtModelToJson(JwtModel data) => json.encode(data.toJson());

class JwtModel {
  final String email;
  final String name;
  final int areaId;
  final String areaName;
  final int iat;
  final int exp;

  JwtModel({
    required this.email,
    required this.name,
    required this.areaId,
    required this.areaName,
    required this.iat,
    required this.exp,
  });

  factory JwtModel.fromJson(Map<String, dynamic> json) => JwtModel(
        email: json["email"],
        name: json["name"],
        areaId: json["areaId"],
        areaName: json["areaName"],
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "areaId": areaId,
        "areaName": areaName,
        "iat": iat,
        "exp": exp,
      };
}
