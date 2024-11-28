// To parse this JSON data, do
//
//     final impactModel = impactModelFromJson(jsonString);

import 'dart:convert';

ImpactModel impactModelFromJson(String str) => ImpactModel.fromJson(json.decode(str));

String impactModelToJson(ImpactModel data) => json.encode(data.toJson());

class ImpactModel {
    final bool success;
    final List<Value> values;

    ImpactModel({
        required this.success,
        required this.values,
    });

    factory ImpactModel.fromJson(Map<String, dynamic> json) => ImpactModel(
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
