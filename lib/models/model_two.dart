// To parse this JSON data, do
//
//     final modelTwo = modelTwoFromJson(jsonString);

import 'dart:convert';

import 'package:forzado/core/abstract/dropdown_item.dart';

ModelTwo modelTwoFromJson(String str) => ModelTwo.fromJson(json.decode(str));

String modelTwoToJson(ModelTwo data) => json.encode(data.toJson());

class ModelTwo {
  final bool success;
  final List<Value> values;

  ModelTwo({
    required this.success,
    required this.values,
  });

  factory ModelTwo.fromJson(Map<String, dynamic> json) => ModelTwo(
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
  final String descripcion;

  Value({
    required this.id,
    required this.descripcion,
  });
  @override
  String getLabel() => descripcion;

  @override
  int get idT => id;
  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"] ?? 0000,
        descripcion: json["descripcion"] ?? 'Sin informacion',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}
