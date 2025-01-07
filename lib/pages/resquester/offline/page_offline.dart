import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/user_adapter.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/pages/resquester/offline/datatable%20_forzados.dart';
import 'package:forzado/pages/resquester/offline/screens/bajas_forzado_offline.dart';
import 'package:forzado/pages/resquester/offline/screens/list_forzados_ejecutado_alta.dart';
import 'package:forzado/pages/resquester/offline/stepper_form.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/models/user/model_user.dart' as modeluser;

class PageOffline extends StatefulWidget {
  const PageOffline({super.key});

  @override
  State<PageOffline> createState() => _PageOfflineState();
}

class _PageOfflineState extends State<PageOffline> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dropdownProviderOff =
          Provider.of<DropdownProviderManagerOffline>(context, listen: false);

      dropdownProviderOff.listPrefijos =
          Hive.box<AdapterOne>(HiveBoxes.tagPrefijo)
              .values
              .map((adapter) => modelone.Value(
                  id: adapter.id,
                  codigo: adapter.codigo,
                  descripcion: adapter.descripcion))
              .toList();
      dropdownProviderOff.listCentros =
          Hive.box<AdapterOne>(HiveBoxes.tagCentro)
              .values
              .map((adapter) => modelone.Value(
                  id: adapter.id,
                  codigo: adapter.codigo,
                  descripcion: adapter.descripcion))
              .toList();
      // Los del modelo 2
      dropdownProviderOff.listDiciplinas = Hive.box<AdapterTwo>(
              HiveBoxes.disciplina)
          .values
          .map((adapter) =>
              modelTwo.Value(id: adapter.id, descripcion: adapter.descripcion))
          .toList();
      dropdownProviderOff.listProjects = Hive.box<AdapterTwo>(
              HiveBoxes.projects)
          .values
          .map((adapter) =>
              modelTwo.Value(id: adapter.id, descripcion: adapter.descripcion))
          .toList();
      dropdownProviderOff.listTurnos = Hive.box<AdapterTwo>(HiveBoxes.turno)
          .values
          .map((adapter) =>
              modelTwo.Value(id: adapter.id, descripcion: adapter.descripcion))
          .toList();
      dropdownProviderOff.listResponsables =
          Hive.box<AdapterThree>(HiveBoxes.responsable)
              .values
              .map((adapter) => modelThree.Value(
                  id: adapter.id, nombre: adapter.nombre, apePaterno: ''))
              .toList();

      dropdownProviderOff.listRiesgos = Hive.box<AdapterTwo>(HiveBoxes.riesgo)
          .values
          .map((adapter) =>
              modelTwo.Value(id: adapter.id, descripcion: adapter.descripcion))
          .toList();
      dropdownProviderOff.listProbabilidades = Hive.box<AdapterTwo>(
              HiveBoxes.probabilidad)
          .values
          .map((adapter) =>
              modelTwo.Value(id: adapter.id, descripcion: adapter.descripcion))
          .toList();
      dropdownProviderOff.listImpactos = Hive.box<AdapterTwo>(HiveBoxes.impacto)
          .values
          .map((adapter) =>
              modelTwo.Value(id: adapter.id, descripcion: adapter.descripcion))
          .toList();

      dropdownProviderOff.listAprobadores =
          Hive.box<AdapterThree>(HiveBoxes.aprobador)
              .values
              .map((adapter) => modelThree.Value(
                  id: adapter.id, nombre: adapter.nombre, apePaterno: ''))
              .toList();
      dropdownProviderOff.listSolicitantes =
          Hive.box<AdapterThree>(HiveBoxes.solicitante)
              .values
              .map((adapter) => modelThree.Value(
                  id: adapter.id, nombre: adapter.nombre, apePaterno: ''))
              .toList();
      dropdownProviderOff.listEjecutores =
          Hive.box<AdapterThree>(HiveBoxes.ejecutor)
              .values
              .map((adapter) => modelThree.Value(
                  id: adapter.id, nombre: adapter.nombre, apePaterno: ''))
              .toList();

      dropdownProviderOff.listTipoDeForzados = Hive.box<AdapterTwo>(
              HiveBoxes.tipo)
          .values
          .map((adapter) =>
              modelTwo.Value(id: adapter.id, descripcion: adapter.descripcion))
          .toList();

      dropdownProviderOff.users = Hive.box<AdapterUser>(HiveBoxes.users)
          .values
          .map((adapter) => modeluser.Value(
              id: adapter.id,
              apeMaterno: adapter.apeMaterno,
              apePaterno: adapter.apeMaterno,
              areaDescripcion: adapter.areaDescripcion,
              areaId: adapter.areaId,
              correo: adapter.correo,
              dni: adapter.dni,
              estado: adapter.estado,
              nombre: adapter.nombre,
              puestoDescripcion: adapter.puestoDescripcion,
              puestoId: adapter.puestoId,
              rolDescripcion: adapter.rolDescripcion,
              rolId: adapter.rolId,
              roles: adapter.roles,
              usuario: adapter.usuario))
          .toList();
    });
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
                    'Baja Forzado',
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
                    'Altas Forzado (Campo)',
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
                    'Bajas Forzado (Campo)',
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
