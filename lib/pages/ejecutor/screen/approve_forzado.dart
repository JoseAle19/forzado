import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/ejecutor/widgets/custom_search_delegate.dart';
import 'package:forzado/pages/ejecutor/widgets/list_forzado.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';

class Approveforzado extends StatefulWidget {
  const Approveforzado({super.key});

  @override
  State<Approveforzado> createState() => _ApproveforzadoState();
}

class _ApproveforzadoState extends State<Approveforzado> {
  late List<Datum> listData;

  @override
  Widget build(BuildContext context) {
    final ListServiceRemove _listServiceRemove = ListServiceRemove(ApiClient());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: CustomSearchExecuter(
                    searchList: listData
                        .where((element) => element.estado == 'pendiente-alta')
                        .toList()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'IPERC',
          style: TextStyle(fontFamily: 'noto'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<ModelListRemove>(
          future:
              _listServiceRemove.getDataByEndpoint(AppUrl.getListForzados).then(
            (value) {
              List<Datum> data = value.data
                  .where((element) => element.estado == 'pendiente-alta')
                  .toList();
              return ModelListRemove(
                success: value.success,
                message: value.message,
                data: data,
              );
            },
          ),
          builder:
              (BuildContext context, AsyncSnapshot<ModelListRemove> snapshot) {
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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}