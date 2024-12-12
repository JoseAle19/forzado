import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';

class CardsDashBoard extends StatelessWidget {
  const CardsDashBoard({super.key, required this.data});
  final ModelListForzados data;

  // List<>
  @override
  Widget build(BuildContext context) {
    List<ForzadoM> list = data.data;

    Map<String, int> contarEstadosExactos(List<ForzadoM> lista) {
      Map<String, int> contador = {
        "pendiente-alta": 0,
        "pendiente-baja": 0,
        "aprobado-alta": 0,
        "aprobado-baja": 0,
        "ejecutado-alta": 0,
        "finalizado": 0,
        "rechazado-alta": 0,
        "rechazado-baja": 0,
      };

      for (var item in lista) {
        if (item.estado != null &&
            contador.containsKey(item.estado!.toLowerCase())) {
          contador[item.estado!.toLowerCase()] =
              (contador[item.estado!.toLowerCase()] ?? 0) + 1;
        }
      }

      return contador;
    }

    Map<String, int> conteoEstados = contarEstadosExactos(list);

    // Mostrar los resultados
    conteoEstados.forEach((estado, cantidad) {});
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: "Pendiente Alta",
                count: conteoEstados["pendiente-alta"] ?? 0,
                color: AppColors.earringColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: "Pendiente Baja",
                count: conteoEstados["pendiente-baja"] ?? 0,
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
                count: conteoEstados["aprobado-alta"] ?? 0,
                color: AppColors.approvedColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: "Aprobado Baja",
                count: conteoEstados["aprobado-baja"] ?? 0,
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
                count: conteoEstados["ejecutado-alta"] ?? 0,
                color: AppColors.executedColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: "Finalizado",
                count: conteoEstados["finalizado"] ?? 0,
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
                count: conteoEstados["rechazado-alta"] ?? 0,
                color: AppColors.refusedColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: "Rechazado Baja",
                count: conteoEstados["rechazado-baja"] ?? 0,
                color: AppColors.refusedColor,
              ),
            ),
          ],
        ),
      ],
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
