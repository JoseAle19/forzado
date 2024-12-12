import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:hive_flutter/adapters.dart';

class ListForzadosEjecutadosProvider with ChangeNotifier {
  List<Forzados> _forzados = [];

  List<Forzados> get forzados => _forzados;

  void cargarForzados() async {
    var box = await Hive.openBox<Forzados>('Forzados');
    _forzados = box.values.toList();
    notifyListeners();
  }
}
