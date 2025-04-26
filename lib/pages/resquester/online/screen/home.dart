import 'package:flutter/material.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/pages/resquester/offline/datatable%20_forzados.dart';
import 'package:forzado/pages/resquester/offline/screens/bajas_forzado_offline.dart';
import 'package:forzado/pages/resquester/online/screen/list_forzados.dart';
import 'package:forzado/pages/resquester/online/screen/list_forzados_flag.dart';
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
        GestureDetector(
          onTap: () {
            final route =
                MaterialPageRoute(builder: (_) =>   StepperForm());
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
                color: const Color.fromARGB(255, 139, 40, 10),
                borderRadius: BorderRadius.circular(10)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_circle_up_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Crear Solicitud de Forzado',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            final route =
                MaterialPageRoute(builder: (_) => const ListForzadosFlag());
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
                color: const Color.fromARGB(255, 129, 196, 155),
                borderRadius: BorderRadius.circular(10)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.format_list_bulleted_sharp,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Ver Solicitudes',
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
                color: const Color.fromARGB(255, 41, 101, 64),
                borderRadius: BorderRadius.circular(10)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_circle_down_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Crear Solicitud de Retiro',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          // height: 40,
          color: const Color(0xff001d39),
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text(
            'Pendientes por sincronizar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Colocar el widget de sincronizacion
        Consumer<AuthProvider>(
          builder: (context, value, child) {
            return value.viewModalSync ? widget! : const SizedBox();
          },
        ),
        GestureDetector(
          onTap: () {
            final route =
                MaterialPageRoute(builder: (_) => const ForzadosDataTable());
            Navigator.push(context, route);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
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
                color: const Color.fromARGB(255, 0, 72, 131),
                borderRadius: BorderRadius.circular(10)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.cloud_upload,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Solicitudes de Forzado Pendientes a Sincronizar',
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
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                    offset: Offset(-2.0, 0),
                  ),
                ],
                color: const Color.fromARGB(255, 203, 97, 5),
                borderRadius: BorderRadius.circular(10)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.cloud_upload,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Solicitudes de Retiro Pendientes a Sincronizar',
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
