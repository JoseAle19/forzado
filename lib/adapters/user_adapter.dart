import 'package:hive/hive.dart';

part 'user_adapter.g.dart';

@HiveType(typeId: 6) // Cambia el typeId según sea necesario
class AdapterUser extends HiveObject {
  @HiveField(0)
  final String? apePaterno;

  @HiveField(1)
  final String? apeMaterno;

  @HiveField(2)
  final int? areaId;

  @HiveField(3)
  final String? areaDescripcion;

  @HiveField(4)
  final int? rolId;

  @HiveField(5)
  final String? rolDescripcion;

  @HiveField(6)
  final Map<String, String>? roles;

  @HiveField(7)
  final int? estado;

  @HiveField(8)
  final String? dni;

  @HiveField(9)
  final int? puestoId;

  @HiveField(10)
  final String? puestoDescripcion;

  @HiveField(11)
  final String? correo;

  @HiveField(12)
  final String? usuario;
  @HiveField(14)
  final int? id;
  @HiveField(15)
  final String? nombre;

  AdapterUser({
    this.apePaterno,
    this.apeMaterno,
    this.areaId,
    this.areaDescripcion,
    this.rolId,
    this.rolDescripcion,
    this.roles,
    this.estado,
    this.dni,
    this.puestoId,
    this.puestoDescripcion,
    this.correo,
    this.usuario,
    this.id,
    this.nombre,
  });
}
