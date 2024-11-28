// To parse this JSON data, do
//
//     final responsabilityModel = responsabilityModelFromJson(jsonString);

import 'dart:convert';

ResponsabilityModel responsabilityModelFromJson(String str) => ResponsabilityModel.fromJson(json.decode(str));

String responsabilityModelToJson(ResponsabilityModel data) => json.encode(data.toJson());

class ResponsabilityModel {
    final bool success;
    final List<Value> values;

    ResponsabilityModel({
        required this.success,
        required this.values,
    });

    factory ResponsabilityModel.fromJson(Map<String, dynamic> json) => ResponsabilityModel(
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
    final String nombre;

    Value({
        required this.id,
        required this.nombre,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
