// To parse this JSON data, do
//
//     final modelTagsMatriz = modelTagsMatrizFromJson(jsonString);


import 'dart:convert';

ModelTagsMatriz modelTagsMatrizFromJson(String str) => ModelTagsMatriz.fromJson(json.decode(str));

String modelTagsMatrizToJson(ModelTagsMatriz data) => json.encode(data.toJson());

class ModelTagsMatriz {
    final bool success;
    final List<Tags> values;

    ModelTagsMatriz({
        required this.success,
        required this.values,
    });

    factory ModelTagsMatriz.fromJson(Map<String, dynamic> json) => ModelTagsMatriz(
        success: json["success"],
        values: List<Tags>.from(json["values"].map((x) => Tags.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
    };
}

class Tags {
    final int id;
    final int prefijoId;
    final int centroId;
    final String sufijo;
    final int probabilidadId;
    final int impactoId;

    Tags({
        required this.id,
        required this.prefijoId,
        required this.centroId,
        required this.sufijo,
        required this.probabilidadId,
        required this.impactoId,
    });

    factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        id: json["id"],
        prefijoId: json["prefijoId"],
        centroId: json["centroId"],
        sufijo: json["sufijo"],
        probabilidadId: json["probabilidadId"],
        impactoId: json["impactoId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "prefijoId": prefijoId,
        "centroId": centroId,
        "sufijo": sufijo,
        "probabilidadId": probabilidadId,
        "impactoId": impactoId,
    };
}
