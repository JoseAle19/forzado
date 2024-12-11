import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/services/api_client.dart';

class ListServiceForzados {
  final ApiClient apiClient;

  ListServiceForzados(this.apiClient);
  Future<ModelListForzados> getDataByEndpoint(String endPoint) async {
    ApiClient client = ApiClient();
    try {
      final response = await client.get(endPoint).timeout(
          const Duration(seconds: 5)); // Tiempo de espera de 5 segundos

      if (response.statusCode == 200) {
        return ModelListForzadosFromJson(response.body);
      } else {
        throw Exception(
            'Error en la solicitud: Código de estado ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Error al conectar con el servidor. Verifique la URL.');
    } on TimeoutException {
      throw Exception(
          'La solicitud excedió el tiempo de espera. Intente nuevamente.');
    } catch (e) {
      throw Exception(
          'Error interno del servidor. Por favor, intente más tarde');
    } finally {
      client.close();
    }
  }
}
