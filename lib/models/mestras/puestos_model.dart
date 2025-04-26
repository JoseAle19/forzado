// To parse this JSON data, do
//
//     final puestoModel = puestoModelFromJson(jsonString);

import 'dart:convert';

PuestoModel puestoModelFromJson(String str) => PuestoModel.fromJson(json.decode(str));

String puestoModelToJson(PuestoModel data) => json.encode(data.toJson());

class PuestoModel {
    final bool? success;
    final List<Value>? values;

    PuestoModel({
        this.success,
        this.values,
    });

    factory PuestoModel.fromJson(Map<String, dynamic> json) => PuestoModel(
        success: json["success"],
        values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
    };
}

class Value {
    final int? id;
    final String? descripcion;
    final int? estado;
    final String? aprobadorNivel;
    final List<int>? turnos;

    Value({
        this.id,
        this.descripcion,
        this.estado,
        this.aprobadorNivel,
        this.turnos,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        aprobadorNivel: json["aprobadorNivel"],
        turnos: json["turnos"] == null ? [] : List<int>.from(json["turnos"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "estado": estado,
        "aprobadorNivel": aprobadorNivel,
        "turnos": turnos == null ? [] : List<dynamic>.from(turnos!.map((x) => x)),
    };
}
