import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/ejecutor/forzados_executer.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';

class DetailForzadoScreen extends StatefulWidget {
  const DetailForzadoScreen({super.key, required this.forzado, required this.isExecuterAlta});
  final ForzadoM forzado;
  final bool isExecuterAlta;
  @override
  State<DetailForzadoScreen> createState() => _DetailForzadoScreenState();
}

class _DetailForzadoScreenState extends State<DetailForzadoScreen> {
  bool isFetching = false; // Variable para controlar el estado de carga

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles Forzado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información inicial
              Text(
                'Fecha de Solicitud:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.forzado.fecha != null
                    ? "${widget.forzado.fecha!.day}/${widget.forzado.fecha!.month}/${widget.forzado.fecha!.year}"
                    : 'No especificada',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Solicitante:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.forzado.solicitante ?? 'No especificado',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Aprobador:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.forzado.usuarioModificacion ?? 'No especificado',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Divider(),

              // Campos de información visual
              const Text(
                'Tag (Prefijo)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.forzado.subareaCodigo ?? 'Prefijo del Tag o Sub Área',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tag (Centro)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.forzado.tagCentroDescripcion ??
                      'Parte Central del Tag Asoc. al instrumento o Equipo',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tag (Sub Fijo) *',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.forzado.tagCentroCodigo ?? 'Ingrese Sub Fijo del Tag',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),

              const Divider(),

              // Indicador de carga
              if (isFetching)
               const  Center(
                  child: CircularProgressIndicator(),
                )
              else
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await handleExecution(widget.forzado.id.toString(), widget.isExecuterAlta);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xff009283),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Ejecutar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleExecution(String id, bool iisExecuterAlta) async {
    CustomModal modal = CustomModal();
    setState(() {
      isFetching = true;
    });

    int result = await executerAlta(id,iisExecuterAlta);

    setState(() {
      isFetching = false;
    });

    if (result == 0) {
      modal.showModal(context, 'Ejecutado', Colors.green, true);
      final route = MaterialPageRoute(
          builder: (_) => CongratulationAnimation(page:ListExecuterForzado(isExecuterAlta: iisExecuterAlta ==true?true:false,)));
      Navigator.pushReplacement(context, route);
    } else {
      modal.showModal(
          context, 'Ocurrio un error, contacta a soporte', Colors.red, false);
    }
  }

  Future<int> executerAlta(String id, bool isAlta) async {
    ApiClient client = ApiClient();
    final Map<String, dynamic> body = {'id': id};
    try {
      final res = await client.post(isAlta ?AppUrl.postEjecutarAlta: AppUrl.postEjecutarBaja , jsonEncode(body));
      print(res.body);
      return 0;
    } catch (e) {
      print('Ocurrió un error $e');
      return 1;
    }
  }
}
