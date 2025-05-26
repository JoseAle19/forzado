// To parse this JSON data, do
//
//     final forzadosModel = forzadosModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

ForzadosModel forzadosModelFromJson(String str) =>
    ForzadosModel.fromJson(json.decode(str));

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
        data: json["data"] == null
            ? []
            : List<ForzadoItem>.from(
                json["data"]!.map((x) => ForzadoItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ForzadoItem {
  int? id;
  String? nombre;
  String? area;
  String? subarea;
  String? tipo;
  String? solicitante;
  String? aprobador;
  String? ejecutor;
  int? solicitanteAId;
  int? aprobadorAId;
  int? ejecutorAId;
  int? solicitanteBId;
  int? aprobadorBId;
  int? ejecutorBId;
  String? estado;
  DateTime? fecha;
  String? descripcion;
  String? estadoSolicitud;
  DateTime? fechaRealizacion;
  DateTime? fechaCierre;
  String? usuarioCreacion;
  DateTime? fechaCreacion;
  String? usuarioModificacion;
  DateTime? fechaModificacion;
  String? subareaCodigo;
  String? subareaDescripcion;
  String? disciplinaDescripcion;
  String? turnoDescripcion;
  String? motivoRechazoDescripcion;
  String? tipoForzadoDescripcion;
  String? tagCentroCodigo;
  String? tagCentroDescripcion;
  String? responsableNombre;
  String? riesgoDescripcion;
  int? interlock;
  String? proyectoDescripcion;
  int? proyectoId;
  bool? observadoEjecucion;
  String? tagConcat;
  String? reiniciado;
  String? tagPrefijo;
  String? tagSufijo;
  String? etapa;
  String? probabilidad;
  String? impacto;
  String? nivelRiesgo;
  String? impactoDescripcion;
  String? probabilidadDescripcion;

  ForzadoItem({
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
    this.observadoEjecucion,
    this.tagConcat,
    // Nuevos campos
    this.reiniciado,
    this.tagPrefijo,
    this.tagSufijo,
    this.etapa,
    this.probabilidadDescripcion,
    this.impactoDescripcion,
    this.nivelRiesgo,
  });
  factory ForzadoItem.fromJson(Map<String, dynamic> json) => ForzadoItem(
      id: json["id"] ?? 0,
      nombre: json["nombre"] ?? "",
      area: json["area"] ?? "",
      subarea: json["subarea"] ?? "",
      tipo: json["tipo"] ?? "",
      solicitante: json["solicitante"] ?? "",
      aprobador: json["aprobador"] ?? "",
      ejecutor: json["ejecutor"] ?? "",
      solicitanteAId: json["solicitanteAId"] ?? 0,
      aprobadorAId: json["aprobadorAId"] ?? 0,
      ejecutorAId: json["ejecutorAId"] ?? 0,
      solicitanteBId: json["solicitanteBId"] ?? 0,
      aprobadorBId: json["aprobadorBId"] ?? 0,
      ejecutorBId: json["ejecutorBId"] ?? 0,
      estado: json["estado"] ?? "",
      fecha: json["fecha"] == null ? null : DateTime.tryParse(json["fecha"]),
      estadoSolicitud: json["estadoSolicitud"] ?? "",
      fechaRealizacion: json["fechaRealizacion"] == null
          ? null
          : DateTime.tryParse(json["fechaRealizacion"]),
       usuarioCreacion: json["usuarioCreacion"] ?? "",
      fechaCreacion: json["fechaCreacion"] == null
          ? null
          : DateTime.tryParse(json["fechaCreacion"]),
      fechaCierre: json["fechaCierre"] == null
          ? null
          : DateTime.tryParse(json["fechaCierre"]),
      usuarioModificacion: json["usuarioModificacion"] ?? "",
      fechaModificacion: json["fechaModificacion"] == null
          ? null
          : DateTime.tryParse(json["fechaModificacion"]),
      subareaCodigo: json["subareaCodigo"] ?? "",
      subareaDescripcion: json["subareaDescripcion"] ?? "",
      disciplinaDescripcion: json["disciplinaDescripcion"] ?? "",
      turnoDescripcion: json["turnoDescripcion"] ?? "",
      motivoRechazoDescripcion: json["motivoRechazoDescripcion"] ?? "",
      tipoForzadoDescripcion: json["tipoForzadoDescripcion"] ?? "",
      tagCentroCodigo: json["tagCentroCodigo"] ?? "",
      tagCentroDescripcion: json["tagCentroDescripcion"] ?? "",
      responsableNombre: json["responsableNombre"] ?? "",
      riesgoDescripcion: json["riesgoDescripcion"] ?? "",
      interlock: json["interlock"] ?? 0,
      proyectoDescripcion: json["proyectoDescripcion"] ?? "",
      descripcion: json["descripcion"] ?? "",
      proyectoId: json["proyectoId"] ?? 0,
      observadoEjecucion: json["observadoEjecucion"] == null ? false : true,
      tagConcat: json['tagConcat'],
      reiniciado:json['reiniciado'],
      tagPrefijo:json['tagPrefijo'],
      tagSufijo:json['tagSufijo'],
      etapa:json['etapa'],
      probabilidadDescripcion:json['probabilidadDescripcion'],
      impactoDescripcion:json['impactoDescripcion'],
      nivelRiesgo:json['riesgoDescripcion'],
      
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "area": area,
        "subarea": subarea,
        "tipo": tipo,
        "solicitante": solicitante,
        "aprobador": aprobador,
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
        "turnoDescripcion": turnoDescripcion,
        "motivoRechazoDescripcion": motivoRechazoDescripcion,
        "tipoForzadoDescripcion": tipoForzadoDescripcion,
        "tagCentroCodigo": tagCentroCodigo,
        "tagCentroDescripcion": tagCentroDescripcion,
        "responsableNombre": responsableNombre,
        "riesgoDescripcion": riesgoDescripcion,
        "interlock": interlock,
        "proyectoDescripcion": proyectoDescripcion,
        "proyectoId": proyectoId,
        "observadoEjecucion": observadoEjecucion,
        'tagConcat': tagConcat
      };
}
