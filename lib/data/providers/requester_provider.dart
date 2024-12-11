import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequesterHomeProvider with ChangeNotifier {
  bool isConnected = false;
  String user = 'usuario';
  final PageController pageController = PageController();

  RequesterHomeProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await getData();
    await _verifyConnection();
    _navigateToPage();
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    user = prefs.getString('username') ?? 'usuario';
    notifyListeners();
  }

  Future<void> _verifyConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      isConnected = true;
    } else {
      isConnected = false;
    }
  }

  void _navigateToPage() {
    pageController.jumpToPage(isConnected ? 0 : 1);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
