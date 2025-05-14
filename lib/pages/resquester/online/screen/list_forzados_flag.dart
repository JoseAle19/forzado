import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        title: const Text('Solicitudes de Forzado'),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 30,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay solicitudes ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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
            return _cardForzado(forzado, context);
          },
        );
      },
    );
  }

  Widget _cardForzado(ForzadoItem forzado, BuildContext context) {
    const Color primaryColor = AppColors.primary;
    const Color secondaryColor = Colors.white;

    Widget detalleItem(String titulo, String valor) {
      String decodedValue = valor;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$titulo: ',
              style:      const TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Expanded(
              child: Text(
                decodedValue,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87),
                softWrap: true,
              ),
            ),
          ],
        ),
      );
    }

    void verInformacion(BuildContext context, ForzadoItem forzado) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: secondaryColor,
          title: const Row(
            children: [
              Icon(Icons.info, color: primaryColor, size: 28),
              SizedBox(width: 8),
              Text(
                'Detalles del Forzado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detalleItem(
                    'Usuario', forzado.usuarioCreacion ?? 'No disponible'),
                detalleItem('Nombre del Proyecto',
                    forzado.proyectoDescripcion ?? 'No disponible'),
                detalleItem(
                    'Centro', forzado.tagCentroDescripcion ?? 'No disponible'),
                detalleItem(
                    'Descripción', forzado.descripcion ?? 'No disponible'),
                detalleItem('Disciplina',
                    forzado.disciplinaDescripcion ?? 'No disponible'),
                detalleItem(
                    'Turno', forzado.turnoDescripcion ?? 'No disponible'),
                detalleItem('Interlock Seguridad',
                    forzado.interlock == 1 ? 'si' : "NO"),
                detalleItem('Responsable',
                    forzado.responsableNombre ?? 'No disponible'),
                detalleItem(
                    'Riesgo', forzado.riesgoDescripcion ?? 'No disponible'),
                detalleItem(
                    'Solicitante', forzado.solicitante ?? 'No disponible'),
                detalleItem('Aprobador', forzado.aprobador ?? 'No disponible'),
                detalleItem('Ejecutor', forzado.ejecutor ?? 'No disponible'),
                detalleItem('Tipo de Forzado',
                    forzado.tipoForzadoDescripcion ?? 'No disponible'),
                detalleItem('Motivo de rechazo',
                    forzado.motivoRechazoDescripcion ?? 'No disponible'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Cerrar',
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ],
        ),
      );
    }

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
            GestureDetector(
              onTap: forzado.observadoEjecucion == true
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
              child: SvgPicture.asset(
                'assets/svgs/edit.svg',
                width: 20,
                color: forzado.observadoEjecucion == true
                    ? const Color(0xffc8a064)
                    : Colors.grey,
              ),
            ),
            // IconButton(
            //   onPressed:
            //   icon: Icon(
            //     Icons.edit,
            //     color: forzado.observadoEjecucion == true
            //         ? AppColors.primary
            //         : Colors.grey,
            //     size: 20,
            //   ),
            //   splashRadius: 20,
            // ),
            IconButton(
              onPressed: () {
                verInformacion(context, forzado);
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: Color(0xffc8a064),
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
