import 'package:flutter/material.dart';
import 'package:forzado/pages/resquester/offline/datatable%20_forzados.dart';
import 'package:forzado/pages/resquester/offline/screens/bajas_forzado_offline.dart';
import 'package:forzado/pages/resquester/offline/screens/list_forzados_ejecutado_alta.dart';
import 'package:forzado/pages/resquester/offline/stepper_form.dart';

class PageOffline extends StatefulWidget {
  const PageOffline({super.key});

  @override
  State<PageOffline> createState() => _PageOfflineState();
}

class _PageOfflineState extends State<PageOffline> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        // getData();
      }
    });
  }

  // Future<void> getData() async {
  //   final dropdownProviderOff =
  //       Provider.of<DropdownProviderManagerOffline>(context, listen: false);
  //   // await dropdownProviderOff.getDataHive();
  // }

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
                  color: const Color.fromARGB(255, 139, 40, 10),
                  borderRadius: BorderRadius.circular(10)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.arrow_circle_up_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Crear Solicitud de Forzado',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (_) => ListForzadosEjecutadoAlta());
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
                  const Icon(
                    Icons.arrow_circle_down_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Crear Solicitud de Retiro',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
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
                  const Icon(
                    Icons.cloud_upload,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Solicitudes de Forzado Pendientes a Sincronizar',
                    style: const TextStyle(color: Colors.white),
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
        ],
      ),
    );
  }
}
