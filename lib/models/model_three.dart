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

  Value({
    required this.id,
    required this.nombre,
  });

  @override
  String getLabel() => nombre;

  @override
  int get idT => id;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"] ?? 0000,
        nombre: json["nombre"] ?? 'Sin informacion',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
