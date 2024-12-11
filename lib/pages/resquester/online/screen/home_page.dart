import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/resquester/online/widgets/custom_search_delegate.dart';
import 'package:forzado/pages/resquester/online/widgets/list_forzado.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';

class HomePageRemove extends StatefulWidget {
  const HomePageRemove({super.key});

  @override
  State<HomePageRemove> createState() => _HomePageRemoveState();
}

class _HomePageRemoveState extends State<HomePageRemove> {
  late List<ForzadoM> listData;

  @override
  Widget build(BuildContext context) {
    final ListServiceForzados _ListServiceForzados =
        ListServiceForzados(ApiClient());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: listData.isEmpty
                    ? CustomSearchDelegate(searchList: [])
                    : CustomSearchDelegate(searchList: listData),
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
          'Forzados - ejecutado alta ',
          style: TextStyle(fontFamily: 'noto', fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<ModelListForzados>(
          future: _ListServiceForzados.getDataByEndpoint(AppUrl.getListForzados)
              .then(
            (value) {
              List<ForzadoM> data = value.data
                  .where((element) =>
                      element.estado!.toLowerCase() == 'ejecutado-alta')
                  .toList();
              return ModelListForzados(
                success: value.success,
                message: value.message,
                data: data,
              );
            },
          ),
          builder: (BuildContext context,
              AsyncSnapshot<ModelListForzados> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Manejando errores si el Future falla
              String errorMessage = snapshot.error.toString();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Reintentar'),
                  ),
                ],
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              final List<ForzadoM> data = snapshot.data!.data;
              listData = data;
              return Expanded(
                child: ListForzado(data: data),
              );
            } else {
              // Caso en que no hay datos disponibles
              return const Center(
                child: Text(
                  "No hay forzados disponibles.",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}