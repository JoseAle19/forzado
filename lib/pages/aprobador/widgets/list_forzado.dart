import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/aprobador/screen/detail_approve_forzado.dart';

class ListApproveForzado extends StatelessWidget {
  const ListApproveForzado({
    super.key,
    required this.data,
    required this.isAlta,
  });
  final bool isAlta;
  final List<ForzadoM> data;

  void navigateDetailsApproveForzado(
      BuildContext context, ForzadoM item, bool isAltaF) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailApproveForzado(detailForzado: item, isAlta: isAltaF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Indicador circular para el ID
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF009283),
                child: Text(
                  item.id.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Contenido textual
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre del elemento
                    Text(
                      item.nombre ?? 'Nombre no disponible',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // ID del elemento como subtítulo
                    Text(
                      'ID: ${item.id}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              // Icono de acción
              IconButton(
                onPressed: () {
                  navigateDetailsApproveForzado(context, item, isAlta);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Color(0xFF009283),
                ),
                splashRadius: 20,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          color: Colors.grey.shade300,
          indent: 12,
          endIndent: 12,
        );
      },
      itemCount: data.length,
    );
  }
}
