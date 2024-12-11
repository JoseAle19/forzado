import 'package:flutter/material.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:forzado/pages/onboarding/onboardig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {
  bool? hasAcceptedOnboarding;
  bool? isUserLoggedIn;
  int? userRole;
  Widget? nextPage;

  Future<void> loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    hasAcceptedOnboarding = prefs.getBool('aceptOm');
    isUserLoggedIn = prefs.getBool('logged');
    userRole = prefs.getInt('rol');
    nextPage = _determineNextPage();
    notifyListeners();
  }

  Widget _determineNextPage() {
    if (hasAcceptedOnboarding == true) {
      return isUserLoggedIn == true
          ? _navigateHandleRole(userRole ?? 10)
          : const LoginPage();
    } else {
      return const OnBoardigpage();
    }
  }

  Widget _navigateHandleRole(int role) {
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
        return const LoginPage();
    }
  }
}
