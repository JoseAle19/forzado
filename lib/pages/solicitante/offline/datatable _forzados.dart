import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/adapters/forzado.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/models/form/forzado/model_forzado.dart';
import 'package:forzado/services/api_client.dart';
import 'package:hive/hive.dart';

class ForzadosDataTable extends StatefulWidget {
  const ForzadosDataTable();

  @override
  State<ForzadosDataTable> createState() => _ForzadosDataTableState();
}

class _ForzadosDataTableState extends State<ForzadosDataTable> {
  List<Forzado> listForzado = [];

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
              detalleItem('Prefijo', forzado.tagCentroDescription),
              detalleItem('Centro', forzado.tagCentroDescription),
              detalleItem('Descripción', forzado.descripcionDescription),
              detalleItem('Disciplina', forzado.disciplinaDescription),
              detalleItem('Turno', forzado.turnoDescription),
              detalleItem(
                  'Interlock Seguridad', forzado.iterlockSeguridadDescription),
              detalleItem('Responsable', forzado.responsableDescription),
              detalleItem('Riesgo A', forzado.riesgoADescription),
              detalleItem('Probabilidad', forzado.probabilidadDescription),
              detalleItem('Impacto', forzado.impactoDescription),
              detalleItem('Riesgo', forzado.riesgoDescription),
              detalleItem('Solicitante', forzado.solicitanteDescription),
              detalleItem('Aprobador', forzado.aprobadorDescription),
              detalleItem('Ejecutor', forzado.ejecutorDescription),
              detalleItem('Autorización', forzado.autorizacionDescription),
              detalleItem('Tipo de Forzado', forzado.tipoDeForzadoDescription),
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

  void sincronizarInformacion() async {
    try {
      for (var i = 0; i < listForzado.length; i++) {
        Forzado forzado = listForzado[i];

print(forzado.descripcion);

        final data = InsertQueryParameters(
            tagPrefijo: '1',
            tagCentro: forzado.tagCentro!,
            tagSubfijo: 'Subfijo',
            descripcion: forzado.descripcion!,
            disciplina: forzado.disciplina!,
            turno: forzado.turno!,
            interlockSeguridad: forzado.interlock!,
            responsable: forzado.responsable!,
            riesgo: forzado.riesgo!,
            probabilidad: forzado.probabilidad!,
            impacto: forzado.impacto!,
            solicitante: forzado.solicitante!,
            aprobador: forzado.aprobador!,
            ejecutor: forzado.ejecutor!,
            autorizacion: '1',
            tipoForzado: forzado.tipoDeForzado!);

        // final transformedMap =
        //     data.toJson().map((key, value) => MapEntry(key, value.toString()));

        // final jsonString = jsonEncode(transformedMap);
        //     print(jsonString);
        // ApiClient client = new ApiClient();
        // final response = await client.post(AppUrl.postAddForzado, jsonString);

        // if (response.statusCode == 200) {
        //   print('Respuesta exitosa: ${response.body}');
        // } else {
        //   print(response.body);
        //   print('Error en la solicitud: ${response.statusCode}');
        // }
      }

      final box = Hive.box(HiveBoxes.forzado);
      await box.clear();

    print('Datos ');
    } catch (e) {
      print('Error al guardar: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadForzados();
  }

  void loadForzados() async {
    late Box<Forzado> box;
    try {
      box = await Hive.openBox(HiveBoxes.forzado);
      setState(() {
        listForzado = box.values.toList();
      });
    } catch (e) {
      print('Error al guardar: $e');
    } finally {
      // Cerrar la caja
      if (box.isOpen) {
        await box.close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla de Forzados'),
      ),
      body: listForzado.isEmpty
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
                    'No hay forzados agregados',
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      forzado.descripcion ?? 'Sin descripción',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Centro: ${forzado.tagCentro ?? 'N/A'}'),
                    trailing: Wrap(
                      spacing: 8, // Espaciado entre botones
                      children: [
                        IconButton(
                          icon: Icon(Icons.info_outline, color: Colors.blue),
                          tooltip: 'Ver información',
                          onPressed: () => verInformacion(context, forzado),
                        ),
                        IconButton(
                          icon: Icon(Icons.sync, color: Colors.green),
                          tooltip: 'Sincronizar información',
                          onPressed: () => sincronizarInformacion(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String formatInsertQueryParameters(InsertQueryParameters params) {
    return '''
InsertQueryParameters(
  tagPrefijo: ${params.tagPrefijo},
  tagCentro: ${params.tagCentro},
  tagSubfijo: ${params.tagSubfijo},
  descripcion: ${params.descripcion},
  disciplina: ${params.disciplina},
  turno: ${params.turno},
  interlockSeguridad: ${params.interlockSeguridad},
  responsable: ${params.responsable},
  riesgo: ${params.riesgo},
  probabilidad: ${params.probabilidad},
  impacto: ${params.impacto},
  solicitante: ${params.solicitante},
  aprobador: ${params.aprobador},
  ejecutor: ${params.ejecutor},
  autorizacion: ${params.autorizacion},
  tipoForzado: ${params.tipoForzado}
)
  ''';
  }
}
