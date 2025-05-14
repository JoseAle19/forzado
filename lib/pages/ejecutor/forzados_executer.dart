import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/pages/aprobador/provider/forzados_provider.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/pages/ejecutor/models/aprobador.dart';
import 'package:provider/provider.dart';

class ListExecuterForzado extends StatefulWidget {
  const ListExecuterForzado({super.key, required this.isExecuterAlta});
  final bool isExecuterAlta;

  @override
  State<ListExecuterForzado> createState() => _ListExecuterForzadoState();
}

class _ListExecuterForzadoState extends State<ListExecuterForzado> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await getData();
      }
    });
  }

  Future<void> getData() async {
    final providerForzados =
        Provider.of<ForzadosProviderApprove>(context, listen: false);
    await providerForzados.initLoadSolicitudes();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = AppColors.primary;
    const Color secondaryColor = Colors.white;

    Widget detalleItem(String titulo, String valor) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$titulo: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Expanded(
              child: Text(
                valor,
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }

    void verInformacion(BuildContext context, ForzadoApprove forzado) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: secondaryColor,
          title: const  Row(
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

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       final route = MaterialPageRoute(builder: (_) => HomeExecuter());
        //       Navigator.pushAndRemoveUntil(context, route, (r) => false);
        //     },
        //     icon: const Icon(Icons.arrow_back_ios_new)),
        title: const  Text('Consultas'),
        
      ),
      body: Consumer<ForzadosProviderApprove>(builder: (context, value, child) {
        return value.loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
            : value.messageError.isNotEmpty
                ? Center(
                    child: Text(value.messageError),
                  )
                : value.listForzados.where((forzado) {
                    final estadoEsperado = widget.isExecuterAlta
                        ? 'APROBADO-FORZADO'
                        : 'APROBADO-RETIRO';
                    return forzado.estado?.toUpperCase() == estadoEsperado;
                  }).isEmpty
                    ? const Center(
                        child: Text('No hay solicitudes'),
                      )
                    : ListView.builder(
                        itemCount: value.listForzados.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ForzadoApprove forzado =
                              value.listForzados[index];
                          final estadoEsperado = widget.isExecuterAlta
                              ? 'APROBADO-FORZADO'
                              : 'APROBADO-RETIRO';

                          if (forzado.estado?.toUpperCase() != estadoEsperado) {
                            return const SizedBox.shrink();
                          }

                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        Text(
                                          forzado.estado!,
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
                                      verInformacion(context, forzado);
                                    },
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    splashRadius: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
      }),
    );
  }
}
