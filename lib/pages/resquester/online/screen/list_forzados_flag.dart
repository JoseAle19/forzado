import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:provider/provider.dart';

class ListForzadosFlag extends StatelessWidget {
  const ListForzadosFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fozados'),
        centerTitle: true,
      ),
      body: _ListForzadosRequesterLow(),
    );
  }


   Widget _ListForzadosRequesterLow() {
    return Consumer<ForzadosProvider>(
        builder: (context, ForzadosProvider value, child) {
      if (value.errorMessageGetForzados!.isNotEmpty) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.errorMessageGetForzados!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                value.getForzados();
              },
              child: const Text(
                'Reintentar',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
      }
      if (value.forzados.isEmpty) {
        return const Center(
          child: Text('No hay forzados ejecutados'),
        );
      }
      return ListView.builder(
        itemCount: value.forzados.length,
        itemBuilder: (context, index) {
          final f = value.forzados.elementAt(index);
          return _cardForzado(f, context);
        },
      );
    });
  }
Widget _cardForzado(ForzadoItem forzado, BuildContext context) {
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
                    forzado.estado!.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                // navigateDetailForzado(context, forzado);
              },
              icon: const Icon(
                Icons.flag,
                color: Colors.red,
                size: 20,
              ),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}