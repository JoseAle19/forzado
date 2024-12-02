import 'package:hive/hive.dart';

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
}
