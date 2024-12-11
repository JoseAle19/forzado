import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/auth/password_provider.dart';
import 'package:forzado/models/jwt_model.dart';
import 'package:forzado/models/login.dart';
import 'package:forzado/models/model_user_detail.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/auth/widgets/new_password.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isFirstLogIn = false;
  bool viewPassword = true;

  ApiResponseDetailUser? _user; // _user ahora es opcional
  ApiResponseDetailUser? get user => _user;

  Future<void> checkSession() async {
    _user = PreferencesHelper().getUser();
    notifyListeners();
  }
Future<ApiResponse> login(BuildContext context) async {
  final username = usernameController.text.trim();
  final password = passwordController.text.trim();
  CustomModal modal  =   CustomModal();
  if (username.isEmpty || password.isEmpty) {
    return ApiResponse.error(message: 'Completa todos los campos');
  }

  isLoading = true;
  notifyListeners();

  try {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "username": username,
      "password": password,
    });

    final response = await http
        .post(
          Uri.parse('https://sntps2jn-3002.brs.devtunnels.ms/api/mobile/auth'),
          headers: headers,
          body: body,
        )
        .timeout(const Duration(seconds: 10)); // Timeout de 10 segundos

    isLoading = false;
    notifyListeners();

    if (response.statusCode == 200) {
      final decodedToken = JwtDecoder.decode(response.body);
      final jwtModel = JwtModel.fromJson(decodedToken);
      await getUserByEmail(jwtModel.email, context);
      return ApiResponse.success(message: 'Ahora validar rol');
    } else if (response.statusCode == 500) {
      modal.showModal(context, 'Error interno del servidor', Colors.red, false);
      return ApiResponse.error(message: 'Error interno del servidor');
    } else {
            modal.showModal(context, 'Usuario o contraseña inválidos', Colors.red, false);

      return ApiResponse.error(message: 'Usuario o contraseña inválidos');
    }
  } on TimeoutException {
            modal.showModal(context, 'Excedió el tiempo de espera. Intente nuevamente.', Colors.orange, false);

    isLoading = false;
    notifyListeners();
    return ApiResponse.error(message: 'La solicitud excedió el tiempo de espera. Intente nuevamente.');
  } catch (e) {
        modal.showModal(context, 'Error de red o conexión', Colors.orange, false);
    isLoading = false;
    notifyListeners();
    return ApiResponse.error(message: 'Error de red o conexión: $e');
  }
}


  Future<ApiResponseDetailUser> getUserByEmail(
      String email, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      final res = await ApiClient().post(
        '/api/usuarios/por-correo',
        jsonEncode({'email': email}),
      );

      isLoading = false;
      notifyListeners();

      if (res.statusCode == 200) {
        ApiResponseDetailUser user = apiResponseDetailUserFromJson(res.body);

        if (user.flagNuevoIngreso == 1) {
          showAboutDialog(context: context);
          return user;
        } else {
          // Usuario existente
          await PreferencesHelper().setUser(user);
          await Provider.of<AuthProvider>(context, listen: false)
              .checkSession();

          navigateHandleRole(user.role, context);
          return user;
        }
      } else {
        // Error de respuesta de servidor (e.g., 400, 404, etc.)
        return ApiResponseDetailUser.error(
          message: 'Error al obtener usuario: ${res.statusCode}',
        );
      }
    } catch (e) {
      // Error en la solicitud (e.g., conexión fallida)
      isLoading = false;
      notifyListeners();
      return ApiResponseDetailUser.error(message: 'Ocurrió un error: $e');
    }
  }

  void togglePasswordVisibility() {
    viewPassword = !viewPassword;
    notifyListeners();
  }

  void navigateHandleRole(int role, BuildContext context) {
    switch (role) {
      case 4:
        final route = MaterialPageRoute(builder: (_) => const HomeExecuter());
        Navigator.pushReplacement(context, route);
        break;
      case 7:
        final route = MaterialPageRoute(builder: (_) => const HomeExecuter());
        Navigator.pushReplacement(context, route);
        break;
      case 3:
        final route = MaterialPageRoute(builder: (_) => const HomeApprove());
        Navigator.pushReplacement(context, route);
        break;
      case 6:
        final route = MaterialPageRoute(builder: (_) => const HomeApprove());
        Navigator.pushReplacement(context, route);
        break;
      case 2:
        final route = MaterialPageRoute(builder: (_) => const Home());
        Navigator.pushReplacement(context, route);
        break;
      case 5:
        final route = MaterialPageRoute(builder: (_) => const Home());
        Navigator.pushReplacement(context, route);
        break;
    }
  }

  void showPasswordDialog(
      BuildContext context, int userId, VoidCallback onSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<PasswordProvider>(
          builder: (context, provider, _) {
            return PasswordDialog(
              onPasswordChanged: provider.validatePassword,
              passwordController: provider.passwordController,
              viewPassword: provider.viewPassword,
              errorMessage: provider.errorMessage,
              isLoading: provider.isLoading,
              onCancel: () {
                provider.clean();
                Navigator.of(context).pop();
              },
              onTogglePasswordView: provider.togglePasswordView,
              onUpdate: () => provider.updatePassword(userId, onSuccess),
            );
          },
        );
      },
    );
  }
}
