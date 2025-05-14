import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:forzado/pages/resquester/offline/screens/form_baja_forzado.dart';
import 'package:hive_flutter/adapters.dart';

class ListForzadosEjecutadoAlta extends StatelessWidget {
  void navigateDetailForzado(BuildContext context, Forzados item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormBajaForzado(
          detailForzado: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Forzados>('Forzados');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Retiro de forzado'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (BuildContext context, dynamic value, Widget? child) {
          if (!box.isOpen) {
            return const Center(child: Text('Error: Caja no disponible'));
          }

          final forzados = box.values.toList()
            ..sort((a, b) {
              // Manejo de fechas nulas (asigna fecha muy antigua si es null)
              final fechaA = a.fecha ?? DateTime(1970);
              final fechaB = b.fecha ?? DateTime(1970);
              return fechaB.compareTo(
                  fechaA); // Orden descendente (más reciente primero)
            });
          if (forzados.isEmpty) {
            return const Center(
              child: Text('Sin informacion'),
            );
          }
          return ListView.separated(
            itemCount: forzados.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox.shrink();
            },
            itemBuilder: (BuildContext context, int index) {
              Forzados forzado = forzados[index];
              final state = forzado.estado.toLowerCase() == 'ejecutado-forzado'
                  ? 'Ejecutado-forzado'
                  : 'sin estado';
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                              state.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          navigateDetailForzado(context, forzado);
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
      ),
    );
  }
}
