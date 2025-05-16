import 'package:hive/hive.dart';
import 'package:forzado/models/model_three.dart' as modelThree;

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
  factory AdapterThree.fromValue(modelThree.Value value) {
    return AdapterThree(
        id: value.id, nombre: '${value.nombre}');
  }


  
}


extension StringExtensions on String {
  String normalizeAccents() {
    const withAccents = 'áéíóúÁÉÍÓÚñÑ';
    const withoutAccents = 'aeiouAEIOUnN';
    
    String result = this;
    for (int i = 0; i < withAccents.length; i++) {
      result = result.replaceAll(withAccents[i], withoutAccents[i]);
    }
    return result;
  }
}