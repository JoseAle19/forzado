// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/adapters/forzado.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/models/form/forzado/model_forzado.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ForzadosDataTable extends StatefulWidget {
  const ForzadosDataTable();

  @override
  State<ForzadosDataTable> createState() => _ForzadosDataTableState();
}

class _ForzadosDataTableState extends State<ForzadosDataTable> {
  List<Forzado> listForzado = [];
  bool isLoading = false;
  bool isSync = false;

  void verInformacion(BuildContext context, Forzado forzado) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.info, color: Colors.blueAccent, size: 28),
            SizedBox(width: 8),
            Text(
              'Detalles del Forzado',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detalleItem(
                  'Usuario',
                  '${forzado.usuarioDescription} | ${forzado.idUsuario.toString()}' ??
                      'No definido'),
              detalleItem(
                  'Prefijo', forzado.tagPrefijoDescripcion ?? 'No definido'),
              detalleItem(
                  'Centro', forzado.tagCentroDescripcion ?? 'No definido'),
              detalleItem('Descripción', forzado.description),
              detalleItem('Disciplina',
                  forzado.tagDisciplinaDescripcion ?? 'No definido'),
              detalleItem(
                  'Interlock Seguridad', forzado.interlock == 0 ? 'No' : 'SI'),
              detalleItem('Responsable',
                  forzado.responsibilityDescripcion ?? 'No definido'),
              detalleItem(
                  'Riesgo A', forzado.riskADescripcion ?? 'No definido'),
              detalleItem('Probabilidad',
                  forzado.probabilityDescripcion ?? 'No definido'),
              detalleItem(
                  'Impacto', forzado.impactDescripcion ?? 'No definido'),
              detalleItem('Riesgo', forzado.riskDescripcion ?? 'No definido'),
              detalleItem(
                'Solicitante',
                utf8.decode(
                  latin1.encode(forzado.applicantDescripcion ?? 'No definido'),
                  allowMalformed: true,
                ),
              ),
              detalleItem(
                'Aprobador',
                utf8.decode(
                  latin1.encode(forzado.approverDescripcion ?? 'No definido'),
                  allowMalformed: true,
                ),
              ),
              detalleItem(
                'Fecha Planificada',
                utf8.decode(
                  latin1.encode(forzado.dateRequest ?? 'No definido'),
                  allowMalformed: true,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget detalleItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? 'No disponible',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sincronizarInformacion(BuildContext context) async {
    final forzadosProvider =
        Provider.of<ForzadosProvider>(context, listen: false);
    CustomModal modal = CustomModal();

    Box<Forzado> box = Hive.box<Forzado>('Forzado');

    setState(() {
      isSync = true;
    });

    try {
      for (var forzado in box.values) {
        final data = InsertQueryParameters(
          usuario: forzado.idUsuario?.toString() ?? 'No definido',
          tagPrefijo: forzado.tagPrefijoId?.toString() ?? 'No definido',
          tagCentro: forzado.tagCentroId?.toString() ?? 'No definido',
          tagSubfijo: forzado.subfijo,
          descripcion: forzado.description,
          disciplina: forzado.tagDisciplinaId?.toString() ?? 'No definido',
          turno: forzado.shiftId?.toString() ?? 'No definido',
          interlockSeguridad: forzado.interlock == 0 ? 'NO' : 'SI',
          responsable: forzado.responsibilityId?.toString() ?? 'No definido',
          riesgoA: forzado.riskAId?.toString() ?? 'No definido',
          riesgo: forzado.riskId?.toString() ?? 'No definido',
          probabilidad: forzado.probabilityId?.toString() ?? 'No definido',
          impacto: forzado.impactId?.toString() ?? 'No definido',
          solicitante: forzado.applicantId?.toString() ?? 'No definido',
          aprobador: forzado.approverId?.toString() ?? 'No definido',
          autorizacion: 'Default value',
          tipoForzado: 'Default value',
          projectName: 'Default Value',
          circuito: forzado.circuitosId?.toString() ?? 'No definido',
          grupoA: forzado.grupoId?.toString() ?? 'No definido',
          fechaFinPlanificada: forzado.dateRequest?.toString() ?? 'No definido',
          ejecutor: 'Default Value',
        );

        try {
          ApiClient client = ApiClient();
          final res = await client.post(
              AppUrl.postAddForzado, json.encode(data.toMap()));

          if (res.statusCode == 200) {
            await box.delete(forzado.key);
            setState(() {
              listForzado.remove(forzado);
            });
            forzadosProvider.fetchCountForzados();
            modal.showModal(
                context, 'Sincronización completada', Colors.green, true);
          } else {
            modal.showModal(
                context, 'Error al sincronizar un elemento', Colors.red, false);
          }
        } catch (e) {
          modal.showModal(
              context, 'Error al sincronizar: $e', Colors.red, false);
        }
      }
    } catch (e) {
      print('Error en la sincronización: $e');
    } finally {
      setState(() {
        isSync = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadForzados();
  }

  void loadForzados() async {
    Box<Forzado> box = Hive.box<Forzado>('Forzado');
    setState(() {
      isLoading = true;
    });
    try {
      listForzado = box.values.toList();
    } catch (e) {
      print('Error al cargar los datos: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteForzadoBox() async {
    try {
      var box = await Hive.openBox<Forzado>(HiveBoxes.forzado);
      await box.clear();
      setState(() {
        listForzado.clear();
      });
    } catch (e) {
      print('Error al eliminar forzados: $e');
    } finally {
      try {
        if (Hive.isBoxOpen(HiveBoxes.forzado)) {
          await Hive.box(HiveBoxes.forzado).close();
        }
      } catch (e) {
        print('Error al cerrar la caja: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => sincronizarInformacion(context),
            icon: const Icon(Icons.sync),
          )
        ],
        title: const Text(
          'Solicitudes Pendientes de Sincronizar',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : listForzado.isEmpty
                  ? Center(
                      child: Column(
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
                      ),
                    )
                  : ListView.builder(
                      itemCount: listForzado.length,
                      itemBuilder: (context, index) {
                        final forzado = listForzado[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(
                              'Usuario: ${forzado.usuarioDescription ?? 'No definido'}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Centro: ${forzado.tagCentroDescripcion ?? 'No definido'}'),
                            trailing: Wrap(
                              spacing: 8,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.info_outline,
                                      color: Colors.blue),
                                  tooltip: 'Ver información',
                                  onPressed: () =>
                                      verInformacion(context, forzado),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          if (isSync)
            Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(123, 0, 0, 0),
               
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.lightBlueAccent),
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
        ],
      ),
    );
  }
}
