import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/services/api_client.dart';
import 'package:http/http.dart' as http;

class ForzadosProvider with ChangeNotifier {
  bool _isFetch = false;
  String? _errorMessage;
  String? _errorMessageGetForados;
  List<ForzadoItem> _forzados = [];
  // Atributo para manejar el mensaje de error
  String? get errorMessage => _errorMessage;
  String? get errorMessageGetForzados => _errorMessageGetForados;

  int _pendingHighCount = 0;
  int _pendingLowCount = 0;
  int _approvedHighCount = 0;
  int _approvedLowCount = 0;
  int _executedHighCount = 0;
  int _finalizedCount = 0;
  int _rejectedHighCount = 0;
  int _rejectedLowCount = 0;

  int get pendingHighCount => _pendingHighCount;
  int get pendingLowCount => _pendingLowCount;
  int get approvedHighCount => _approvedHighCount;
  int get approvedLowCount => _approvedLowCount;
  int get executedHighCount => _executedHighCount;
  int get finalizedCount => _finalizedCount;
  int get rejectedHighCount => _rejectedHighCount;
  int get rejectedLowCount => _rejectedLowCount;
  bool get isFetch => _isFetch;
  List<ForzadoItem> get forzados => _forzados;
  ApiClient client = ApiClient();

  // Método principal para obtener datos y manejar errores
  Future<void> fetchCountForzados() async {
    _isFetch = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final res = await client.get(AppUrl.getListForzados).timeout(
            const Duration(seconds: 10),
          );

      ModelListForzados decodeData = ModelListForzadosFromJson(res.body);
      if (res.statusCode == 200) {
        _pendingHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'pendiente-alta')
            .length;
        _pendingLowCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'pendiente-baja')
            .length;
        _approvedHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'aprobado-alta')
            .length;
        _approvedLowCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'aprobado-baja')
            .length;
        _executedHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'ejecutado-alta')
            .length;
        _finalizedCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'finalizado')
            .length;
        _rejectedHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'rechazado-alta')
            .length;
        _rejectedLowCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'rechazado-baja')
            .length;
      } else {
        _errorMessage = decodeData.message.toString();
      }
    } on TimeoutException {
      _errorMessage =
          'La solicitud excedió el tiempo de espera. Intente nuevamente.';
    } on http.ClientException {
      _errorMessage = 'Error al conectar con el servidor. Verifique la URL.';
    } catch (e) {
      _errorMessage =
          'Error interno del servidor. Por favor, intente más tarde.';
    } finally {
      _isFetch = false;
      notifyListeners();
    }
  }

// obtener los forzados en general

  Future<List<ForzadoItem>> getForzados(String rol) async {
    try {
      final res = await client.get(AppUrl.getListForzados).timeout(const Duration(seconds: 10));
      ForzadosModel decodeData = forzadosModelFromJson(res.body);
      if (res.statusCode == 200) {
        if (rol == 'ejecutor-alta') {
          _forzados = _forzados
              .where((f) => f.estado?.toLowerCase() == 'aprobado-alta')
              .toList();
        } else if (rol == 'aprobado-baja') {
          _forzados = _forzados
              .where((f) => f.estado?.toLowerCase() == 'aprobado-alta')
              .toList();
        } else if (rol == 'solicitante') {
          _forzados = _forzados
              .where((f) => f.estado?.toLowerCase() == 'ejecutado-alta')
              .toList();
        } else if (rol == 'aprobador') {
          _forzados = _forzados
              .where((f) =>
                  f.estado?.toLowerCase() == 'pendiente-alta' ||
                  f.estado?.toLowerCase() == 'pendiente-baja')
              .toList();
        }
        notifyListeners();
      } else {
        _errorMessageGetForados = decodeData.message.toString();
      }
    } on TimeoutException {
      _errorMessageGetForados =
          'La solicitud excedió el tiempo de espera. Intente nuevamente.';
    } on http.ClientException {
      _errorMessageGetForados =
          'Error al conectar con el servidor. Verifique la URL.';
    } catch (e) {
      _errorMessageGetForados =
          'Error interno del servidor. Por favor, intente más tarde.';
    } finally {
      _isFetch = false;
      notifyListeners();
    }

    return _forzados;
  }
}
