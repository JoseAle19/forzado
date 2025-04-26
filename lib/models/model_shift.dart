 

import 'dart:convert';

ShiftModel shiftModelFromJson(String str) => ShiftModel.fromJson(json.decode(str));

String shiftModelToJson(ShiftModel data) => json.encode(data.toJson());

class ShiftModel {
    final bool? success;
    final List<Value>? values;

    ShiftModel({
        this.success,
        this.values,
    });

    factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
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
    final String? horaInicio;
    final String? horaFin;

    Value({
        this.id,
        this.descripcion,
        this.horaInicio,
        this.horaFin,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        descripcion: json["descripcion"],
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "horaInicio": horaInicio,
        "horaFin": horaFin,
    };
}
