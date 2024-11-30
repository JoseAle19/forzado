// To parse this JSON data, do
//
//     final modelOne = modelOneFromJson(jsonString);

import 'dart:convert';

ModelOne modelOneFromJson(String str) => ModelOne.fromJson(json.decode(str));

String modelOneToJson(ModelOne data) => json.encode(data.toJson());

class ModelOne {
    final bool success;
    final List<Value> values;

    ModelOne({
        required this.success,
        required this.values,
    });

    factory ModelOne.fromJson(Map<String, dynamic> json) => ModelOne(
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
        id: json["id"] ??000,
        codigo: json["codigo"] ??'Sin informacion',
        descripcion: json["descripcion"] ??'Sin informacion',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "descripcion": descripcion,
    };
}
