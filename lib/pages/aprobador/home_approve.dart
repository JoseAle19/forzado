import 'package:flutter/material.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/pages/aprobador/screen/aprove-list.dart';
import 'package:forzado/pages/aprobador/screen/shutdown_forzado.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/widgets/cards.dart';
import 'package:provider/provider.dart';

class HomeApprove extends StatelessWidget {
  const HomeApprove({super.key});

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
          const IconButton(
              onPressed: null, icon: Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () async {
                await PreferencesHelper().clear();

                final route =
                    MaterialPageRoute(builder: (_) => const LoginPage());
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
              icon: Icon(Icons.login_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (_) => const Approveforzado(
                          isAlta: true,
                        ));
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          'Alta de Forzado',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Icon(
                      Icons.done_all,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (_) => const ShutdownForzado(
                          isAlta: false,
                        ));
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.account_balance,
                          color: Colors.white,
                        ),
                        // SvgPicture.asset('assets/svgs/bank.svg'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Baja Forzado',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Icon(
                      Icons.remove_circle,
                      color: Colors.white,
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

            const CardsDashBoard()

            // FutureBuilder<ModelListForzados>(
            //   future: _ListServiceForzados.getDataByEndpoint(
            //       AppUrl.getListForzados),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<ModelListForzados> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (snapshot.hasError) {
            //       String errorMessage;
            //       if (snapshot.error is SocketException) {
            //         errorMessage =
            //             "No hay conexión a Internet. Por favor, verifica tu conexión.";
            //       } else if (snapshot.error is HttpException) {
            //         errorMessage =
            //             "Hubo un problema con el servidor. Intenta nuevamente más tarde.";
            //       } else {
            //         errorMessage = "Ocurrió un error inesperado";
            //       }

            //       return Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const Icon(Icons.error, color: Colors.red, size: 50),
            //           const SizedBox(height: 10),
            //           Text(errorMessage, textAlign: TextAlign.center),
            //           const SizedBox(height: 20),
            //           ElevatedButton(
            //             onPressed: () => _ListServiceForzados.getDataByEndpoint(
            //                 AppUrl.getListForzados),
            //             child: const Text('Reintentar'),
            //           ),
            //         ],
            //       );
            //     } else if (snapshot.hasData) {
            //       ModelListForzados data = snapshot.data!;
            //       return CardsDashBoard(data: data);
            //     } else {
            //       return const Text("No data available");
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
