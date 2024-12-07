import 'package:flutter/material.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/models/model_user_detail.dart';

class AuthProvider with ChangeNotifier {
  ApiResponseDetailUser? _user; // _user ahora es opcional
  ApiResponseDetailUser? get user => _user;

  Future<void> checkSession() async {
    _user = PreferencesHelper().getUser();
    notifyListeners();
  }
}
