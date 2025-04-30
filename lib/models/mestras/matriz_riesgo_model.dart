 
import 'dart:convert';

MatrizRiesgoModel matrizRiesgoFromJson(String str) => MatrizRiesgoModel.fromJson(json.decode(str));

String matrizRiesgoToJson(MatrizRiesgoModel data) => json.encode(data.toJson());

class MatrizRiesgoModel {
    final bool? success;
    final List<MatrizRiesgoValue>? values;

    MatrizRiesgoModel({
        this.success,
        this.values,
    });

    factory MatrizRiesgoModel.fromJson(Map<String, dynamic> json) => MatrizRiesgoModel(
        success: json["success"],
        values: json["values"] == null ? [] : List<MatrizRiesgoValue>.from(json["values"]!.map((x) => MatrizRiesgoValue.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
    };
}

class MatrizRiesgoValue {
    final int? id;
    final int? impactoId;
    final int? riesgoId;
    final int? probabilidadId;
    final int? nivel;
    final int? estado;
    final String? usuarioCreacion;
    final DateTime? fechaCreacion;
    final dynamic usuarioModificacion;
    final dynamic fechaModificacion;
    final String? impactoDescripcion;
    final String? probabilidadDescripcion;
    final String? riesgoDescripcion;

    MatrizRiesgoValue({
        this.id,
        this.impactoId,
        this.riesgoId,
        this.probabilidadId,
        this.nivel,
        this.estado,
        this.usuarioCreacion,
        this.fechaCreacion,
        this.usuarioModificacion,
        this.fechaModificacion,
        this.impactoDescripcion,
        this.probabilidadDescripcion,
        this.riesgoDescripcion,
    });

    factory MatrizRiesgoValue.fromJson(Map<String, dynamic> json) => MatrizRiesgoValue(
        id: json["id"],
        impactoId: json["impacto_id"],
        riesgoId: json["riesgo_id"],
        probabilidadId: json["probabilidad_id"],
        nivel: json["nivel"],
        estado: json["estado"],
        usuarioCreacion: json["usuario_creacion"]??'N/A',
        fechaCreacion: json["fecha_creacion"] == null ? null : DateTime.parse(json["fecha_creacion"]),
        usuarioModificacion: json["usuario_modificacion"],
        fechaModificacion: json["fecha_modificacion"],
        impactoDescripcion: json["impacto_descripcion"],
        probabilidadDescripcion: json["probabilidad_descripcion"],
        riesgoDescripcion: json["riesgo_descripcion"]??'N/A',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "impacto_id": impactoId,
        "riesgo_id": riesgoId,
        "probabilidad_id": probabilidadId,
        "nivel": nivel,
        "estado": estado,
        "usuario_creacion": usuarioCreacionValues.reverse[usuarioCreacion],
        "fecha_creacion": fechaCreacion?.toIso8601String(),
        "usuario_modificacion": usuarioModificacion,
        "fecha_modificacion": fechaModificacion,
        "impacto_descripcion": impactoDescripcion,
        "probabilidad_descripcion": probabilidadDescripcion,
        "riesgo_descripcion": riesgoDescripcionValues.reverse[riesgoDescripcion],
    };
}

enum RiesgoDescripcion {
    ALTO,
    BAJO,
    MODERADO
}

final riesgoDescripcionValues = EnumValues({
    "ALTO": RiesgoDescripcion.ALTO,
    "BAJO": RiesgoDescripcion.BAJO,
    "MODERADO": RiesgoDescripcion.MODERADO
});

enum UsuarioCreacion {
    ADM
}

final usuarioCreacionValues = EnumValues({
    "ADM": UsuarioCreacion.ADM
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
