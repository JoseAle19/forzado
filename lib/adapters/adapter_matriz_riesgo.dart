import 'package:hive/hive.dart';

part 'adapter_matriz_riesgo.g.dart';

@HiveType(typeId: 20) // Usa un ID único diferente a los demás
class AdapterMatrizRiesgo extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int impactoId;

  @HiveField(2)
  final int riesgoId;

  @HiveField(3)
  final int probabilidadId;

  @HiveField(4)
  final int nivel;

  @HiveField(5)
  final int estado;

  @HiveField(6)
  final String impactoDescripcion;

  @HiveField(7)
  final String probabilidadDescripcion;

  @HiveField(8)
  final String riesgoDescripcion;

  AdapterMatrizRiesgo({
    required this.id,
    required this.impactoId,
    required this.riesgoId,
    required this.probabilidadId,
    required this.nivel,
    required this.estado,
    required this.impactoDescripcion,
    required this.probabilidadDescripcion,
    required this.riesgoDescripcion,
  });

  factory AdapterMatrizRiesgo.fromJson(Map<String, dynamic> json) {
    return AdapterMatrizRiesgo(
      id: json['id'],
      impactoId: json['impacto_id'],
      riesgoId: json['riesgo_id'],
      probabilidadId: json['probabilidad_id'],
      nivel: json['nivel'],
      estado: json['estado'],
      impactoDescripcion: json['impacto_descripcion'] ?? '',
      probabilidadDescripcion: json['probabilidad_descripcion'] ?? '',
      riesgoDescripcion: json['riesgo_descripcion'] ?? '',
    );
  }
}
