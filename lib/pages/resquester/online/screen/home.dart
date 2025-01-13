import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/pages/resquester/offline/datatable%20_forzados.dart';
import 'package:forzado/pages/resquester/offline/screens/bajas_forzado_offline.dart';
import 'package:forzado/pages/resquester/online/screen/list_forzados.dart';
import 'package:forzado/pages/steps_form/step_form.dart';
import 'package:forzado/widgets/cards.dart';
import 'package:provider/provider.dart';

class PageOnline extends StatelessWidget {
  const PageOnline({
    super.key,
    this.widget,
  });

  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(physics: const BouncingScrollPhysics(), children: [
        // Colocar el widget de sincronizacion
        Consumer<AuthProvider>(
          builder: (context, value, child) {
            return value.viewModalSync ? widget! : const SizedBox();
          },
        ),
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
                  'Forzado',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            final route = MaterialPageRoute(
                builder: (_) => const ListForzadosRequesterLow());
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
                  'Retiro Forzado',
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
          color: const Color(0xff001d39),
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text(
            'Acciones hechas sin conexión a internet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
                  'Forzados Forzado (Campo)',
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
        const CardsDashBoard()
      ]),
    );
  }
}
