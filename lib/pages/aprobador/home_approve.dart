import 'package:flutter/material.dart';
import 'package:forzado/pages/home_page.dart';
import 'package:forzado/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeApprove extends StatelessWidget {
  const HomeApprove({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomBotttomNavigation(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Hola Jose',
            style: TextStyle(fontFamily: 'noto', fontWeight: FontWeight.bold),
          ),
          actions: [
            const IconButton(
                onPressed: null, icon: Icon(Icons.notifications_none_outlined)),
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  final route =
                      MaterialPageRoute(builder: (_) => const LoginPage());
                  Navigator.push(context, route);
                },
                icon: Icon(Icons.login_rounded))
          ],
        ),
        body: Text('Hola'));
  }
}
