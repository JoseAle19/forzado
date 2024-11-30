import 'package:forzado/models/model_two.dart';
import 'package:forzado/services/api_client.dart';

class ServiceTwo {
  final ApiClient apiClient;

  ServiceTwo(this.apiClient);

Future<ModelTwo> getDataByEndpoint(String endPoint) async {
  try {
    final res = await apiClient.get(endPoint);

    if (res.statusCode == 200) {
      return modelTwoFromJson(res.body);
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
