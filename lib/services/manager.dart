import 'dart:convert';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/core/urls.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class DataManager {
  Future<void> fetchAndFillBox<T>(String boxName, String endpoint) async {
    try {
      final response = await http.get(Uri.parse('${AppUrl.url}$endpoint'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true && data['values'] != null) {
          final box = Hive.box<T>(boxName);

          // Limpia la caja antes de llenarla
          await box.clear();

          // Mapea y almacena los datos
          for (var item in data['values']) {
            if (T == AdapterOne) {
              box.add(AdapterOne(
                id: item['id'] ?? 0,
                codigo: item['codigo'] ?? 'Sin código',
                descripcion: item['descripcion'] ?? 'Sin descripción',
              ) as T);
            } else if (T == AdapterTwo) {
              box.add(AdapterTwo(
                id: item['id'] ?? 0,
                descripcion: item['descripcion'] ?? 'Sin descripción',
              ) as T);
            } else if (T == AdapterThree) {
              box.add(AdapterThree(
                id: item['id'] ?? 0,
                nombre: item['nombre'] ?? 'Sin nombre',
              ) as T);
            }
          }
        } else {
          print('Endpoint $endpoint devolvió datos vacíos o no exitosos.');
        }
      } else {
        print('Error al consumir $endpoint: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al procesar $endpoint: $e');
    }
  }
}
