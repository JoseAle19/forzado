import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/ejecutor/widgets/list_forzado.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';

class ListForzado extends StatelessWidget {
  const ListForzado({super.key, required this.stateForzado});
  final String stateForzado;
  @override
  Widget build(BuildContext context) {
    final ListServiceRemove _listServiceRemove = ListServiceRemove(ApiClient());

    late List<Datum> listData;

    return FutureBuilder<ModelListRemove>(
      future: _listServiceRemove.getDataByEndpoint(AppUrl.getListForzados).then(
        (value) {
          List<Datum> data = value.data
              .where((element) => element.estado == stateForzado)
              .toList();
          return ModelListRemove(
            success: value.success,
            message: value.message,
            data: data,
          );
        },
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelListRemove> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(
              child: Text('Ocurrio un error, contacta a soporte'));
        }
        if (snapshot.data!.data.isEmpty) {
          return const Center(child: Text('No hay datos'));
        }

        final List<Datum> data = snapshot.data!.data;
        listData = data;
        return Expanded(
          child: ListApproveForzado(data: data),
        );
      },
    );
  }
}
