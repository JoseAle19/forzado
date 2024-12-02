import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/home_page.dart';
import 'package:forzado/pages/remove_forzado/widgets/text_info.dart';
import 'package:intl/intl.dart';

class DetailApproveForzado extends StatelessWidget {
  const DetailApproveForzado({super.key, required this.detailForzado});
  final Datum detailForzado;

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
      bottomNavigationBar: const CustomBotttomNavigation(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          const Text('Chancadora principal',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Text(detailForzado.id.toString(),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Fecha de Solicitud: ${returnDate()}',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const TextInfo(
            title: 'Tag (Prefijo) *',
            description: 'Prefijo del Tag o Sub Área',
          ),
          TextInfo(
            title: 'Tag (Centro) *',
            description:
                detailForzado.tagCentroDescripcion ?? 'No hay información',
          ),
          TextInfo(
            title: 'Tag (Sub Fijo) *',
            description:
                detailForzado.subareaDescripcion ?? 'No hay información',
          ),
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
          TextInfo(
            title: 'Disciplina',
            description:
                detailForzado.disciplinaDescripcion ?? 'No hay información',
          ),
          TextInfo(
              title: 'Turno',
              description:'${detailForzado.turnoDescripcion}'),
        ]),
      ),
    );
  }
}
