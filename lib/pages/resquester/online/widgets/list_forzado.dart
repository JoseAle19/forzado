import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/resquester/online/screen/form_remove.dart';

class ListForzado extends StatelessWidget {
  const ListForzado({
    super.key,
    required this.data,
  });

  final List<ForzadoM> data;

  void navigateDetailForzado(BuildContext context, ForzadoM item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormRemoveForzado(
          detailForzado: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = data[index];
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
                    '${item.id}',
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
                        'ID: ${item.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Descripción
                      Text(
                        item.descripcion ?? 'Descripción no disponible',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    navigateDetailForzado(context, item);
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
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8); // Espacio vertical entre elementos
      },
      itemCount: data.length,
    );
  }
}