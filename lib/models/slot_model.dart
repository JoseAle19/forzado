// To parse this JSON data, do
//
//     final slotModel = slotModelFromJson(jsonString);

import 'dart:convert';

SlotModel slotModelFromJson(String str) => SlotModel.fromJson(json.decode(str));

String slotModelToJson(SlotModel data) => json.encode(data.toJson());

class SlotModel {
    final bool success;
    final List<Value> values;

    SlotModel({
        required this.success,
        required this.values,
    });

    factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
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
