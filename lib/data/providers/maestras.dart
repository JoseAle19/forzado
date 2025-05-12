import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_shifts.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/mestras/matriz_riesgo_model.dart';
import 'package:forzado/models/model_shift.dart' as shift;
import 'package:forzado/services/api_client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class MastersProvider with ChangeNotifier {
  List<shift.Value> _turnos = [];
  List<MatrizRiesgoValue> _matrizRiesgos = [];

  List<shift.Value> get turnos => _turnos;
  List<MatrizRiesgoValue> get matrizRiesgos => _matrizRiesgos;

  bool _shiftLoaded = false;
  bool get shiftLoaded => _shiftLoaded;

  // Nuevas propiedades para el turno actual
  shift.Value? _currentShift;
  shift.Value? get currentShift => _currentShift;

  String? _shiftType; // 'DIA' o 'NOCHE'
  String? get shiftType => _shiftType;

  String _dateNow = '0000/00/00';
  String? get date => _dateNow;

  void formatDate() {
    final formattedDate =
        DateFormat('dd/MM/yyyy, HH:mm:ss').format(DateTime.now());
    _dateNow = formattedDate;
  }

  Future<void> getTagsMatrizRiesgo() async {
    ApiClient client = ApiClient();
    final response = await client.get(AppUrl.getMatrizRiesgo);
    final decodedata = matrizRiesgoFromJson(response.body);
    _matrizRiesgos = decodedata.values ?? [];
  }

  Future<void> getShifts() async {
    _shiftLoaded = true;
    notifyListeners();

    try {
      ApiClient client = ApiClient();
      final res = await client.get(AppUrl.getturnos);
      final decodeData = shift.shiftModelFromJson(res.body);

      final box = Hive.box<ShiftValue>('shiftBox');
      await box.clear();
      for (var item in decodeData.values ?? []) {
      await   box.add(ShiftValue.fromJson(item.toJson()));
      }
      _turnos = decodeData.values ?? [];

      // Determinar turno actual después de cargar
      _determineCurrentShift();
      formatDate();
      _shiftLoaded = false;

      notifyListeners();
    } catch (e) {
      _shiftLoaded = false;
      notifyListeners();
      throw e;
    }
  }

  String normalizar(String texto) {
    return texto.characters.toString();
  }

  void _determineCurrentShift() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    for (final turno in _turnos) {
      final startTime = _parseTimeString(turno.horaInicio!);
      final endTime = _parseTimeString(turno.horaFin!);

      if (_isTimeInShift(currentTime, startTime, endTime)) {
        _currentShift = turno;
        _shiftType = normalizar(turno.descripcion ?? '--'); // 'DIA' o 'NOCHE'
        notifyListeners();
        return;
      }
    }
  }

  TimeOfDay _parseTimeString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  bool _isTimeInShift(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final nowInMinutes = current.hour * 60 + current.minute;
    final startInMinutes = start.hour * 60 + start.minute;
    final endInMinutes = end.hour * 60 + end.minute;

    if (startInMinutes <= endInMinutes) {
      // Turno normal (mismo día)
      return nowInMinutes >= startInMinutes && nowInMinutes <= endInMinutes;
    } else {
      // Turno que cruza medianoche (ej. 19:00-06:59)
      return nowInMinutes >= startInMinutes || nowInMinutes <= endInMinutes;
    }
  }
}
