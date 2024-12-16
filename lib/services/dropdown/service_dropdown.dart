import 'dart:convert';
import 'package:forzado/core/abstract/drop_menu_item.dart';
import 'package:forzado/services/api_client.dart';

class ApiServiceDropdown {
  Future<List<T>> fetchData<T extends DropDownItem>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final res = await ApiClient().get(endpoint);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data['success'] == true) {
        return (data['values'] as List).map((item) => fromJson(item)).toList();
      } else {
        throw Exception('Error: Respuesta no exitosa');
      }
    } else {
      throw Exception('Error al cargar datos: ${res.statusCode}');
    }
  }
}
