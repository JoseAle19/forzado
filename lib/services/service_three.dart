import 'package:forzado/models/model_three.dart';
import 'package:forzado/services/api_client.dart';

class ServiceThree {
  final ApiClient apiClient;

  ServiceThree(this.apiClient);

Future<ModelThree> getDataByEndpoint(String endPoint) async {
  try {
    final res = await apiClient.get(endPoint);

    if (res.statusCode == 200) {
      return modelThreeFromJson(res.body);
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
