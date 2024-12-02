import 'package:hive/hive.dart';

part 'adapter_two.g.dart';

@HiveType(typeId: 1) // Usa un ID único
class AdapterTwo extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String descripcion;

  AdapterTwo({
    required this.id,
    required this.descripcion,
  });
}
