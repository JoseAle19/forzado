import 'package:forzado/models/user/model_user.dart';

import 'package:forzado/models/mestras/puestos_model.dart' as modelp;

extension UserExtensions on List<Value> {
  List<Value> withTurnosFromPuestos(List<modelp.Value> puestos) {
    // Crear mapa de puestos por ID para acceso rápido
    final puestosMap = {for (var p in puestos) p.id: p};
    
    return map((user) {
      if (user.puestoId != null) {
        final puesto = puestosMap[user.puestoId];
        if (puesto != null && puesto.turnos!.isNotEmpty) {
          return user.copyWith(turnos: puesto.turnos);
        }
      }
      return user;
    }).toList();
  }
}