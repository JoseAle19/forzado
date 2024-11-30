import 'package:forzado/models/model_one.dart';
import 'package:forzado/services/api_client.dart';

class ServiceOne {
  final ApiClient apiClient;

  ServiceOne(this.apiClient);

Future<ModelOne> getDataByEndpoint(String endPoint) async {
  try {
    final res = await apiClient.get(endPoint);

    if (res.statusCode == 200) {
      return modelOneFromJson(res.body);
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
