import 'package:hive/hive.dart';

part 'adapter_shifts.g.dart'; // Necesario para generar el adapter

@HiveType(typeId: 10)
class ShiftValue extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? descripcion;

  @HiveField(2)
  String? horaInicio;

  @HiveField(3)
  String? horaFin;

  ShiftValue({
    this.id,
    this.descripcion,
    this.horaInicio,
    this.horaFin,
  });

  factory ShiftValue.fromJson(Map<String, dynamic> json) => ShiftValue(
        id: json["id"],
        descripcion: json["descripcion"],
        horaInicio: json["horaInicio"],
        horaFin: json["horaFin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "horaInicio": horaInicio,
        "horaFin": horaFin,
      };
}
