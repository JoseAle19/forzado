import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/pages/steps_form/step_form.dart';
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
      builder: (context, ForzadosProvider provider, child) {
        if (provider.loadingGetForzados) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.forzados.isEmpty) {
          return const Center(
            child: Text('No hay forzados'),
          );
        }

        final errorMessage = provider.errorMessageGetForzados;
        if (errorMessage?.isNotEmpty ?? false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: provider.getForzados,
                  child: const Text(
                    'Reintentar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: provider.forzados.length,
          itemBuilder: (context, index) {
            final forzado = provider.forzados[index];
            print(forzado.observadoEjecucion);
            return _cardForzado(forzado, context);
          },
        );
      },
    );
  }

  Widget _cardForzado(ForzadoItem forzado, BuildContext context) {
    final isReset = forzado.observadoEjecucion == true ? "Si" : "No";
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
              backgroundColor: AppColors.primary,
              child: Text(
                '${forzado.id}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reiniciado: $isReset',
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
              onPressed: forzado.observadoEjecucion == true
                  ? () {
                      final dropdownProvider =
                          Provider.of<DropDownValuesManagerProvider>(context,
                              listen: false);
                      dropdownProvider.fillDataUpdate(forzado.id!);
                      final route = MaterialPageRoute(
                          builder: (context) => StepperForm(
                                isUpdate: true,
                                idForzado: forzado.id,
                              ));
                      Navigator.push(context, route);
                    }
                  : null,
              icon: Icon(
                Icons.edit,
                color: forzado.observadoEjecucion == true
                    ? AppColors.primary
                    : Colors.grey,
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
