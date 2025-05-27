import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/pages/resquester/offline/stepper_form.dart';
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
              style: const TextStyle(
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

    // Función auxiliar para formatear fechas
    String? _formatDate(DateTime? date) {
      return date?.toString().substring(0, 16);
    }

// Función auxiliar para títulos de sección
    Widget _buildSectionTitle(String title) {
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
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
              const Icon(Icons.info, color: primaryColor, size: 28),
              const SizedBox(width: 8),
              const Text(
                'Detalles del Forzado',
                style: const TextStyle(
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
                // Sección 1: Información básica
                _buildSectionTitle('Información Básica'),
                detalleItem('ID', forzado.id?.toString() ?? 'No disponible'),
                detalleItem(
                    'Estado', forzado.estado!.toUpperCase() ?? 'No disponible'),
                detalleItem('Etapa', forzado.etapa ?? 'No disponible'),
                detalleItem(
                    'Reiniciado', forzado.reiniciado == true ? 'Sí' : 'No'),

                // Sección 2: Fechas
                _buildSectionTitle('Fechas'),
                detalleItem('Fecha Creación',
                    _formatDate(forzado.fechaCreacion) ?? 'No disponible'),
                detalleItem('Fecha Cierre',
                    _formatDate(forzado.fechaCierre) ?? 'No disponible'),

                // Sección 3: Tags
                _buildSectionTitle('Identificación'),
                detalleItem(
                    'Tag Prefijo', forzado.tagPrefijo ?? 'No disponible'),
                detalleItem('Tag Sufijo', forzado.tagSufijo ?? 'No disponible'),
                detalleItem(
                    'Tag Concatenado', forzado.tagConcat ?? 'No disponible'),
                detalleItem(
                    'Centro', forzado.tagCentroDescripcion ?? 'No disponible'),

                // Sección 4: Descripción
                _buildSectionTitle('Descripción'),
                detalleItem(
                    'Descripción', forzado.descripcion ?? 'No disponible'),
                detalleItem('Disciplina',
                    forzado.disciplinaDescripcion ?? 'No disponible'),
                detalleItem(
                    'Turno', forzado.turnoDescripcion ?? 'No disponible'),
                detalleItem('Interlock Seguridad',
                    forzado.interlock == 1 ? 'Sí' : 'No'),

                // Sección 5: Riesgos
                _buildSectionTitle('Evaluación de Riesgos'),
                detalleItem(
                    'Riesgo', forzado.riesgoDescripcion ?? 'No disponible'),
                detalleItem('Probabilidad',
                    forzado.probabilidadDescripcion ?? 'No disponible'),
                detalleItem(
                    'Impacto', forzado.impactoDescripcion ?? 'No disponible'),
                detalleItem(
                    'Nivel de Riesgo', forzado.nivelRiesgo ?? 'No disponible'),

                // Sección 6: Responsables
                _buildSectionTitle('Responsables'),
                detalleItem('Área', forzado.area ?? 'No disponible'),
                detalleItem(
                    'Solicitante', forzado.solicitante ?? 'No disponible'),
                detalleItem('Aprobador', forzado.aprobador ?? 'No disponible'),
                detalleItem('Ejecutor', forzado.ejecutor ?? 'No disponible'),
                detalleItem('Responsable',
                    forzado.responsableNombre ?? 'No disponible'),

                // // Sección 8: Adicionales
                // _buildSectionTitle('Información Adicional'),
                // detalleItem('Usuario Creación',
                //     forzado.usuarioCreacion ?? 'No disponible'),
                // detalleItem('Tipo de Forzado',
                //     forzado.tipoForzadoDescripcion ?? 'No disponible'),
                // detalleItem('Motivo de rechazo',
                //     forzado.motivoRechazoDescripcion ?? 'No disponible'),
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
                style: const TextStyle(color: secondaryColor),
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: _getStatusColor(forzado.estado.toString()).withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con información principal
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda (ID y contenido principal)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Registro #${forzado.id}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        forzado.descripcion ?? 'Sin descripción',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                // Columna derecha (Estado)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(forzado.estado.toString())
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _getStatusColor(forzado.estado.toString())
                          .withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    forzado.estado.toString().toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(forzado.estado.toString()),
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Sección de tags/metadata
            if (forzado.tagConcat != null && forzado.tagConcat!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tag :',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildFormalTagChip(forzado.tagConcat!),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),

            // Divider y acciones
            const Divider(height: 24, thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.info_outline, size: 18),
                  label: const Text(
                    'Detalles',
                    style: TextStyle(fontSize: 13),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueGrey[700],
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  onPressed: () {
                    verInformacion(context, forzado);
                  },
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text(
                    'Editar',
                    style: TextStyle(fontSize: 13),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueGrey[700],
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  onPressed: forzado.observadoEjecucion == true &&
                          forzado.estado == 'pendiente'
                      ? () async {
                          final dropdownProvider =
                              Provider.of<DropDownValuesManagerProvider>(
                                  context,
                                  listen: false);
                          await dropdownProvider.fillDataUpdate(forzado.id!);
                          final route = MaterialPageRoute(
                              builder: (context) => StepperForm(
                                    isUpdate: true,
                                    idForzado: forzado.id.toString(),
                                  ));
                          Navigator.push(context, route);
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormalTagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }

// Función para colores según estado (versión más sobria)
  Color _getStatusColor(String estado) {
    final est = estado.toLowerCase();
    if (est.contains('pendiente')) return const Color(0xFFF39C12);
    if (est.contains('aprobado-forzado')) return const Color(0xFF27AE60);
    if (est.contains('rechazado-forzado')) return const Color(0xFFE74C3C);
    if (est.contains('finalizado')) return const Color(0xFF3498DB);
    return const Color(0xFF7F8C8D);
  }
}
