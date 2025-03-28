import 'dart:convert';

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
        success: json["success"] ?? false,
        message: json["message"] ?? "No message",
        data: json["data"] != null
            ? List<ForzadoApprove>.from(
                json["data"].map((x) => ForzadoApprove.fromJson(x)))
            : [],
      );
}

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
  String? estado; // Dinámico
  final DateTime? fecha;
  final String? descripcion;
  String? estadoSolicitud; // Dinámico
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
    String? estado = json["estado"];
    estado = estado != null ? validateEstado(estado) : null;

    return ForzadoApprove(
      id: json["id"],
      nombre: json["nombre"],
      area: json["area"],
      subarea: json["subarea"],
      tipo: json["tipo"],
      solicitante: utf8.decode(
          latin1.encode(
            json["solicitante"],
          ),
          allowMalformed: true),
      aprobador: utf8.decode(
          latin1.encode(
            json["aprobador"],
          ),
          allowMalformed: true),
      ejecutor: utf8.decode(
          latin1.encode(
            json["ejecutor"],
          ),
          allowMalformed: true),
      solicitanteAId: json["solicitanteAId"],
      aprobadorAId: json["aprobadorAId"],
      ejecutorAId: json["ejecutorAId"],
      solicitanteBId: json["solicitanteBId"],
      aprobadorBId: json["aprobadorBId"],
      ejecutorBId: json["ejecutorBId"],
      estado: estado,
      fecha: json["fecha"] != null ? DateTime.parse(json["fecha"]) : null,
      descripcion: json["descripcion"],
      estadoSolicitud: json["estadoSolicitud"],
      fechaRealizacion: json["fechaRealizacion"] != null
          ? DateTime.parse(json["fechaRealizacion"])
          : null,
      fechaCierre: json["fechaCierre"],
      usuarioCreacion: json["usuarioCreacion"],
      fechaCreacion: json["fechaCreacion"] != null
          ? DateTime.parse(json["fechaCreacion"])
          : null,
      usuarioModificacion: json["usuarioModificacion"],
      fechaModificacion: json["fechaModificacion"] != null
          ? DateTime.parse(json["fechaModificacion"])
          : null,
      subareaCodigo: json["subareaCodigo"],
      subareaDescripcion: json["subareaDescripcion"],
      disciplinaDescripcion: json["disciplinaDescripcion"],
      turnoDescripcion: json["turnoDescripcion"],
      motivoRechazoDescripcion: json["motivoRechazoDescripcion"],
      tipoForzadoDescripcion: json["tipoForzadoDescripcion"],
      tagCentroCodigo: json["tagCentroCodigo"],
      tagCentroDescripcion: json["tagCentroDescripcion"],
      responsableNombre: json["responsableNombre"],
      riesgoDescripcion: json["riesgoDescripcion"],
      interlock: json["interlock"],
      proyectoDescripcion: json["proyectoDescripcion"],
      proyectoId: json["proyectoId"],
    );
  }

  // Validación de estado
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
