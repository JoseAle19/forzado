import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/services/api_client.dart';
import 'package:http/http.dart' as http;

class PasswordProvider with ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();

  bool viewPassword = true;
  String errorMessage = '';
  bool isLoading = false;

  void togglePasswordView() {
    viewPassword = !viewPassword;
    notifyListeners();
  }



  void validatePassword(String value) {
    if (value.isEmpty) {
      errorMessage = 'La contraseña no puede estar vacía.';
    } else if (value.length < 8) {
      errorMessage = 'La contraseña debe tener mínimo 8 caracteres.';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      errorMessage = 'La contraseña solo puede contener letras y números.';
    } else {
      errorMessage = '';
    }
    notifyListeners();

  }



  Future<void> updatePassword(int userId, VoidCallback onSuccess) async {
    if (passwordController.text.isEmpty || errorMessage.isNotEmpty) return;
    isLoading = true;
    notifyListeners();
    try {
      final res = await ApiClient()
          .put(
            '/api/usuarios/reiniciar-contrasena',
            jsonEncode({
              'id': userId,
              'password': passwordController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 5));

      if (res.statusCode == 200) {
        onSuccess();
      } else {
        errorMessage = 'Error al actualizar la contraseña.';
      }
    } on TimeoutException catch (_) {
      errorMessage = 'La solicitud excedió el tiempo límite.';
    } catch (e) {
      errorMessage = 'Error en la solicitud: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  void clean(){
    passwordController.clear();
    errorMessage = '';
    notifyListeners();
  }
}
