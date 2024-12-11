import 'package:flutter/material.dart';
import 'package:forzado/pages/splash/splash.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Splash()),
    );
  }
}
