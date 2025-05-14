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
        success: json["success"] ?? false,  
        values: List<Tags>.from((json["values"] ?? []).map((x) => Tags.fromJson(x))), 
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
    };
}

class Tags {
    final int? id; 
    final int? prefijoId;
    final int? centroId;
    final String? sufijo;
    final int? probabilidadId;
    final int? impactoId;
    final int? riesgoAId;
    final int? interlock;

    Tags({
        this.id,
        this.prefijoId,
        this.centroId,
        this.sufijo,
        this.probabilidadId,
        this.impactoId,
        this.riesgoAId,
        this.interlock,
    });

    factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        id: _parseInt(json["id"]),
        prefijoId: _parseInt(json["prefijoId"]),
        centroId: _parseInt(json["centroId"]),
        sufijo: json["sufijo"]?.toString(),
        probabilidadId: _parseInt(json["probabilidadId"]),
        impactoId: _parseInt(json["impactoId"]),
        riesgoAId: _parseInt(json["riesgoAId"]),
        interlock: _parseInt(json["interlock"]),
    );

    static int? _parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "prefijoId": prefijoId,
        "centroId": centroId,
        "sufijo": sufijo,
        "probabilidadId": probabilidadId,
        "impactoId": impactoId,
        "riesgoAId": riesgoAId,
        "interlock": interlock,
    };
}