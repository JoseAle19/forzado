import 'package:hive/hive.dart';

part 'forzado.g.dart';

@HiveType(typeId: 3)
class Forzado extends HiveObject {
  @HiveField(0)
  String? tagPrefijo;

  @HiveField(1)
  String? tagCentro;

  @HiveField(2)
  String? descripcion;

  @HiveField(3)
  String? disciplina;

  @HiveField(4)
  String? turno;

  @HiveField(5)
  String? iterlockSeguridad;

  @HiveField(6)
  String? responsable;

  @HiveField(7)
  String? riesgoA;

  @HiveField(8)
  String? probabilidad;

  @HiveField(9)
  String? impacto;

  @HiveField(10)
  String? riesgo;

  @HiveField(11)
  String? solicitante;

  @HiveField(12)
  String? aprobador;

  @HiveField(13)
  String? ejecutor;

  @HiveField(14)
  String? autorizacion;

  @HiveField(15)
  String? tipoDeForzado;

  Forzado({
    this.tagPrefijo,
    this.tagCentro,
    this.descripcion,
    this.disciplina,
    this.turno,
    this.iterlockSeguridad,
    this.responsable,
    this.riesgoA,
    this.probabilidad,
    this.impacto,
    this.riesgo,
    this.solicitante,
    this.aprobador,
    this.ejecutor,
    this.autorizacion,
    this.tipoDeForzado,
  });
}
