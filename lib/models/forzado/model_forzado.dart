// To parse this JSON data, do
//
//     final forzadosModel = forzadosModelFromJson(jsonString);

import 'dart:convert';

ForzadosModel forzadosModelFromJson(String str) => ForzadosModel.fromJson(json.decode(str));

String forzadosModelToJson(ForzadosModel data) => json.encode(data.toJson());

class ForzadosModel {
    final bool? success;
    final String? message;
    final List<ForzadoItem>? data;

    ForzadosModel({
        this.success,
        this.message,
        this.data,
    });

    factory ForzadosModel.fromJson(Map<String, dynamic> json) => ForzadosModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<ForzadoItem>.from(json["data"]!.map((x) => ForzadoItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ForzadoItem {
    final int? id;
    final String? nombre;
    final String? area;
    final Tipo? tipo;
    final String? solicitante;
    final Aprobador? aprobador;
    final String? ejecutor;
    final int? solicitanteAId;
    final int? aprobadorAId;
    final int? ejecutorAId;
    final int? solicitanteBId;
    final int? aprobadorBId;
    final int? ejecutorBId;
    final String? estado;
    final DateTime? fecha;
    final String? descripcion;
    final String? estadoSolicitud;
    final DateTime? fechaRealizacion;
    final dynamic fechaCierre;
    final String? usuarioCreacion;
    final DateTime? fechaCreacion;
    final String? usuarioModificacion;
    final DateTime? fechaModificacion;
    final String? subareaCodigo;
    final String? subareaDescripcion;
    final String? disciplinaDescripcion;
    final TurnoDescripcion? turnoDescripcion;
    final dynamic motivoRechazoDescripcion;
    final TipoForzadoDescripcion? tipoForzadoDescripcion;
    final String? tagCentroCodigo;
    final String? tagCentroDescripcion;
    final ResponsableNombre? responsableNombre;
    final RiesgoDescripcion? riesgoDescripcion;

    ForzadoItem({
        this.id,
        this.nombre,
        this.area,
        this.tipo,
        this.solicitante,
        this.aprobador,
        this.ejecutor,
        this.solicitanteAId,
        this.aprobadorAId,
        this.ejecutorAId,
        this.solicitanteBId,
        this.aprobadorBId,
        this.ejecutorBId,
        this.estado,
        this.fecha,
        this.descripcion,
        this.estadoSolicitud,
        this.fechaRealizacion,
        this.fechaCierre,
        this.usuarioCreacion,
        this.fechaCreacion,
        this.usuarioModificacion,
        this.fechaModificacion,
        this.subareaCodigo,
        this.subareaDescripcion,
        this.disciplinaDescripcion,
        this.turnoDescripcion,
        this.motivoRechazoDescripcion,
        this.tipoForzadoDescripcion,
        this.tagCentroCodigo,
        this.tagCentroDescripcion,
        this.responsableNombre,
        this.riesgoDescripcion,
    });

    factory ForzadoItem.fromJson(Map<String, dynamic> json) => ForzadoItem(
        id: json["id"],
        nombre: json["nombre"],
        area: json["area"],
        tipo: tipoValues.map[json["tipo"]]!,
        solicitante: json["solicitante"],
        aprobador: aprobadorValues.map[json["aprobador"]]!,
        ejecutor: json["ejecutor"],
        solicitanteAId: json["solicitanteAId"],
        aprobadorAId: json["aprobadorAId"],
        ejecutorAId: json["ejecutorAId"],
        solicitanteBId: json["solicitanteBId"],
        aprobadorBId: json["aprobadorBId"],
        ejecutorBId: json["ejecutorBId"],
        estado: json["estado"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        descripcion: json["descripcion"],
        estadoSolicitud: json["estadoSolicitud"],
        fechaRealizacion: json["fechaRealizacion"] == null ? null : DateTime.parse(json["fechaRealizacion"]),
        fechaCierre: json["fechaCierre"],
        usuarioCreacion: json["usuarioCreacion"],
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]),
        usuarioModificacion: json["usuarioModificacion"],
        fechaModificacion: json["fechaModificacion"] == null ? null : DateTime.parse(json["fechaModificacion"]),
        subareaCodigo: json["subareaCodigo"],
        subareaDescripcion: json["subareaDescripcion"],
        disciplinaDescripcion: json["disciplinaDescripcion"],
        turnoDescripcion: turnoDescripcionValues.map[json["turnoDescripcion"]]!,
        motivoRechazoDescripcion: json["motivoRechazoDescripcion"],
        tipoForzadoDescripcion: tipoForzadoDescripcionValues.map[json["tipoForzadoDescripcion"]]!,
        tagCentroCodigo: json["tagCentroCodigo"],
        tagCentroDescripcion: json["tagCentroDescripcion"],
        responsableNombre: responsableNombreValues.map[json["responsableNombre"]]!,
        riesgoDescripcion: riesgoDescripcionValues.map[json["riesgoDescripcion"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "area": area,
        "tipo": tipoValues.reverse[tipo],
        "solicitante": solicitante,
        "aprobador": aprobadorValues.reverse[aprobador],
        "ejecutor": ejecutor,
        "solicitanteAId": solicitanteAId,
        "aprobadorAId": aprobadorAId,
        "ejecutorAId": ejecutorAId,
        "solicitanteBId": solicitanteBId,
        "aprobadorBId": aprobadorBId,
        "ejecutorBId": ejecutorBId,
        "estado": estado,
        "fecha": fecha?.toIso8601String(),
        "descripcion": descripcion,
        "estadoSolicitud": estadoSolicitud,
        "fechaRealizacion": fechaRealizacion?.toIso8601String(),
        "fechaCierre": fechaCierre,
        "usuarioCreacion": usuarioCreacion,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "usuarioModificacion": usuarioModificacion,
        "fechaModificacion": fechaModificacion?.toIso8601String(),
        "subareaCodigo": subareaCodigo,
        "subareaDescripcion": subareaDescripcion,
        "disciplinaDescripcion": disciplinaDescripcion,
        "turnoDescripcion": turnoDescripcionValues.reverse[turnoDescripcion],
        "motivoRechazoDescripcion": motivoRechazoDescripcion,
        "tipoForzadoDescripcion": tipoForzadoDescripcionValues.reverse[tipoForzadoDescripcion],
        "tagCentroCodigo": tagCentroCodigo,
        "tagCentroDescripcion": tagCentroDescripcion,
        "responsableNombre": responsableNombreValues.reverse[responsableNombre],
        "riesgoDescripcion": riesgoDescripcionValues.reverse[riesgoDescripcion],
    };
}

enum Aprobador {
    CRISTIAN_CARRILLO
}

final aprobadorValues = EnumValues({
    "Cristian Carrillo ": Aprobador.CRISTIAN_CARRILLO
});

enum ResponsableNombre {
    GERENCIA_ASSET_PERFOMANCE,
    GERENCIA_PLANTA
}

final responsableNombreValues = EnumValues({
    "GERENCIA ASSET. PERFOMANCE": ResponsableNombre.GERENCIA_ASSET_PERFOMANCE,
    "GERENCIA PLANTA": ResponsableNombre.GERENCIA_PLANTA
});

enum RiesgoDescripcion {
    EQUIPOS,
    PERSONAS,
    PROCESOS
}

final riesgoDescripcionValues = EnumValues({
    "EQUIPOS": RiesgoDescripcion.EQUIPOS,
    "PERSONAS": RiesgoDescripcion.PERSONAS,
    "PROCESOS": RiesgoDescripcion.PROCESOS
});

enum Tipo {
    ALTA,
    BAJA
}

final tipoValues = EnumValues({
    "alta": Tipo.ALTA,
    "baja": Tipo.BAJA
});

enum TipoForzadoDescripcion {
    HARDWARE
}

final tipoForzadoDescripcionValues = EnumValues({
    "HARDWARE": TipoForzadoDescripcion.HARDWARE
});

enum TurnoDescripcion {
    A,
    B
}

final turnoDescripcionValues = EnumValues({
    "A": TurnoDescripcion.A,
    "B": TurnoDescripcion.B
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
