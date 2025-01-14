import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/pages/ejecutor/models/aprobador.dart';
import 'package:forzado/services/api_client.dart';

class ForzadosProviderApprove with ChangeNotifier {
// Una lista, para que se pueda manipular los datos
  List<ForzadoApprove> _listForzados = [];
  List<ForzadoApprove> get listForzados => _listForzados;
  String _messageError = '';
  String get messageError => _messageError;
  bool _loading = false;
  bool get loading => _loading;
// Gettin data
  ApiClient client = ApiClient();
  Future<void> initLoadSolicitudes() async {
    final res = await client.get(AppUrl.getListForzados);
    // if (listForzados.isNotEmpty) return;
    print('pasa aca');
    try {
      _loading = true;
      notifyListeners();
      if (res.statusCode == 200) {
        final decodeData = modelForzadosApproveFromJson(res.body);
        _listForzados = decodeData.data;
      } else {
        _messageError = 'Ocurrio un error, intenta mas tarde';
      }
    } catch (e) {
      
      _messageError = 'Ocurrio un error, intenta mas tarde';
    } finally {
      _messageError = '';
      _loading = false;
      print('sasas');
      notifyListeners();
    }
  }


void deleteForzadoById(String id) {
  // Filtrar la lista para eliminar el elemento con el ID correspondiente
  _listForzados.removeWhere((f) => f.id.toString() == id);
  notifyListeners();
}

}
