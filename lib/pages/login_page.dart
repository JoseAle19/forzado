import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/models/login.dart';
import 'package:forzado/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  Future<ApiResponse> login(String username, String password) async {
    setState(() {
      isLoading = true;
    });

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "username": username,
      "password": password,
    });

    final response = await http.post(
      Uri.parse('https://sntps2jn-3001.brs.devtunnels.ms/api/mobile/auth'),
      headers: headers,
      body: body,
    );
    setState(() {
      isLoading = false;
    });
    return ApiResponse.fromJson(json.decode(response.body));
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
                  width: double.infinity,
                  height: size.height * 0.7,
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
                  // color: Colors.green,
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
                            final res = await login(_usernameController.text,
                                _passwordController.text);
                            if (res.success) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('logged', true);

                              final route = MaterialPageRoute(
                                  builder: (_) => const Home());
                              Navigator.push(context, route);
                            } else {
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
