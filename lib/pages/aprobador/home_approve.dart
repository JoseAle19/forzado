import 'package:flutter/material.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/pages/aprobador/screen/list_approve.dart';
import 'package:forzado/pages/auth/login_page.dart';
import 'package:forzado/widgets/cards.dart';
import 'package:provider/provider.dart';

class HomeApprove extends StatelessWidget {
  const HomeApprove({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*       appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<AuthProvider>(
          builder: (context, value, child) => Text(
            'Hola ${value.user?.name}',
            style: const TextStyle(
                fontFamily: 'noto', fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await PreferencesHelper().clear();

                final route =
                    MaterialPageRoute(builder: (_) => const LoginPage());
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
              icon: const Icon(Icons.login_rounded))
        ],
      ), */
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (_) => const ListForzadosAppro(
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
                    color: const Color.fromARGB(255, 139, 40, 9),
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
                          'Aprobar Solicitud Forzado',
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
                    builder: (_) => const ListForzadosAppro(
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
                    color: const Color.fromARGB(255, 41, 101, 65),
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
                          'Aprobar Solicitud Retiro',
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
          ],
        ),
      ),
    );
  }
}
