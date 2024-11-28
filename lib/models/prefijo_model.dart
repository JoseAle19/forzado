// To parse this JSON data, do
//
//     final prefijoModel = prefijoModelFromJson(jsonString);

import 'dart:convert';

PrefijoModel prefijoModelFromJson(String str) => PrefijoModel.fromJson(json.decode(str));

String prefijoModelToJson(PrefijoModel data) => json.encode(data.toJson());

class PrefijoModel {
    final bool success;
    final List<Value> values;

    PrefijoModel({
        required this.success,
        required this.values,
    });

    factory PrefijoModel.fromJson(Map<String, dynamic> json) => PrefijoModel(
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
