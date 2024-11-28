import 'package:forzado/core/urls.dart';
import 'package:http/http.dart' as http;

class ApiClient {

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('${AppUrl.url}$endpoint');
    return http.get(url, headers: _headers());
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${AppUrl.url}$endpoint');
    return http.post(url, body: body, headers: _headers());
  }

  Map<String, String> _headers() {
    return {'Content-Type': 'application/json'};
  }
}
