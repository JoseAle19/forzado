import 'package:hive/hive.dart';

part 'adapter_tags.g.dart'; // Necesario para generar el adapter

@HiveType(typeId: 7) // `typeId` debe ser único en toda tu aplicación
class AdapterTags   extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? prefijoId;

  @HiveField(2)
  final int? centroId;

  @HiveField(3)
  final String? sufijo;

  @HiveField(4)
  final int? probabilidadId;

  @HiveField(5)
  final int? impactoId;

  AdapterTags({
     this.id,
     this.prefijoId,
     this.centroId,
     this.sufijo,
     this.probabilidadId,
     this.impactoId,
  });

  // Método factory para mapear desde JSON
  factory AdapterTags.fromJson(Map<String, dynamic> json) {
    return AdapterTags(
      id: json['id'],
      prefijoId: json['prefijoId'],
      centroId: json['centroId'],
      sufijo: json['sufijo'],
      probabilidadId: json['probabilidadId'],
      impactoId: json['impactoId'],
    );
  }

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prefijoId': prefijoId,
      'centroId': centroId,
      'sufijo': sufijo,
      'probabilidadId': probabilidadId,
      'impactoId': impactoId,
    };
  }
}
