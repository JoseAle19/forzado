import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/provider/auth_provider.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/login_page.dart';
import 'package:forzado/pages/page_offline.dart';
import 'package:forzado/pages/solicitante/offline/datatable%20_forzados.dart';
import 'package:forzado/pages/solicitante/offline/screens/bajas_forzado_offline.dart';
import 'package:forzado/pages/solicitante/online/screen/home_page.dart';
import 'package:forzado/pages/steps_form/step_form.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';
import 'package:forzado/widgets/cards.dart';
import 'package:forzado/widgets/sync.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isConnected = false;
  PageController _controller = PageController();
  String user = '';
  @override
  void initState() {
    getData();
    _iniciarVerificacion();
    super.initState();
  }

  void _iniciarVerificacion() async {
    await verifyConnection();
    print(isConnected);
    _controller.jumpToPage(isConnected ? 0 : 1);
  }

  Future<void> verifyConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    setState(() {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    });
  }

  void disposePageController() {
    _controller.dispose();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('username') ?? 'usuario';
    });
  }

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
            isConnected
                ? IconButton(
                    onPressed: () async {
                      await PreferencesHelper().clear();
                      final route =
                          MaterialPageRoute(builder: (_) => const LoginPage());
                      Navigator.push(context, route);
                    },
                    icon: const Icon(Icons.login_rounded))
                : const SizedBox(),
            isConnected
                ? const SizedBox()
                : const Icon(
                    Icons.wifi_off,
                    size: 30,
                    color: Colors.red,
                  ),
          ],
        ),
        body: PageView(
            // physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              PageOnline(
                widget: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SyncData()),
              ),
              const PageOffline(),
            ]));
  }
}

class PageOnline extends StatelessWidget {
  const PageOnline({
    super.key,
    this.widget,
  });

  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    final ListServiceForzados _ListServiceForzados =
        ListServiceForzados(ApiClient());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(physics: const BouncingScrollPhysics(), children: [
        widget ?? const SizedBox(),
        GestureDetector(
          onTap: () {
            final route =
                MaterialPageRoute(builder: (_) => const StepperForm());
            Navigator.push(context, route);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                    offset: Offset(-2.0, 0),
                  ),
                ],
                color: const Color(0xff639777),
                borderRadius: BorderRadius.circular(10)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_balance,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Alta Forzado',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            final route =
                MaterialPageRoute(builder: (_) => const HomePageRemove());
            Navigator.push(context, route);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                    offset: Offset(-2.0, 0),
                  ),
                ],
                color: const Color(0xff8B280A),
                borderRadius: BorderRadius.circular(10)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_balance,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Baja Forzado',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          color: const Color(0xffD9D9D9),
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text(
            'Acciones hechas sin conexión a internet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        GestureDetector(
          onTap: () {
            final route =
                MaterialPageRoute(builder: (_) => const ForzadosDataTable());
            Navigator.push(context, route);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2.0,
                blurRadius: 5.0,
                offset: Offset(-2.0, 0),
              ),
            ], color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/svgs/bank.svg'),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Altas Forzado (Campo)',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            final route =
                MaterialPageRoute(builder: (_) => const BajasForzadoOffline());
            Navigator.push(context, route);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2.0,
                blurRadius: 5.0,
                offset: Offset(-2.0, 0),
              ),
            ], color: Colors.orange, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/svgs/bank.svg'),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Bajas Forzado (Campo)',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 40),
          height: 20,
          color: const Color(0xffD9D9D9),
          width: double.infinity,
        ),
        FutureBuilder<ModelListForzados>(
          future:
              _ListServiceForzados.getDataByEndpoint(AppUrl.getListForzados),
          builder: (BuildContext context,
              AsyncSnapshot<ModelListForzados> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              String errorMessage;
              if (snapshot.error is SocketException) {
                errorMessage =
                    "No hay conexión a Internet. Por favor, verifica tu conexión.";
              } else if (snapshot.error is HttpException) {
                errorMessage =
                    "Hubo un problema con el servidor. Intenta nuevamente más tarde.";
              } else {
                errorMessage = "Ocurrió un error inesperado";
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text(errorMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _ListServiceForzados.getDataByEndpoint(
                        AppUrl.getListForzados),
                    child: const Text('Reintentar'),
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              ModelListForzados data = snapshot.data!;
              return CardsDashBoard(data: data);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ]),
    );
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
