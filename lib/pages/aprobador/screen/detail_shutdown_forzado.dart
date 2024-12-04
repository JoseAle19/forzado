import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/solicitante/online/widgets/text_info.dart';
import 'package:intl/intl.dart';

class DetailShutdownForzado extends StatelessWidget {
  const DetailShutdownForzado({super.key, required this.detailForzado});

  final ForzadoM detailForzado;

  String returnDate() {
    if (detailForzado.fecha != null) {
      return DateFormat('dd/MM/yyyy').format(detailForzado.fecha!);
    } else {
      return 'No hay fecha';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Chancadora Principal'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chancadora Principal',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'ID: ${detailForzado.id}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Fecha de Solicitud: ${returnDate()}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Solicitante: 29/11/2024',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const TextInfo(
                title: 'Solicitante Retiro',
                description: '  ',
              ),
              const SizedBox(height: 20),
              const TextInfo(
                title: 'Aprobador Retiro (AN)',
                description: 'Solicitante del Retiro',
              ),
              const SizedBox(height: 20),
              const TextInfo(
                title: 'Ejecutor Retiro (AN)',
                description: 'Solicitante del Retiro',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Descripción *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: detailForzado.descripcion,
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          filled: true,
                          fillColor: Color(0xFFE0E0E0),
                        ),
                        maxLines: 5,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          //TODO: Implementar la lógica de aceptar
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          'Aprobar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          //TODO: Implementar la lógica de rechazar
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          'Rechazar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
