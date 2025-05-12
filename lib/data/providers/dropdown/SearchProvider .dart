import 'dart:async';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final List<String> _listaOriginal = ['Manzana', 'Banana', 'Pera', 'Uva'];
  
  List<String> _resultados = [];
  Timer? _debounce;

  List<String> get resultados => _resultados;

  void buscar(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        _resultados = [];
      } else {
        _resultados = _listaOriginal
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
