
import 'package:flutter/material.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:forzado/pages/main_home.dart';
import 'package:forzado/pages/onboarding/onboardig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {
  bool? hasAcceptedOnboarding;
  bool? isUserLoggedIn;
  int? userRole;
  List<int>? roles;
  Widget? nextPage;

  Future<void> loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    hasAcceptedOnboarding = prefs.getBool('aceptOm');
    isUserLoggedIn = prefs.getBool('logged');
    userRole = prefs.getInt('rol');
    roles = prefs.getStringList('roles')?.map((s) => int.parse(s)).toList();
    nextPage = _determineNextPage();
    notifyListeners();
  }

  Widget _determineNextPage() {
    if (hasAcceptedOnboarding == true) {
      return isUserLoggedIn == true && roles != null
          ? _navigateHandleRole(roles)
          : const LoginPage();
    } else {
      return const OnBoardigpage();
    }
  }

  Widget _navigateHandleRole(List<int>? roles) {
    
     return MainHomePage(roles: roles!,);
     
  }
}
