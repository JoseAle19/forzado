// To parse this JSON data, do
//
//     final probabilityModel = probabilityModelFromJson(jsonString);

import 'dart:convert';

ProbabilityModel probabilityModelFromJson(String str) => ProbabilityModel.fromJson(json.decode(str));

String probabilityModelToJson(ProbabilityModel data) => json.encode(data.toJson());

class ProbabilityModel {
    final bool success;
    final List<Value> values;

    ProbabilityModel({
        required this.success,
        required this.values,
    });

    factory ProbabilityModel.fromJson(Map<String, dynamic> json) => ProbabilityModel(
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
    final String descripcion;

    Value({
        required this.id,
        required this.descripcion,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
    };
}
