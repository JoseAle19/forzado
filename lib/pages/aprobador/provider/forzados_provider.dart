import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/pages/ejecutor/models/aprobador.dart';
import 'package:forzado/services/api_client.dart';

class ForzadosProviderApprove with ChangeNotifier {
  // Lista para manejar datos
  List<ForzadoApprove> _listForzados = [];
  List<ForzadoApprove> get listForzados => _listForzados;

  String _messageError = '';
  String get messageError => _messageError;

  bool _loading = false;
  bool get loading => _loading;

  // Cliente de API
  final ApiClient client = ApiClient();

  Future<void> initLoadSolicitudes() async {
    _loading = true;
    notifyListeners();

    try {
      final res = await client.get(AppUrl.getListForzados);

      if (res.statusCode == 200) {
        final decodeData = modelForzadosApproveFromJson(res.body);
        _listForzados = decodeData.data;
      } else {
        _messageError = 'Ocurrió un error, intenta más tarde.';
      }
    } catch (e) {
      _messageError = 'Ocurrió un error al procesar la solicitud.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void deleteForzadoById(String id) {
    // Filtra la lista para eliminar el elemento con el ID correspondiente
    _listForzados.removeWhere((f) => f.id.toString() == id);
    notifyListeners();
  }
}
