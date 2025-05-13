library forzado;

import 'package:hive/hive.dart';

part 'forzado.g.dart';

@HiveType(typeId: 3)
class Forzado extends HiveObject {
  // Campos con ID y descripción
  @HiveField(0)
  int? tagPrefijoId;

  @HiveField(1)
  String? tagPrefijoDescripcion;

  @HiveField(2)
  int? tagCentroId;

  @HiveField(3)
  String? tagCentroDescripcion;

  @HiveField(4)
  int? tagDisciplinaId;

  @HiveField(5)
  String? tagDisciplinaDescripcion;

  // Repite el patrón para los demás campos...
  @HiveField(6)
  int? probabilityId;

  @HiveField(7)
  String? probabilityDescripcion;

  @HiveField(8)
  int? impactId;

  @HiveField(9)
  String? impactDescripcion;

  @HiveField(10)
  int? circuitosId;

  @HiveField(11)
  String? circuitosDescripcion;

  @HiveField(12)
  int? riskAId;

  @HiveField(13)
  String? riskADescripcion;

  @HiveField(14)
  int? riskId;

  @HiveField(15)
  String? riskDescripcion;

  @HiveField(16)
  int? grupoId;

  @HiveField(17)
  String? grupoDescripcion;

  @HiveField(18)
  int? applicantId;

  @HiveField(19)
  String? applicantDescripcion;

  @HiveField(20)
  int? responsibilityId;

  @HiveField(21)
  String? responsibilityDescripcion;

  @HiveField(22)
  int? approverId;

  @HiveField(23)
  String? approverDescripcion;

  // Campos originales
  @HiveField(24)
  String description;

  @HiveField(25)
  String subfijo;

  @HiveField(26)
  int? interlock;
  @HiveField(27)
  int? idUsuario;
  @HiveField(28)
  String? dateRequest;
  @HiveField(29)
  String? usuarioDescription;
  @HiveField(30)
  int? shiftId;
  @HiveField(31)
  String? shiftDescription;


  Forzado({
    this.tagPrefijoId,
    this.tagPrefijoDescripcion,
    this.tagCentroId,
    this.tagCentroDescripcion,
    this.tagDisciplinaId,
    this.tagDisciplinaDescripcion,
    this.probabilityId,
    this.probabilityDescripcion,
    this.impactId,
    this.impactDescripcion,
    this.circuitosId,
    this.circuitosDescripcion,
    this.riskAId,
    this.riskADescripcion,
    this.riskId,
    this.riskDescripcion,
    this.grupoId,
    this.grupoDescripcion,
    this.applicantId,
    this.applicantDescripcion,
    this.responsibilityId,
    this.responsibilityDescripcion,
    this.approverId,
    this.approverDescripcion,
    this.description = '',
    this.subfijo = '',
    this.interlock,
    this.idUsuario,
    this.dateRequest,
    this.shiftDescription,
    this.shiftId,
    this.usuarioDescription
  });

  factory Forzado.fromJson(Map<String, dynamic> json) => Forzado(
        tagPrefijoId: json['tagPrefijo']?['id'] as int?,
        tagPrefijoDescripcion: json['tagPrefijo']?['descripcion'] as String?,
        tagCentroId: json['tagCentro']?['id'] as int?,
        tagCentroDescripcion: json['tagCentro']?['descripcion'] as String?,
        tagDisciplinaId: json['tagDisciplina']?['id'] as int?,
        tagDisciplinaDescripcion:
            json['tagDisciplina']?['descripcion'] as String?,
        probabilityId: json['probability']?['id'] as int?,
        probabilityDescripcion: json['probability']?['descripcion'] as String?,
        impactId: json['impact']?['id'] as int?,
        impactDescripcion: json['impact']?['descripcion'] as String?,
        circuitosId: json['circuitos']?['id'] as int?,
        circuitosDescripcion: json['circuitos']?['descripcion'] as String?,
        riskAId: json['riskA']?['id'] as int?,
        riskADescripcion: json['riskA']?['descripcion'] as String?,
        riskId: json['risk']?['id'] as int?,
        riskDescripcion: json['risk']?['descripcion'] as String?,
        grupoId: json['grupo']?['id'] as int?,
        grupoDescripcion: json['grupo']?['descripcion'] as String?,
        applicantId: json['applicant']?['id'] as int?,
        applicantDescripcion: json['applicant']?['descripcion'] as String?,
        responsibilityId: json['responsibility']?['id'] as int?,
        responsibilityDescripcion:
            json['responsibility']?['descripcion'] as String?,
        approverId: json['approver']?['id'] as int?,
        approverDescripcion: json['approver']?['descripcion'] as String?,
        description: json['description'] as String? ?? '',
        subfijo: json['subfijo'] as String? ?? '',
        interlock: json['interlock'] as int?,
      );
}
