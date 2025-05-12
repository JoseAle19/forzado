import 'package:forzado/models/mestras/puestos_model.dart';
import 'package:hive/hive.dart';

part 'staff_position.g.dart'; // Asegúrate de tener este archivo generado

@HiveType(typeId: 11)
class PuestoValue extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? descripcion;

  @HiveField(2)
  int? estado;

  @HiveField(3)
  String? aprobadorNivel;

  @HiveField(4)
  List<int>? turnos;

  PuestoValue({
    this.id,
    this.descripcion,
    this.estado,
    this.aprobadorNivel,
    this.turnos,
  });

  factory PuestoValue.fromJson(Value v) => PuestoValue(
        id: v.id,
        descripcion: v.descripcion,
        estado: v.estado,
        aprobadorNivel: v.aprobadorNivel,
        turnos: v.turnos,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "estado": estado,
        "aprobadorNivel": aprobadorNivel,
        "turnos": turnos == null ? [] : List<dynamic>.from(turnos!.map((x) => x)),
      };
}
