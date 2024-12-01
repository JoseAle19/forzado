import 'dart:convert';

ModelListRemove modelListRemoveFromJson(String str) =>
    ModelListRemove.fromJson(json.decode(str));

String modelListRemoveToJson(ModelListRemove data) =>
    json.encode(data.toJson());

class ModelListRemove {
  final bool success;
  final String message;
  final List<Datum> data;

  ModelListRemove({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ModelListRemove.fromJson(Map<String, dynamic> json) =>
      ModelListRemove(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int? id;
  final String nombre;
  final String? area;
  final String? solicitante;
  final String? estado;
  final DateTime? fecha;
  final String? descripcion;
  final String? estadoSolicitud;
  final dynamic fechaRealizacion;
  final dynamic fechaCierre;
  final String? usuarioCreacion;
  final DateTime? fechaCreacion;
  final String? usuarioModificacion;
  final DateTime? fechaModificacion;
  final String? subareaCodigo;
  final String? subareaDescripcion;
  final String? disciplinaDescripcion;
  final TurnoDescripcion? turnoDescripcion;
  final String? motivoRechazoDescripcion;
  final TipoForzadoDescripcion? tipoForzadoDescripcion;
  final String? tagCentroCodigo;
  final String? tagCentroDescripcion;
  final ResponsableNombre? responsableNombre;
  final RiesgoDescripcion? riesgoDescripcion;

  Datum({
    this.id,
    required this.nombre,
    this.area,
    this.solicitante,
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 'no información',
        nombre: json["nombre"] ?? 'no información',
        area: json["area"] ?? 'no información',
        solicitante: json["solicitante"] ?? 'no información',
        estado: json["estado"] ?? 'no información',
        fecha: DateTime.parse(json["fecha"]),
        descripcion: json["descripcion"] ?? 'no información',
        estadoSolicitud: json["estadoSolicitud"] ?? 'no información',
        fechaRealizacion: json["fechaRealizacion"] ?? 'no información',
        fechaCierre: json["fechaCierre"] ?? 'no información',
        usuarioCreacion: json["usuarioCreacion"] ?? 'no información',
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        usuarioModificacion: json["usuarioModificacion"] ?? 'no información',
        fechaModificacion:
            DateTime.parse(json["fechaModificacion"]),
        subareaCodigo: json["subareaCodigo"] ?? 'no información',
        subareaDescripcion: json["subareaDescripcion"] ?? 'no información',
        disciplinaDescripcion: json["disciplinaDescripcion"] ?? 'no información',
        turnoDescripcion:
            turnoDescripcionValues.map[json["turnoDescripcion"]],
        motivoRechazoDescripcion:
            json["motivoRechazoDescripcion"] ?? 'no información',
        tipoForzadoDescripcion:
            tipoForzadoDescripcionValues.map[json["tipoForzadoDescripcion"]],
        tagCentroCodigo: json["tagCentroCodigo"] ?? 'no información',
        tagCentroDescripcion: json["tagCentroDescripcion"] ?? 'no información',
        responsableNombre:
            responsableNombreValues.map[json["responsableNombre"]]!,
        riesgoDescripcion:
            riesgoDescripcionValues.map[json["riesgoDescripcion"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "area": area,
        "solicitante": solicitante,
        "estado": estado,
        "fecha": fecha?.toIso8601String(),
        "descripcion": descripcion,
        "estadoSolicitud": estadoSolicitud,
        "fechaRealizacion": fechaRealizacion,
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
        "tipoForzadoDescripcion":
            tipoForzadoDescripcionValues.reverse[tipoForzadoDescripcion],
        "tagCentroCodigo": tagCentroCodigo,
        "tagCentroDescripcion": tagCentroDescripcion,
        "responsableNombre": responsableNombreValues.reverse[responsableNombre],
        "riesgoDescripcion": riesgoDescripcionValues.reverse[riesgoDescripcion],
      };
}

enum ResponsableNombre { GERENCIA_ASSET_PERFOMANCE, GERENCIA_PLANTA }

final responsableNombreValues = EnumValues({
  "GERENCIA ASSET. PERFOMANCE": ResponsableNombre.GERENCIA_ASSET_PERFOMANCE,
  "GERENCIA PLANTA": ResponsableNombre.GERENCIA_PLANTA
});

enum RiesgoDescripcion { EQUIPOS, PERSONAS }

final riesgoDescripcionValues = EnumValues({
  "EQUIPOS": RiesgoDescripcion.EQUIPOS,
  "PERSONAS": RiesgoDescripcion.PERSONAS
});

enum TipoForzadoDescripcion { HARDWARE }

final tipoForzadoDescripcionValues =
    EnumValues({"HARDWARE": TipoForzadoDescripcion.HARDWARE});

enum TurnoDescripcion { A, B }

final turnoDescripcionValues =
    EnumValues({"A": TurnoDescripcion.A, "B": TurnoDescripcion.B});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
