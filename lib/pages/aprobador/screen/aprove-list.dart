import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/aprobador/screen/detail_approve_forzado.dart';
import 'package:forzado/pages/aprobador/widgets/custom_search_delegate.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';

class Approveforzado extends StatefulWidget {
  const Approveforzado({super.key, required this.isAlta});
  final bool isAlta;
  @override
  State<Approveforzado> createState() => _ApproveforzadoState();
}

class _ApproveforzadoState extends State<Approveforzado> {
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
                            element.estado!.toLowerCase() == 'pendiente-alta' ||
                            element.estado!.toLowerCase() == 'pendiente-baja')
                        .toList()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            final newRoute =
                MaterialPageRoute(builder: (_) => const HomeApprove());
            Navigator.pushReplacement(context, newRoute);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Forzados - Pendiente alta/baja',
          style: TextStyle(fontFamily: 'noto', fontSize: 15),
        ),
      ),
      body: FutureBuilder<ModelListForzados>(
        future:
            _ListServiceForzados.getDataByEndpoint(AppUrl.getListForzados).then(
          (value) {
            List<ForzadoM> data = value.data
                .where((element) =>
                    element.estado!.toLowerCase() == 'pendiente-alta' ||
                    element.estado!.toLowerCase() == 'pendiente-baja')
                .toList();
            return ModelListForzados(
              success: value.success,
              message: value.message,
              data: data,
            );
          },
        ),
        builder:
            (BuildContext context, AsyncSnapshot<ModelListForzados> snapshot) {
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

          return FutureBuilder<ModelListForzados>(
            future:
                _ListServiceForzados.getDataByEndpoint(AppUrl.getListForzados)
                    .then(
              (value) {
                List<ForzadoM> data = value.data
                    .where((element) =>
                        element.estado!.toLowerCase() == 'pendiente-alta' ||
                        element.estado!.toLowerCase() == 'pendiente-baja')
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

              if (snapshot.data!.data.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.hourglass_empty,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tienes forzados disponibles',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Los forzados con estado aprobado alta \nestán en proceso. Por favor, espera.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox.shrink();
                },
                itemBuilder: (BuildContext context, int index) {
                  ForzadoM forzado = snapshot.data!.data[index];
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue.shade100,
                            child: Text(
                              '${forzado.id}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: ${forzado.id}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Descripción
                                Text(
                                  forzado.estado ?? "Sin estado",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailApproveForzado(
                                      detailForzado: forzado,
                                      isAlta: widget.isAlta),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                              size: 20,
                            ),
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
