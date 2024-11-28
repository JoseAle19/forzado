// To parse this JSON data, do
//
//     final riesgoAModel = riesgoAModelFromJson(jsonString);

import 'dart:convert';

RiesgoAModel riesgoAModelFromJson(String str) => RiesgoAModel.fromJson(json.decode(str));

String riesgoAModelToJson(RiesgoAModel data) => json.encode(data.toJson());

class RiesgoAModel {
    final bool success;
    final List<Value> values;

    RiesgoAModel({
        required this.success,
        required this.values,
    });

    factory RiesgoAModel.fromJson(Map<String, dynamic> json) => RiesgoAModel(
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
