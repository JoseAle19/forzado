import 'package:flutter/material.dart';
import 'package:forzado/core/app_colors.dart';
import 'package:forzado/pages/home_page.dart';
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

    Widget nextPage;

    if (hasAcceptedOnboarding == true) {
      nextPage = isUserLoggedIn == true ? Home() : Home();
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
