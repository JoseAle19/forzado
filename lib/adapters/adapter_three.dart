import 'package:hive/hive.dart';

part 'adapter_three.g.dart';

@HiveType(typeId: 2) // Usa un ID único
class AdapterThree extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String nombre;

  AdapterThree({
    required this.id,
    required this.nombre,
  });
}
