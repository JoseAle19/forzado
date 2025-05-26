// To parse this JSON data, do
//
//     final modelForzadoById = modelForzadoByIdFromJson(jsonString);

import 'dart:convert';

ModelForzadoById modelForzadoByIdFromJson(String str) =>
    ModelForzadoById.fromJson(json.decode(str));

class ModelForzadoById {
  bool? success;
  String? message;
  List<ForzadoId>? data;

  ModelForzadoById({
    this.success,
    this.message,
    this.data,
  });

  factory ModelForzadoById.fromJson(Map<String, dynamic> json) =>
      ModelForzadoById(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ForzadoId>.from(
                json["data"]!.map((x) => ForzadoId.fromJson(x))),
      );
}

class ForzadoId {
  int? id;
  int? proyecto;
  int? tagPrefijo;
  int? tagCentro;
  String? tagSubfijo;
  String? descripcion;
  int? disciplina;
  int? turno;
  int? interlockSeguridad;
  int? responsable;
  String? riesgo;
  int? probabilidad;
  String? impacto;
  int? solicitante;
  int? aprobador;
  int? ejecutor;
  String? autorizacion;
  int? tipoForzado;

  ForzadoId({
    this.id,
    this.proyecto,
    this.tagPrefijo,
    this.tagCentro,
    this.tagSubfijo,
    this.descripcion,
    this.disciplina,
    this.turno,
    this.interlockSeguridad,
    this.responsable,
    this.riesgo,
    this.probabilidad,
    this.impacto,
    this.solicitante,
    this.aprobador,
    this.ejecutor,
    this.autorizacion,
    this.tipoForzado,
  });

  factory ForzadoId.fromJson(Map<String, dynamic> json) => ForzadoId(
        id: json["id"],
        proyecto: json["proyecto"],
        tagPrefijo: json["tagPrefijo"],
        tagCentro: json["tagCentro"],
        tagSubfijo: json["tagSubfijo"],
        descripcion: json["descripcion"],
        disciplina: json["disciplina"],
        turno: json["turno"],
        interlockSeguridad: json["interlockSeguridad"],
        responsable: json["responsable"],
        riesgo: json["riesgo"],
        probabilidad: json["probabilidad"],
        impacto: json["impacto"],
        solicitante: json["solicitante"],
        aprobador: json["aprobador"],
        ejecutor: json["ejecutor"],
        autorizacion: json["autorizacion"],
        tipoForzado: json["tipoForzado"],
      );
}
