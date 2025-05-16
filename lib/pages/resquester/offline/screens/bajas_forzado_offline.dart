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
  bool isfetchingData = false;
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  'Detalles del Forzado retiro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 16),
                buildDetailRow('ID:', item.id.toString()),
                buildDetailRow('Descripción:', item.descripcion.toString()),
                buildDetailRow(
                    'Aplicante:', item.descripcionApplicant.toString()),
                buildDetailRow(
                    'Aprobador:', item.descripcionApprover.toString()),
                buildDetailRow('Grupo:', item.descripcionExecutor.toString()),
                buildDetailRow('ID Forzado:', item.id_forzado.toString()),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
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
      await syncForzadosBaja(forzado);
      box.delete(forzado.id_forzado);
    }
    setState(() {
      isfetch = false;
    });
  }
// Flag para saber si esta cargando

  Future<void> syncForzadosBaja(ForzadoBaja forzado) async {
    FormRemoveForzadoQueryParameters data = FormRemoveForzadoQueryParameters(
      solicitanteRetiro: forzado.idApplicant.toString(),
      aprobadorRetiro: forzado.idApprover.toString(),
      ejecutorRetiro: forzado.idExecutor.toString(),
      observaciones: forzado.descripcion.toString(),
      id: forzado.id_forzado.toString(),
      tipoGrupoB: forzado.idExecutor.toString(),
    );
    ApiClient client = ApiClient();
    setState(() {
      isfetchingData = true;
    });
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
    setState(() {
      isfetchingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<ForzadoBaja>('forzadoBajaBox');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solicitudes Retiro Pendientes por Sincronizar',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (!isfetchingData) {
                removeForzadoBajaById();
              }
            },
            icon: isfetchingData
                ? const CircularProgressIndicator(color: Colors.black)
                : const Icon(Icons.sync),
          ),
          IconButton(
            onPressed: () {
              if (!isfetchingData) {
                final box = Hive.box<ForzadoBaja>('forzadoBajaBox');
                print(box.values.toList());
              }
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: isfetchingData
          ? Center(
  child: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.65),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.7),
          Colors.black.withOpacity(0.8),
        ],
        stops: const [0.3, 0.7],
      ),
    ),
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicator with pulse animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.95, end: 1.05),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                strokeWidth: 3,
                backgroundColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 20),
            // Text with subtle animation
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 10 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  const Text(
                    'Sincronizando información',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Por favor espere...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Optional progress text (uncomment if you have progress)
            /*
            const SizedBox(height: 16),
            Text(
              '${(progress * 100).toStringAsFixed(1)}% completado',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            */
          ],
        ),
      ),
    ),
  ),
)
          : Center(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder:
                    (BuildContext context, dynamic value, Widget? snapshot) {
                  List<ForzadoBaja> forzados = box.values.toList();

                  if (forzados.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay solicitudes pendientes de sincronizar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
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
                                  if (!isfetchingData) {
                                    showDetailsModal(context, forzado);
                                  }
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
            ),
    );
  }
}
