// To parse this JSON data, do
//
//     final tipoForzado = tipoForzadoFromJson(jsonString);

import 'dart:convert';

TipoForzado tipoForzadoFromJson(String str) => TipoForzado.fromJson(json.decode(str));

String tipoForzadoToJson(TipoForzado data) => json.encode(data.toJson());

class TipoForzado {
    final bool success;
    final List<Value> values;

    TipoForzado({
        required this.success,
        required this.values,
    });

    factory TipoForzado.fromJson(Map<String, dynamic> json) => TipoForzado(
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
