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
  @HiveField(16)
  String? interlock;
  // Descripciones
  @HiveField(17)
  String? tagPrefijoDescription;

  @HiveField(18)
  String? tagCentroDescription;

  @HiveField(19)
  String? descripcionDescription;

  @HiveField(20)
  String? disciplinaDescription;

  @HiveField(21)
  String? turnoDescription;

  @HiveField(22)
  String? iterlockSeguridadDescription;

  @HiveField(23)
  String? responsableDescription;

  @HiveField(24)
  String? riesgoADescription;

  @HiveField(25)
  String? probabilidadDescription;

  @HiveField(26)
  String? impactoDescription;

  @HiveField(27)
  String? riesgoDescription;

  @HiveField(28)
  String? solicitanteDescription;

  @HiveField(29)
  String? aprobadorDescription;

  @HiveField(30)
  String? ejecutorDescription;

  @HiveField(31)
  String? autorizacionDescription;

  @HiveField(32)
  String? tipoDeForzadoDescription;
  @HiveField(33)
  String? interlockDescription;
  @HiveField(34)
  String? status;

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
    this.interlock,
    this.tagPrefijoDescription,
    this.tagCentroDescription,
    this.descripcionDescription,
    this.disciplinaDescription,
    this.turnoDescription,
    this.iterlockSeguridadDescription,
    this.responsableDescription,
    this.riesgoADescription,
    this.probabilidadDescription,
    this.impactoDescription,
    this.riesgoDescription,
    this.solicitanteDescription,
    this.aprobadorDescription,
    this.ejecutorDescription,
    this.autorizacionDescription,
    this.tipoDeForzadoDescription,
    this.interlockDescription,
    this.status,
  });
}
