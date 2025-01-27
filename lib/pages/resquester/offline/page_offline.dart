import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider_off.dart';
import 'package:forzado/pages/resquester/offline/datatable%20_forzados.dart';
import 'package:forzado/pages/resquester/offline/screens/bajas_forzado_offline.dart';
import 'package:forzado/pages/resquester/offline/screens/list_forzados_ejecutado_alta.dart';
import 'package:forzado/pages/resquester/offline/stepper_form.dart';
import 'package:provider/provider.dart';

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
        getData();
      }
    });
  }

  Future<void> getData() async {
    final dropdownProviderOff =
        Provider.of<DropdownProviderManagerOffline>(context, listen: false);
    await dropdownProviderOff.getDataHive();
  }

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
                    'Solicitud de Forzado',
                    style: TextStyle(color: Colors.white),
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
                    'Solicitud de Retiro Forzado',
                    style: TextStyle(color: Colors.white),
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
                    'Solicitudes Pendientes de Sincronización',
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
                    'Solicitudes Retiro Pendientes de Sincronización',
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
