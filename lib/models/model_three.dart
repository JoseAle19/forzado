// To parse this JSON data, do
//
//     final modelThree = modelThreeFromJson(jsonString);

import 'dart:convert';

import 'package:forzado/core/abstract/dropdown_item.dart';

ModelThree modelThreeFromJson(String str) =>
    ModelThree.fromJson(json.decode(str));

String modelThreeToJson(ModelThree data) => json.encode(data.toJson());

class ModelThree {
  final bool success;
  final List<Value> values;

  ModelThree({
    required this.success,
    required this.values,
  });

  factory ModelThree.fromJson(Map<String, dynamic> json) => ModelThree(
        success: json["success"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class Value implements DropDownItem {
  final int id;
  final String nombre;
  final String? apePaterno;

  Value({
    required this.id,
    required this.nombre,
    this.apePaterno,
  });

  @override
  String getLabel() => '$nombre';
  @override
  String getCode() => '';

  @override
  int get idT => id;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"] ?? 0000,
        nombre: json["nombre"] ?? 'Sin informacion',
        apePaterno: json["apePaterno"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apePaterno": apePaterno,
      };
      
}
