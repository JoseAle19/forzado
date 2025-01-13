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
              detalleItem('usuario', forzado.usuario.toString()),
              detalleItem(
                  'Nombre del proyecto', forzado.projectValue?.descripcion),
              detalleItem('Centro', forzado.tagCentroValue?.descripcion),
              detalleItem('Descripción', forzado.descripcion),
              detalleItem('Disciplina', forzado.disciplinaValue?.descripcion),
              detalleItem('Turno', forzado.turnoValue?.descripcion),
              detalleItem('Interlock Seguridad', forzado.interlock),
              detalleItem('Responsable', forzado.responsableValue?.nombre),
              detalleItem('Riesgo A', forzado.riesgoAValue?.descripcion),
              detalleItem(
                  'Probabilidad', forzado.probabilidadValue?.descripcion),
              detalleItem('Impacto', forzado.impactoValue?.descripcion),
              detalleItem('Riesgo', forzado.riesgoValue?.descripcion),
              detalleItem(
                  'Solicitante',
                  utf8.decode(
                      latin1.encode(
                          forzado.solicitanteValue?.nombre ?? 'No value'),
                      allowMalformed: true)),
              detalleItem(
                  'Aprobador',
                  utf8.decode(
                      latin1
                          .encode(forzado.aprobadorValue?.nombre ?? 'No value'),
                      allowMalformed: true)),
              detalleItem(
                  'Ejecutor',
                  utf8.decode(
                      latin1
                          .encode(forzado.ejecutorValue?.nombre ?? 'No value'),
                      allowMalformed: true)),
              detalleItem(
                  'Tipo de Forzado', forzado.tipoForzadoValue?.descripcion),
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

    Box<Forzado> box = await Hive.box<Forzado>('Forzado');

    setState(() {
      isSync = true;
    });

    try {
      for (var forzado in box.values) {
        final data = InsertQueryParameters(
          usuario: forzado.usuario!,
          tagPrefijo: forzado.tagPrefijoValue!.id.toString(),
          tagCentro: forzado.tagCentroValue!.id.toString(),
          tagSubfijo: 'Default value',
          descripcion: forzado.descripcion!,
          disciplina: forzado.disciplinaValue!.id.toString(),
          turno: forzado.turnoValue!.id.toString(),
          interlockSeguridad: forzado.interlock!,
          responsable: forzado.responsableValue!.id.toString(),
          riesgoA: forzado.riesgoAValue!.id.toString(),
          riesgo: forzado.riesgoValue!.id.toString(),
          probabilidad: forzado.probabilidadValue!.id.toString(),
          impacto: forzado.impactoValue!.id.toString(),
          solicitante: forzado.solicitanteValue!.id.toString(),
          aprobador: forzado.aprobadorValue!.id.toString(),
          ejecutor: forzado.ejecutorValue!.id.toString(),
          autorizacion: 'Default value',
          tipoForzado: forzado.tipoForzadoValue!.id.toString(),
          projectName: forzado.projectValue!.id.toString(),
        );

        try {
          ApiClient client = ApiClient();
          final res = await client.post(
              AppUrl.postAddForzado, json.encode(data.toMap()));

          if (res.statusCode == 200) {
            // Elimina el objeto sincronizado del Box
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
    Box<Forzado> box = await Hive.box<Forzado>('Forzado');

    setState(() {
      isLoading = true;
    });
    try {
      // Puedes trabajar directamente con el iterable `box.values`
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
            // onPressed: () async {
            //   final box = await Hive.box<Forzado>(HiveBoxes.forzado);
            //   box.clear();
            // },
            onPressed: () => sincronizarInformacion(context),
            icon: const Icon(Icons.sync),
          )
        ],
        title: const Text('Forzados offline'),
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
                            'No hay forzados que sincronizar',
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
                              'Proyecto: ${forzado.projectValue?.descripcion}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Centro: ${forzado.tagCentroValue?.descripcion ?? 'no value'}'),
                            trailing: Wrap(
                              spacing: 8, // Espaciado entre botones
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
          // Indicador de carga
          if (isSync)
            Container(
              color: Colors.black.withOpacity(0.5), // Fondo semitransparente
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Sincronizando información...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
