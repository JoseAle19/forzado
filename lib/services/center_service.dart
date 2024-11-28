import 'package:forzado/core/urls.dart';
import 'package:forzado/models/center_model.dart';
import 'package:forzado/services/api_client.dart';

class CenterService {
  final ApiClient apiClient;

  CenterService(this.apiClient);

  Future<CenterModel> getTagCentros() async {
    final res = await apiClient.get(AppUrl.getTagCentro);
    if (res.statusCode == 200) {
      return CenterModelFromJson(res.body);
    } else {
      throw Exception(
          'Failed to fetch tag centros: ${res.statusCode} - ${res.body}');
    }
  }
}
