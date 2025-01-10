import 'package:hive/hive.dart';
import 'package:forzado/models/model_one.dart' as modelone;

part 'adapter_one.g.dart';

@HiveType(typeId: 0) // Usa un ID único
class AdapterOne extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String codigo;

  @HiveField(2)
  final String descripcion;

  AdapterOne({
    required this.id,
    required this.codigo,
    required this.descripcion,
  });
  factory AdapterOne.fromValue(modelone.Value value) {
    return AdapterOne(
      id: value.id,
      codigo: value.codigo,
      descripcion: value.descripcion,
    );
  }
}
