import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/services/api_client.dart';

class ListServiceForzados {
  final ApiClient apiClient;

  ListServiceForzados(this.apiClient);

  Future<ModelListForzados> getDataByEndpoint(String endPoint) async {
    try {
      final res = await apiClient.get(endPoint);
      if (res.statusCode == 200) {
        return ModelListForzadosFromJson(res.body);
      } else {
        throw Exception(
            'Failed to fetch tag centros: ${res.statusCode} - ${res.body}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
