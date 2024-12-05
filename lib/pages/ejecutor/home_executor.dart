import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/ejecutor/forzados_executer.dart';
import 'package:forzado/pages/home_page.dart';
import 'package:forzado/pages/login_page.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';
import 'package:forzado/widgets/cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeExecuter extends StatelessWidget {
  const HomeExecuter({super.key});

  @override
  Widget build(BuildContext context) {
    final ListServiceForzados _ListServiceForzados =
        ListServiceForzados(ApiClient());

    return Scaffold(
      bottomNavigationBar: const CustomBotttomNavigation(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Hola aprobador',
          style: TextStyle(fontFamily: 'noto', fontWeight: FontWeight.bold),
        ),
        actions: [
          const IconButton(
              onPressed: null, icon: Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('logged');
                final route =
                    MaterialPageRoute(builder: (_) => const LoginPage());
                Navigator.push(context, route);
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
                    builder: (_) => const ListExecuterForzado(
                          isExecuterAlta: true,
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
                      Icons.play_circle_filled,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (_) => const ListExecuterForzado(
                          isExecuterAlta: false,
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
                      Icons.play_circle_filled,
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
            FutureBuilder<ModelListForzados>(
              future: _ListServiceForzados.getDataByEndpoint(
                  AppUrl.getListForzados),
              builder: (BuildContext context,
                  AsyncSnapshot<ModelListForzados> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                ModelListForzados data = snapshot.data!;
                return CardsDashBoard(data: data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
