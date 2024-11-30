import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/services/api_client.dart';

class ListServiceRemove {
  final ApiClient apiClient;

  ListServiceRemove(this.apiClient);

  Future<ModelListRemove> getDataByEndpoint(String endPoint) async {
    try {
      final res = await apiClient.get(endPoint);

      if (res.statusCode == 200) {
        return modelListRemoveFromJson(res.body);
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
