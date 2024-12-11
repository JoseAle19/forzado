import 'package:flutter/material.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/data/providers/requester_provider.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:forzado/pages/resquester/offline/page_offline.dart';
import 'package:forzado/pages/resquester/online/screen/home.dart';
import 'package:forzado/widgets/sync.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomBotttomNavigation(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Consumer<AuthProvider>(
            builder: (context, value, child) => Text(
              'Hola ${value.user?.name}',
              style: const TextStyle(
                  fontFamily: 'noto', fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Consumer<RequesterHomeProvider>(
              builder: (context, value, child) {
                return value.isConnected
                    ? IconButton(
                        onPressed: () async {
                          await PreferencesHelper().clear();
                          final route = MaterialPageRoute(
                              builder: (_) => const LoginPage());
                          Navigator.push(context, route);
                        },
                        icon: const Icon(Icons.login_rounded))
                    : const Icon(
                        Icons.wifi_off,
                        size: 30,
                        color: Colors.red,
                      );
              },
            )
          ],
        ),
        body: Consumer<RequesterHomeProvider>(builder: (context, value, child) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: value.pageController,
            children: [
              PageOnline(
                widget: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SyncData()),
              ),
              const PageOffline(),
            ],
          );
        }));
  }
}


class CustomBotttomNavigation extends StatelessWidget {
  const CustomBotttomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings), label: 'Configuración'),
    ]);
  }
}
