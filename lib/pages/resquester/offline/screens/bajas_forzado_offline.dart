import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/adapters/forzado_baja.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/form/forzado/request_forced_forzado.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:hive_flutter/adapters.dart';

class BajasForzadoOffline extends StatefulWidget {
  const BajasForzadoOffline({super.key});

  @override
  State<BajasForzadoOffline> createState() => _BajasForzadoOfflineState();
}

class _BajasForzadoOfflineState extends State<BajasForzadoOffline> {
  bool isfetch = false;
  Future<List<ForzadoBaja>> getRequestBajas() async {
    final box = Hive.box<ForzadoBaja>('forzadoBajaBox');
    return box.values.toList();
  }

  void showDetailsModal(BuildContext context, ForzadoBaja item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  'Detalles del Forzado Baja',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 16),
                buildDetailRow('ID:', item.id.toString()),
                buildDetailRow('Descripción:', item.descripcion.toString()),
                buildDetailRow('ID Aplicante:', item.idApplicant.toString()),
                buildDetailRow(
                    'Aplicante:', item.descripcionApplicant.toString()),
                buildDetailRow('ID aprobador:', item.idApprover.toString()),
                buildDetailRow(
                    'Aprobador:', item.descripcionApprover.toString()),
                buildDetailRow('ID ejecutor:', item.idExecutor.toString()),
                buildDetailRow(
                    'Ejecutor:', item.descripcionExecutor.toString()),
                buildDetailRow('ID Forzado:', item.id_forzado.toString()),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void removeForzadoBajaById() async {
    final box = Hive.box<ForzadoBaja>('forzadoBajaBox');
  setState(() {
    isfetch = true;
  });
    for (var i = 0; i < box.values.toList().length; i++) {
      ForzadoBaja forzado = box.values.toList()[i];
    await  syncForzadosBaja(forzado);
    box.delete(forzado.id_forzado);
    }
  setState(() {
    isfetch = false;
  });

  }

  Future<void> syncForzadosBaja(ForzadoBaja forzado) async {
    FormRemoveForzadoQueryParameters data = FormRemoveForzadoQueryParameters(
      solicitanteRetiro: forzado.idApplicant.toString(),
      aprobadorRetiro: forzado.idApprover.toString(),
      ejecutorRetiro: forzado.idExecutor.toString(),
      observaciones: forzado.descripcion.toString(),
      id: forzado.id_forzado.toString(),
    );
    ApiClient client = ApiClient();
    final res =
        await client.post(AppUrl.postForcedForzado, json.encode(data.toJson()));
    if (res.statusCode == 200) {
      CustomModal modal = CustomModal();
      Future.delayed(const Duration(seconds: 1), () {
        modal.showModal(context, 'Forzado sincronizado', Colors.green, true);
      });
    } else {
      CustomModal modal = CustomModal();
      Future.delayed(const Duration(seconds: 1), () {
        modal.showModal(
            context, 'Error al sincronizar forzado', Colors.red, false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<ForzadoBaja>('forzadoBajaBox');

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forzados sync',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  removeForzadoBajaById();
                },
                icon: const Icon(Icons.sync))
          ],
        ),
        body: Center(
          child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (BuildContext context, dynamic value, Widget? snapshot) {
              List<ForzadoBaja> forzados = box.values.toList();

              if (forzados.isEmpty) {
                return const Center(
                  child: Text('Sin forzados agregados'),
                );
              }
              return ListView.separated(
                itemCount: forzados.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox.shrink();
                },
                itemBuilder: (BuildContext context, int index) {
                  ForzadoBaja forzado = forzados[index];
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
                              '${forzado.id_forzado}',
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
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              showDetailsModal(context, forzado);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
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
          ),
        ));
  }
}
