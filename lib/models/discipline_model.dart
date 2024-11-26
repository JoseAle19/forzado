// To parse this JSON data, do
//
//     final disciplineModel = disciplineModelFromJson(jsonString);

import 'dart:convert';

DisciplineModel disciplineModelFromJson(String str) => DisciplineModel.fromJson(json.decode(str));

String disciplineModelToJson(DisciplineModel data) => json.encode(data.toJson());

class DisciplineModel {
    final bool success;
    final List<Value> values;

    DisciplineModel({
        required this.success,
        required this.values,
    });

    factory DisciplineModel.fromJson(Map<String, dynamic> json) => DisciplineModel(
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
