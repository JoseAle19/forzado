import 'package:flutter/material.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';

class ListApproveForzado extends StatelessWidget {
  const ListApproveForzado({
    super.key,
    required this.data,
    required this.isAlta,
  });
  final bool isAlta;
  final List<ForzadoM> data;

  // void navigateDetailsApproveForzado(
  //     BuildContext context, ForzadoM item, bool isAltaF) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           DetailApproveForzado(detailForzado: item, isAlta: isAltaF),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final forzado = data[index];
        final state = forzado.estado!.toLowerCase() == 'pendiente-forzado'
            ? "PENDIENTE-FORZADO"
            : forzado.estado!.toLowerCase() == 'pendiente-retiro'
                ? 'pENDIENTE-RETIRO'
                : 'sIN ESTADO';
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
                        state,
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
                    // navigateDetailsApproveForzado(context, forzado, isAlta);
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
        // return Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       // Indicador circular para el ID
        //       CircleAvatar(
        //         radius: 30,
        //         backgroundColor: const Color(0xFF009283),
        //         child: Text(
        //           item.id.toString(),
        //           style: const TextStyle(
        //             fontSize: 20,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(width: 16),
        //       // Contenido textual
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             // Nombre del elemento
        //             Text(
        //               item.nombre,
        //               style: const TextStyle(
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.w600,
        //                 color: Color(0xFF333333),
        //               ),
        //             ),
        //             const SizedBox(height: 4),
        //             // ID del elemento como subtítulo
        //             Text(
        //               'ID: ${item.id}',
        //               style: const TextStyle(
        //                 fontSize: 14,
        //                 color: Color(0xFF666666),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       // Icono de acción
        //       IconButton(
        //         onPressed: () {
        //           navigateDetailsApproveForzado(context, item, isAlta);
        //         },
        //         icon: const Icon(
        //           Icons.arrow_forward_ios,
        //           size: 20,
        //           color: Color(0xFF009283),
        //         ),
        //         splashRadius: 20,
        //       ),
        //     ],
        //   ),
        // );
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
