import 'package:forzado/models/model_tags_matriz.dart';
import 'package:hive/hive.dart';

part 'adapter_tag_forzado.g.dart';

@HiveType(typeId: 21) // Usa un ID único que no esté repetido
class AdapterTagForzado extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? prefijoId;

  @HiveField(2)
  final int? centroId;

  @HiveField(3)
  final String? sufijo;

  @HiveField(4)
  final String? probabilidadDescripcion;

  @HiveField(5)
  final String? impactoDescripcion;

  @HiveField(6)
  final int? probabilidadId;

  @HiveField(7)
  final int? impactoId;

  @HiveField(8)
  final String? descripcion;

  @HiveField(9)
  final String? tagConcat;

  @HiveField(10)
  final String? prefijoCodigo;

  @HiveField(11)
  final String? prefijoDescripcion;

  @HiveField(12)
  final String? centroCodigo;

  @HiveField(13)
  final String? centroDescripcion;

  @HiveField(14)
  final int? interlock;

  @HiveField(15)
  final int? riesgoAId;

  @HiveField(16)
  final String? riesgoADescripcion;

  @HiveField(17)
  final String? interlockDescripcion;

  AdapterTagForzado({
     this.id,
     this.prefijoId,
     this.centroId,
     this.sufijo,
     this.probabilidadDescripcion,
     this.impactoDescripcion,
     this.probabilidadId,
     this.impactoId,
     this.descripcion,
     this.tagConcat,
     this.prefijoCodigo,
     this.prefijoDescripcion,
     this.centroCodigo,
     this.centroDescripcion,
     this.interlock,
     this.riesgoAId,
     this.riesgoADescripcion,
     this.interlockDescripcion,
  });
factory AdapterTagForzado.fromModel(Tags tag) {
  return AdapterTagForzado(
    id: tag.id,
    prefijoId: tag.prefijoId,
    centroId: tag.centroId,
    sufijo: tag.sufijo,
    probabilidadId: tag.probabilidadId,
    impactoId: tag.impactoId,
    riesgoAId: tag.riesgoAId,
    interlock: tag.interlock,
  );
}

  factory AdapterTagForzado.fromJson(Map<String, dynamic> json) {
    return AdapterTagForzado(
      id: json['id'],
      prefijoId: json['prefijoId'],
      centroId: json['centroId'],
      sufijo: json['sufijo'],
      probabilidadDescripcion: json['probabilidadDescripcion'],
      impactoDescripcion: json['impactoDescripcion'],
      probabilidadId: json['probabilidadId'],
      impactoId: json['impactoId'],
      descripcion: json['descripcion'],
      tagConcat: json['tagConcat'],
      prefijoCodigo: json['prefijoCodigo'],
      prefijoDescripcion: json['prefijoDescripcion'],
      centroCodigo: json['centroCodigo'],
      centroDescripcion: json['centroDescripcion'],
      interlock: json['interlock'],
      riesgoAId: json['riesgoAId'],
      riesgoADescripcion: json['riesgoADescripcion'],
      interlockDescripcion: json['interlockDescripcion'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'prefijoId': prefijoId,
    'centroId': centroId,
    'sufijo': sufijo,
    'probabilidadDescripcion': probabilidadDescripcion,
    'impactoDescripcion': impactoDescripcion,
    'probabilidadId': probabilidadId,
    'impactoId': impactoId,
    'descripcion': descripcion,
    'tagConcat': tagConcat,
    'prefijoCodigo': prefijoCodigo,
    'prefijoDescripcion': prefijoDescripcion,
    'centroCodigo': centroCodigo,
    'centroDescripcion': centroDescripcion,
    'interlock': interlock,
    'riesgoAId': riesgoAId,
    'riesgoADescripcion': riesgoADescripcion,
    'interlockDescripcion': interlockDescripcion,
  };


   static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
