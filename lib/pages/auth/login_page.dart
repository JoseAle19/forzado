import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Stack(
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
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100))),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            controller: value.usernameController,
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                                // labelText: 'holas',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                hintText: 'Ingrese su usuario'),
                          ),
                          TextFormField(
                            obscureText: value.viewPassword,
                            keyboardType: TextInputType.text,
                            controller: value.passwordController,
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: value.togglePasswordVisibility,
                                  icon: Icon(
                                    !value.viewPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                hintText: 'Ingrese su contraseña'),
                          ),
                          GestureDetector(
                            onTap: () async {
                              value.login(context);
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
            value.isLoading
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
        );
      },
    ));
  }
}
