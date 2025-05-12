import 'package:hive/hive.dart';

part 'adapter_turno.g.dart';

@HiveType(typeId: 8) // Cambia el `typeId` si ya usas otros
class AdapterTurno extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String descripcion;

  @HiveField(2)
  String horaInicio;

  @HiveField(3)
  String horaFin;

  AdapterTurno({
    required this.id,
    required this.descripcion,
    required this.horaInicio,
    required this.horaFin,
  });

  factory AdapterTurno.fromJson(Map<String, dynamic> json) {
    return AdapterTurno(
      id: json['id'],
      descripcion: json['descripcion'],
      horaInicio: json['horaInicio'],
      horaFin: json['horaFin'],
    );
  }
}
