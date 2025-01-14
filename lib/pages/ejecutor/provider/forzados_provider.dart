import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/pages/ejecutor/models/aprobador.dart';
import 'package:forzado/services/api_client.dart';

class ForzadosProviderAjecutor with ChangeNotifier {
// Una lista, para que se pueda manipular los datos
  List<ForzadoApprove> listForzados = [];
  String messageError = '';
  bool loading = false;
// Gettin data
  ApiClient client = ApiClient();
  Future<void> initLoadSolicitudes() async {
    final res = await client.get(AppUrl.getListForzados);
    try {
      if (res.statusCode == 200) {
        final decodeData = modelForzadosApproveFromJson(res.body);
        listForzados = decodeData.data;
      } else {
              messageError = 'Ocurrio un error, intenta mas tarde';

      }
    } catch (e) {
      messageError = 'Ocurrio un error, intenta mas tarde';
    }
    finally{
      loading = true;
    }
    notifyListeners();
  }
}
