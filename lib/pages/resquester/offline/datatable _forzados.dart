// ignore_for_file: avoid_print

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
      setState(() {
        isSync = true;
      });
      for (var i = 0; i < listForzado.length; i++) {
        Forzado forzado = listForzado[i];

        final data = InsertQueryParameters(
            tagPrefijo: forzado.tagPrefijo!.toString(),
            tagCentro: forzado.tagCentro.toString(),
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

        final transformedMap =
            data.toJson().map((key, value) => MapEntry(key, value.toString()));

        final jsonString = jsonEncode(transformedMap);

        ApiClient client = new ApiClient();
        final response = await client.post(AppUrl.postAddForzado, jsonString);

        if (response.statusCode == 200) {
          print('Respuesta exitosa');
        } else {
          print(response.body);
          print('Error en la solicitud: ${response.statusCode}');
        }
      }
      deleteForzadoBox();

      setState(() {
        isSync = false;
      });
    } catch (e) {
      print('Error al guardar: $e');
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
    late Box<Forzado> box;
    setState(() {
      isLoading = true;
    });
    try {
      box = await Hive.openBox(HiveBoxes.forzado);
      setState(() {
        listForzado = box.values.toList();
      });
    } catch (e) {
      print('Error al guardar: $e');
    } finally {
      setState(() {
      isLoading = false
      ;        
      });
      if (box.isOpen) {
        await box.close();
      }
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
            onPressed: sincronizarInformacion,
            icon: const Icon(Icons.sync),
          )
        ],
        title: const  Text('Forzados offline'),
      ),
      body: Stack(
        children: [
        isLoading?const Center(child:  CircularProgressIndicator(),)   :listForzado.isEmpty
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
                          forzado.descripcion ?? 'Sin descripción',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Centro: ${forzado.tagCentro ?? 'N/A'}'),
                        trailing: Wrap(
                          spacing: 8, // Espaciado entre botones
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.info_outline, color: Colors.blue),
                              tooltip: 'Ver información',
                              onPressed: () => verInformacion(context, forzado),
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
