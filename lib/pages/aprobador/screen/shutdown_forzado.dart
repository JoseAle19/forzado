import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/aprobador/widgets/custom_search_delegate.dart';
import 'package:forzado/pages/aprobador/widgets/list_forzado.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';

class ShutdownForzado extends StatefulWidget {
  const ShutdownForzado({super.key, required this.isAlta});
  final bool isAlta;
  @override
  State<ShutdownForzado> createState() => _ApproveforzadoState();
}

class _ApproveforzadoState extends State<ShutdownForzado> {
  late List<ForzadoM> listData;

  @override
  Widget build(BuildContext context) {
    final ListServiceForzados _ListServiceForzados =
        ListServiceForzados(ApiClient());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: CustomSearchExecuter(
                    searchList: listData
                        .where((element) =>
                            element.estado!.toLowerCase() == 'pendiente-baja' ||
                            element.estado!.toLowerCase() == 'Pendiente-alta')
                        .toList()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            final newRoute = MaterialPageRoute(builder: (_) => HomeApprove());
            Navigator.pushReplacement(context, newRoute);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Forzados - Pendiente alta/baja',
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
                      element.estado!.toLowerCase() == 'pendiente-baja' ||
                      element.estado!.toLowerCase() == 'pendiente-alta')
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

            final List<ForzadoM> data = snapshot.data!.data;
            listData = data;
            return Expanded(
              child: ListApproveForzado(
                data: data,
                isAlta: widget.isAlta,
              ),
            );
          },
        ),
      ),
    );
  }
}
