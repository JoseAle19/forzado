import 'dart:convert'; // For utf8.decode and latin1.encode
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/pages/resquester/offline/page_offline.dart';
import 'package:forzado/pages/profile/profile_page.dart'; // Import the ProfilePage
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

  void veryfyUserLoggedAndConnection(BuildContext c, List<int> roles) {
    final esRequester = roles.contains(1);
    print(roles);
    print('cx');
    setState(() {
      isRequester = esRequester;
    });
  }

  bool isConnected = true; // Initialize as true, update via _verifyConnection

  Future<void> _verifyConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
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
    _verifyConnection(); // Check connection status on init
    // Listen for connectivity changes
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.ethernet) ||
          results.contains(ConnectivityResult.mobile)) {
        setState(() {
          isConnected = true;
        });
      } else {
        setState(() {
          isConnected = false;
        });
      }
    });

    veryfyUserLoggedAndConnection(context, widget.roles);

    final roleMap = <int, MapEntry<String, Widget>>{
      1: const MapEntry('Solicitante', Home()),
      2: const MapEntry('Aprobador', HomeApprove()),
      3: const MapEntry('Ejecutor', HomeExecuter()),
      4: const MapEntry('Aprobador Interlock', HomeApprove()),
      5: const MapEntry('Administrador', Home()),
      // Role 6 (My Profile) is explicitly handled in the AppBar, not BottomNavBar
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
    // Handling no internet connection for non-requester users
    // If the user is NOT a requester AND is NOT connected, show the no internet page.
    if (!isRequester && !isConnected) {
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

    // Handling no permissions assigned
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

    // If there's only one effective role, display that page directly
    // and provide the AppBar from MainHomePage.
    if (_pages.length == 1) {
      return Scaffold(
/*         appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Consumer<AuthProvider>(
            builder: (context, value, child) => Text(
              'Hola ${utf8.decode(latin1.encode(value.user!.name), allowMalformed: true)}',
              style: const TextStyle(
                  fontFamily: 'noto', fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            // Menu button for profile and logout
            _buildProfileMenu(context),
            if (!isConnected &&
                !isRequester) // Show wifi off icon only if not connected AND not requester
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.wifi_off,
                  size: 30,
                  color: Colors.red,
                ),
              ),
          ],
        ), */
        body: _pages.first, // Display the single role page
      );
    }

    // Main Scaffold with BottomNavigationBar for multiple roles
    // and a single AppBar provided by MainHomePage.
    return Scaffold(
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
          // Menu button for profile and logout
          _buildProfileMenu(context),
          if (!isConnected &&
              !isRequester) // Show wifi off icon only if not connected AND not requester
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.wifi_off,
                size: 30,
                color: Colors.red,
              ),
            ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:
            () {}, // Prevents taps from passing through to underlying widgets
        child: FadeTransition(
          opacity: _animationController!,
          child: IndexedStack(
            index: _currentIndex,
            children:
                isConnected || isRequester ? _pages : [const PageOffline()],
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
              _colorForRole(effectiveRoles[_currentIndex]).withOpacity(0.9),
              _colorForRole(effectiveRoles[_currentIndex]).withOpacity(0.7),
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

  Widget _buildProfileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) async {
        if (value == 'profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        } else if (value == 'clear_and_logout') {
          // Show a confirmation dialog before clearing data and logging out
          bool? confirm = await showDialog<bool>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Confirmar Eliminación y Cierre'),
                content: const Text(
                    '¿Estás seguro de que quieres eliminar todos los datos locales y cerrar sesión? Esta acción no se puede deshacer.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(dialogContext)
                          .pop(false); // Dismiss dialog, return false
                    },
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Eliminar y Cerrar'),
                    onPressed: () {
                      Navigator.of(dialogContext)
                          .pop(true); // Dismiss dialog, return true
                    },
                  ),
                ],
              );
            },
          );

          if (confirm == true) {
            await PreferencesHelper().clear();
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            }
          }
        } else if (value == 'logout') {
          // Show a confirmation dialog for regular logout
          bool? confirm = await showDialog<bool>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Confirmar Cierre de Sesión'),
                content:
                    const Text('¿Estás seguro de que quieres cerrar sesión?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(false);
                    },
                  ),
                  FilledButton(
                    child: const Text('Cerrar Sesión'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(true);
                    },
                  ),
                ],
              );
            },
          );

          if (confirm == true) {
            // For a "logout" that doesn't clear all data, you might just clear specific session tokens
            // For now, it behaves like clear_and_logout for simplicity based on your previous code.
            // If you want a softer logout, modify PreferencesHelper().clear() or create a new method for partial clearing.
            await PreferencesHelper()
                .clear(); // Or PreferencesHelper().clearSessionTokens();
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            }
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'profile',
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Ver Mi Perfil'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'clear_and_logout',
          child: ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: Text('Eliminar Datos y Cerrar Sesión',
                style: TextStyle(color: Colors.red)),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
          ),
        ),
      ],
      icon: const Icon(
          Icons.more_vert), // Or Icons.account_circle, Icons.person, etc.
    );
  }
}
