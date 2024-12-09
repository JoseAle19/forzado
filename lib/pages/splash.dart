import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/pages/home_page.dart';
import 'package:forzado/pages/login_page.dart';
import 'package:forzado/pages/onboardig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _nextPage() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? hasAcceptedOnboarding = prefs.getBool('aceptOm');
    final bool? isUserLoggedIn = prefs.getBool('logged');
    final int? rol = prefs.getInt('rol');

    Widget nextPage;
    if (hasAcceptedOnboarding == true) {
      nextPage =
          isUserLoggedIn == true ? navigateHandleRole(rol ?? 10) : LoginPage();
    } else {
      nextPage = const OnBoardigpage();
    }

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => nextPage),
      );
    });
  }

  Widget navigateHandleRole(int role) {
    switch (role) {
      case 4:
      case 7:
        return const HomeExecuter();
      case 3:
      case 6:
        return const HomeApprove();
      case 2:
      case 5:
        return const Home();
      default:
        return LoginPage();
    }
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
