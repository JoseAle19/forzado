import 'dart:convert';
import 'dart:convert' show utf8, latin1;

// --- Helpers para parsing seguro ---
T? parseNullable<T>(dynamic value, T Function(dynamic) parser) {
  if (value == null) return null;
  try {
    return parser(value);
  } catch (_) {
    return null;
  }
}

String? parseString(dynamic v) =>
    v == null ? null : v.toString();

int? parseInt(dynamic v) =>
    v == null ? null : (v is int ? v : int.tryParse(v.toString()));

DateTime? parseDateTime(dynamic v) =>
    v == null ? null : DateTime.tryParse(v.toString());

// --- Modelo principal ---
ModelForzadosApprove modelForzadosApproveFromJson(String str) =>
    ModelForzadosApprove.fromJson(json.decode(str));

class ModelForzadosApprove {
  final bool success;
  final String message;
  final List<ForzadoApprove> data;

  ModelForzadosApprove({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ModelForzadosApprove.fromJson(Map<String, dynamic> json) =>
      ModelForzadosApprove(
        success: parseNullable(json["success"], (v) => v == true) ?? false,
        message: parseString(json["message"]) ?? "No message",
        data: (json["data"] as List?)
                ?.map((e) => ForzadoApprove.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

// --- Submodelo con validación de nulls ---
class ForzadoApprove {
  final int? id;
  final String? nombre;
  final String? area;
  final String? subarea;
  final String? tipo;
  final String? solicitante;
  final String? aprobador;
  final String? ejecutor;
  final int? solicitanteAId;
  final int? aprobadorAId;
  final int? ejecutorAId;
  final int? solicitanteBId;
  final int? aprobadorBId;
  final int? ejecutorBId;
  final String? estado; // ya validado más abajo
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
  final String? turnoDescripcion;
  final String? motivoRechazoDescripcion;
  final String? tipoForzadoDescripcion;
  final String? tagCentroCodigo;
  final String? tagCentroDescripcion;
  final String? responsableNombre;
  final String? riesgoDescripcion;
  final int? interlock;
  final String? proyectoDescripcion;
  final int? proyectoId;

  ForzadoApprove({
    this.id,
    this.nombre,
    this.area,
    this.subarea,
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
    this.interlock,
    this.proyectoDescripcion,
    this.proyectoId,
  });

  factory ForzadoApprove.fromJson(Map<String, dynamic> json) {
    // estado viene como String, validamos si no es null
    final rawEstado = parseString(json["estado"]);
    final estado = rawEstado != null ? validateEstado(rawEstado) : null;

    return ForzadoApprove(
      id: parseInt(json["id"]),
      nombre: parseString(json["nombre"]),
      area: parseString(json["area"]),
      subarea: parseString(json["subarea"]),
      tipo: parseString(json["tipo"]),
      solicitante: parseNullable(json["solicitante"], (v) =>
          utf8.decode(latin1.encode(v.toString()), allowMalformed: true)),
      aprobador: parseNullable(json["aprobador"], (v) =>
          utf8.decode(latin1.encode(v.toString()), allowMalformed: true)),
      ejecutor: parseNullable(json["ejecutor"], (v) =>
          utf8.decode(latin1.encode(v.toString()), allowMalformed: true)),
      solicitanteAId: parseInt(json["solicitanteAId"]),
      aprobadorAId: parseInt(json["aprobadorAId"]),
      ejecutorAId: parseInt(json["ejecutorAId"]),
      solicitanteBId: parseInt(json["solicitanteBId"]),
      aprobadorBId: parseInt(json["aprobadorBId"]),
      ejecutorBId: parseInt(json["ejecutorBId"]),
      estado: estado,
      fecha: parseDateTime(json["fecha"]),
      descripcion: parseString(json["descripcion"]),
      estadoSolicitud: parseString(json["estadoSolicitud"]),
      fechaRealizacion: parseDateTime(json["fechaRealizacion"]),
      fechaCierre: json["fechaCierre"], // si quieres DateTime, aplica parseDateTime
      usuarioCreacion: parseString(json["usuarioCreacion"]),
      fechaCreacion: parseDateTime(json["fechaCreacion"]),
      usuarioModificacion: parseString(json["usuarioModificacion"]),
      fechaModificacion: parseDateTime(json["fechaModificacion"]),
      subareaCodigo: parseString(json["subareaCodigo"]),
      subareaDescripcion: parseString(json["subareaDescripcion"]),
      disciplinaDescripcion: parseString(json["disciplinaDescripcion"]),
      turnoDescripcion: parseString(json["turnoDescripcion"]),
      motivoRechazoDescripcion: parseString(json["motivoRechazoDescripcion"]),
      tipoForzadoDescripcion: parseString(json["tipoForzadoDescripcion"]),
      tagCentroCodigo: parseString(json["tagCentroCodigo"]),
      tagCentroDescripcion: parseString(json["tagCentroDescripcion"]),
      responsableNombre: parseString(json["responsableNombre"]),
      riesgoDescripcion: parseString(json["riesgoDescripcion"]),
      interlock: parseInt(json["interlock"]),
      proyectoDescripcion: parseString(json["proyectoDescripcion"]),
      proyectoId: parseInt(json["proyectoId"]),
    );
  }

  // Validación de estado (igual que antes)
  static String validateEstado(String estado) {
    switch (estado.toUpperCase()) {
      case "PENDIENTE-FORZADO":
        return 'PENDIENTE-FORZADO';
      case "PENDIENTE-RETIRO":
        return "PENDIENTE-RETIRO";
      case "RECHAZADO-RETIRO":
        return "RECHAZADO-RETIRO";
      case "RECHAZADO-FORZADO":
        return "RECHAZADO-FORZADO";
      case "APROBADO-RETIRO":
        return "APROBADO-RETIRO";
      case "APROBADO-FORZADO":
        return "APROBADO-FORZADO";
      default:
        return estado;
    }
  }
}
