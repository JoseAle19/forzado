import 'package:hive/hive.dart';

part 'forzado_baja.g.dart';

@HiveType(typeId: 5)
class ForzadoBaja extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? descripcion;

  @HiveField(2)
  int? idApplicant;

  @HiveField(3)
  String? descripcionApplicant;

  @HiveField(4)
  int? id_forzado;

  @HiveField(5)
  int? idApprover;

  @HiveField(6)
  String? descripcionApprover;

  @HiveField(7)
  int? idExecutor;

  @HiveField(8)
  String? descripcionExecutor;

  ForzadoBaja(
      {required this.id,
      required this.descripcion,
      required this.idApplicant,
      required this.descripcionApplicant,
      required this.idApprover,
      required this.descripcionApprover,
      required this.idExecutor,
      required this.descripcionExecutor,
      required this.id_forzado});
}
