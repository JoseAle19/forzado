import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:provider/provider.dart';

class CardsDashBoard extends StatelessWidget {
  const CardsDashBoard({
    super.key,
  });

  // List<>
  @override
  Widget build(BuildContext context) {
    // Mostrar los resultados
    return Consumer<ForzadosProvider>(
      builder: (context, value, child) {
        if (value.isFetch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (value.errorMessage != null) {
          // Mostrar el mensaje de error
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 50),
                const SizedBox(height: 10),
                Text(
                  value.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Reintenta la solicitud
                    value.fetchCountForzados();
                  },
                  child: const Text("Reintentar"),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: DashboardCard(
                    title: "Pendiente Alta",
                    count: value.pendingHighCount,
                    color: AppColors.earringColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DashboardCard(
                    title: "Pendiente Baja",
                    count: value.pendingLowCount,
                    color: AppColors.earringColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DashboardCard(
                    title: "Aprobado Alta",
                    count: value.approvedHighCount,
                    color: AppColors.approvedColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DashboardCard(
                    title: "Aprobado Baja",
                    count: value.approvedLowCount,
                    color: AppColors.approvedColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DashboardCard(
                    title: "Ejecutado Alta",
                    count: value.executedHighCount,
                    color: AppColors.executedColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DashboardCard(
                    title: "Finalizado",
                    count: value.finalizedCount,
                    color: AppColors.finalizedColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DashboardCard(
                    title: "Rechazado Alta",
                    count: value.rejectedHighCount,
                    color: AppColors.refusedColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DashboardCard(
                    title: "Rechazado Baja",
                    count: value.rejectedLowCount,
                    color: AppColors.refusedColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  DashboardCard(
      {required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Agrega la acción que deseas al presionar la tarjeta
        print('Card tapped: $title');
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16), // Bordes más redondeados
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: Offset(3, 3), // Sombra desplazada hacia abajo y derecha
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(-3, -3), // Efecto de luz superior izquierda
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 32, // Tamaño de texto más grande para destacar
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
