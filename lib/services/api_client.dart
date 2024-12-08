import 'dart:convert';

import 'package:forzado/core/urls.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/models/model_user_detail.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('${AppUrl.url}$endpoint');
    return http.get(url, headers: _headers());
  }

  Future<http.Response> post(String endpoint, dynamic body) async {
    ApiResponseDetailUser? user = await PreferencesHelper().getUser();

    final url = Uri.parse('${AppUrl.url}$endpoint');
    Map<String, dynamic> bodyMap = jsonDecode(body);
    bodyMap['usuario'] = user?.id ?? 0;
    String updatedBody = jsonEncode(bodyMap);
    return http.post(url, body: updatedBody, headers: _headers());
  }

  Future<http.Response> put(String endpoint, dynamic body) async {
    ApiResponseDetailUser? user = await PreferencesHelper().getUser();
    Map<String, dynamic> bodyMap = jsonDecode(body);
    bodyMap['usuario'] = user?.id ?? 0;
    String updatedBody = jsonEncode(bodyMap);
    final url = Uri.parse('${AppUrl.url}$endpoint');
    return http.put(url, body: updatedBody, headers: _headers());
  }

  Map<String, String> _headers() {
    return {'Content-Type': 'application/json'};
  }
}
