import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/models/jwt_model.dart';
import 'package:forzado/models/login.dart';
import 'package:forzado/models/model_user_detail.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/pages/home_page.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controllerPass = TextEditingController();
  bool isLoading = false;
  bool isFirstLogIn = false;
  Future<ApiResponse> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      setState(() {
        isLoading = true;
      });

      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        "username": username,
        "password": password,
      });

      // Enviamos la solicitud POST
      final response = await http.post(
        Uri.parse('https://sntps2jn-3001.brs.devtunnels.ms/api/mobile/auth'),
        headers: headers,
        body: body,
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(response.body);
        JwtModel jwtModel = JwtModel.fromJson(decodedToken);

        getUserByEmail(jwtModel.email);

        return ApiResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 500) {
        final errorMessage = 'Ocurrio un error, porfavor contacte a soporte';
        return ApiResponse.error(message: errorMessage);
      } else {
        final errorMessage = 'Usuario o contraseña invalidos';
        return ApiResponse.error(message: errorMessage);
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });

      final errorMessage = 'Error de red o de conexión: $error';
      return ApiResponse.error(message: errorMessage);
    }
  }

  void decodeAndSaveData(name, rol, idUser, flag, user) async {

    await PreferencesHelper().setUser(user);

  }

  Future<ApiResponseDetailUser> getUserByEmail(String email) async {
    CustomModal modal = CustomModal();
    try {
      setState(() {
        isLoading = true;
      });
      final res = await ApiClient().post(
          '/api/usuarios/por-correo',
          jsonEncode({
            'email': email,
          }));

      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        ApiResponseDetailUser user = apiResponseDetailUserFromJson(res.body);
        print('Estado del user ${user.flagNuevoIngreso}');
        if (user.flagNuevoIngreso == 1) {
          setState(() {
            isLoading = false;
          });
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (BuildContext context, setState) {
                  bool isFetchPass = false;
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text(
                      'Establece una contraseña',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Introduce una nueva contraseña para continuar:',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _controllerPass,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      isFetchPass == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                final newPassword = _controllerPass.text;
                                if (newPassword.isNotEmpty) {
                                  setState(() {
                                    isFetchPass = true;
                                  });
                                  try {
                                    final res = await ApiClient().put(
                                      '/api/usuarios/reiniciar-contrasena',
                                      jsonEncode({
                                        'id': user.id,
                                        'password': newPassword.trim(),
                                      }),
                                    );

                                    if (res.statusCode == 200) {
                                      Navigator.of(context).pop();
                                      decodeAndSaveData(
                                        user.name,
                                        user.role,
                                        user.id,
                                        user.flagNuevoIngreso,
                                        user
                                      );
                                      navigateHandleRole(user.role);

                                      modal.showModal(
                                          context,
                                          'Hola ${user.name}',
                                          Colors.blue,
                                          true);
                                    } else {
                                      print('Error: ${res.body}');
                                      modal.showModal(context,
                                          'Ocurrio un error', Colors.red, true);
                                    }
                                  } catch (e) {
                                    print('Error: $e');
                                    modal.showModal(
                                        context,
                                        'Error en la solicitud',
                                        Colors.red,
                                        false);
                                  } finally {
                                    setState(() {
                                      isFetchPass = false;
                                    });
                                  }
                                } else {
                                  modal.showModal(context, 'Campos requeridos',
                                      Colors.red, false);
                                  print('El campo de contraseña está vacío.');
                                }
                              },
                              child: const Text('Actualizar'),
                            ),
                    ],
                  );
                },
              );
            },
          );
        } else {
          modal.showModal(context, 'Bienvenido', Colors.green, true);

          decodeAndSaveData(
              user.name, user.role, user.id, user.flagNuevoIngreso, user);
          navigateHandleRole(user.role);
        }
        return ApiResponseDetailUser.fromJson(jsonDecode(res.body));
      } else {
        modal.showModal(context, 'Ocurrio un error', Colors.red, false);
        return ApiResponseDetailUser(
            id: 0,
            name: '',
            area: '',
            role: 000,
            flagNuevoIngreso: 000,
            jwt: '');
      }
    } catch (e) {
      modal.showModal(context, 'Ocurrio un error interno', Colors.red, false);
      return ApiResponseDetailUser(
          id: 0, name: '', area: '', role: 000, flagNuevoIngreso: 000, jwt: '');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateHandleRole(int role) {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.7,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          scale: 10,
                          alignment: Alignment.topLeft,
                          fit: BoxFit.cover,
                          image: AssetImage('assets/login.png')),
                      color: Colors.transparent,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(100))),
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                              // labelText: 'holas',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: 'Ingrese su usuario'),
                        ),
                        TextFormField(
                          // obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              hintText: 'Ingrese su contraseña'),
                        ),
                        GestureDetector(
                          onTap: () async {
                            ApiResponse res = await login(
                                _usernameController.text,
                                _passwordController.text);
                            if (!res.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(res.message!)));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffB44002),
                                      Color(0xffF57E3D)
                                    ])),
                            padding: const EdgeInsets.symmetric(
                              // horizontal: 60,
                              vertical: 12,
                            ),
                            child: const Text(
                              'Siguiente',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color.fromARGB(184, 0, 0, 0),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
