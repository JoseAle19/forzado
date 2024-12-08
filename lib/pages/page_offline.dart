import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forzado/pages/solicitante/offline/datatable%20_forzados.dart';
import 'package:forzado/pages/solicitante/offline/screens/bajas_forzado_offline.dart';
import 'package:forzado/pages/solicitante/offline/screens/list_forzados_ejecutado_alta.dart';
import 'package:forzado/pages/solicitante/offline/stepper_form.dart';

class PageOffline extends StatelessWidget {
  const PageOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (_) => const StepperFormOffline());
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/bank.svg'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Solicitar Forzado',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (_) => const BajasForzadoOffline());
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/bank.svg'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Baja Forzado',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
