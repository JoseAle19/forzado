import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/pages/resquester/offline/page_offline.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  final List<int> roles;
  const MainHomePage({Key? key, required this.roles}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin {
  late final List<Widget> _pages;
  late final List<BottomNavigationBarItem> _items;
  late final List<int> effectiveRoles;
  bool isRequester = false;
  // provider para verificar la conexion a internet

  void veryfyUserLoggedAndConnection(BuildContext c, List<int> roles) {
    final esRequester = roles.contains(1);
    print(roles);
    print('cx');
    setState(() {
      isRequester = esRequester;
    });
  }

  bool isConnected = false;

  Future<void> _verifyConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
          setState(() {
      isConnected = true;
          });
    } else {
      setState(() {
      isConnected = false;
      });
    }
  }

  AnimationController? _animationController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _verifyConnection();
    veryfyUserLoggedAndConnection(context, widget.roles);
    final roleMap = <int, MapEntry<String, Widget>>{
      1: const MapEntry('Solicitante', Home()),
      2: const MapEntry('Aprobador', HomeApprove()),
      3: const MapEntry('Ejecutor', HomeExecuter()),
      4: const MapEntry('Aprobador Interlock', HomeApprove()),
      5: const MapEntry('Administrador', Home()),
    };
    final allExceptAdmin = widget.roles
        .where((r) => r != 5)
        .toList()
        .where(roleMap.containsKey)
        .toList(growable: false);
    effectiveRoles = widget.roles.contains(5)
        ? allExceptAdmin
        : widget.roles.where(roleMap.containsKey).toList();

    _pages =
        effectiveRoles.map((r) => roleMap[r]!.value).toList(growable: false);

    _items = effectiveRoles
        .map((r) => BottomNavigationBarItem(
              icon: Icon(_iconForRole(r)),
              label: roleMap[r]!.key,
              backgroundColor: _colorForRole(r),
            ))
        .toList(growable: false);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  IconData _iconForRole(int role) {
    switch (role) {
      case 1:
        return Icons.request_page;
      case 2:
        return Icons.check_circle_outline;
      case 3:
        return Icons.build_circle_outlined;
      case 4:
        return Icons.security;
      case 5:
        return Icons.admin_panel_settings;
      default:
        return Icons.help_outline;
    }
  }

  Color _colorForRole(int role) {
    switch (role) {
      case 1:
        return Colors.blue.shade700;
      case 2:
        return Colors.green.shade700;
      case 3:
        return Colors.orange.shade700;
      case 4:
        return Colors.purple.shade700;
      case 5:
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isRequester && !isConnected ) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
              const SizedBox(height: 16),
              Text(
                'No tienes conexión a internet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Conéctate y vuelve a intentar',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final currentRole = effectiveRoles[_currentIndex];
    if (_pages.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
              const SizedBox(height: 16),
              Text(
                'No tienes permisos asignados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Contacta al administrador del sistema',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_pages.length == 1) {
      return Scaffold(
        body: _pages.first,
      );
    }

    return !isConnected
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Consumer<AuthProvider>(
                builder: (context, value, child) => Text(
                  'Hola ${utf8.decode(latin1.encode(value.user!.name), allowMalformed: true)}',
                  style: const TextStyle(
                      fontFamily: 'noto', fontWeight: FontWeight.bold),
                ),
              ),
              actions: [
                isConnected
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
                      )
              ],
            ),
            body: const PageOffline())
        : Scaffold(
          // appBar: AppBar(
          //   title:  Text(isConnected.toString()),
          // ),
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: FadeTransition(
                opacity: _animationController!,
                child: IndexedStack(
                  index: _currentIndex,
                  children: _pages,
                ),
              ),
            ),
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _colorForRole(currentRole).withOpacity(0.9),
                    _colorForRole(currentRole).withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                items: _items
                    .map((item) => BottomNavigationBarItem(
                          icon: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _currentIndex == _items.indexOf(item)
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.transparent,
                            ),
                            child: item.icon,
                          ),
                          label: item.label,
                          activeIcon: Column(
                            children: [
                              item.icon,
                              const SizedBox(height: 3),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onTap: (i) {
                  _animationController?.reverse().then((_) {
                    setState(() => _currentIndex = i);
                    _animationController?.forward();
                  });
                  // setState(() => _currentIndex = i)
                },
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withOpacity(0.7),
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12,
                unselectedFontSize: 11,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                elevation: 0,
                showUnselectedLabels: true,
              ),
            ),
          );
  }
}
