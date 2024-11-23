import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/pages/onboardig.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _nextPage() {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (_) => OnBoardigpage());

    Future.delayed(const Duration(seconds: 1), () {
      print('Pasar ala siguiente pantalla');
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  void initState() {
    _nextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Center(
        child: Image.asset('assets/logos/logo.png'),
      ),
    );
  }
}
