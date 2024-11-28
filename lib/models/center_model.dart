// To parse this JSON data, do
//
//     final centroModel = CenterModelFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
CenterModel CenterModelFromJson(String str) => CenterModel.fromJson(json.decode(str));

String centerModelToJson(CenterModel data) => json.encode(data.toJson());

class CenterModel {
    final bool success;
    final List<Value> values;

    CenterModel({
        required this.success,
        required this.values,
    });

    factory CenterModel.fromJson(Map<String, dynamic> json) => CenterModel(
        success: json["success"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
    };
}

class Value {
    final int id;
    final String codigo;
    final String descripcion;

    Value({
        required this.id,
        required this.codigo,
        required this.descripcion,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        codigo: json["codigo"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
    };
}
