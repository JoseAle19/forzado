import 'package:flutter/material.dart';
import 'package:forzado/core/abstract/drop_menu_item.dart';
import 'package:forzado/services/dropdown/service_dropdown.dart';

class DropDownProvider<T extends DropDownItem> with ChangeNotifier {
  final ApiServiceDropdown _apiServiceDropdown = ApiServiceDropdown();
  List<T> _items = [];
  bool _isLoading = false;
  String _error = '';

  List<T> get items => _items;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchData(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _items = await _apiServiceDropdown.fetchData(endpoint, fromJson);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
