import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider_off.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/manager.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class SyncData extends StatefulWidget {
  @override
  State<SyncData> createState() => _SyncDataState();
}

class _SyncDataState extends State<SyncData> {
  bool synchronizing = false;

  Future<void> fillAllBoxes() async {
    final dataManager = DataManager();

    // AdapterOne
    await dataManager.fetchAndFillBox<AdapterOne>(
        'TagPrefijo', AppUrl.gettagPrefijo1);
    await dataManager.fetchAndFillBox<AdapterOne>(
        'TagCentro', AppUrl.getTagCentro1);

    // AdapterTwo
    await dataManager.fetchAndFillBox<AdapterTwo>(
        'Disciplina', AppUrl.getTagDisciplina2);
    await dataManager.fetchAndFillBox<AdapterTwo>('Turno', AppUrl.getTurno2);
    await dataManager.fetchAndFillBox<AdapterTwo>('Riesgo', AppUrl.getRiesgoA2);
    await dataManager.fetchAndFillBox<AdapterTwo>(
        'Probabilidad', AppUrl.getProbabilidad2);
    await dataManager.fetchAndFillBox<AdapterTwo>(
        'Impacto', AppUrl.getImpacto2);
    await dataManager.fetchAndFillBox<AdapterTwo>(
        'Tipo', AppUrl.getTipoForzado2);

    // AdapterThree
    await dataManager.fetchAndFillBox<AdapterThree>(
        'Responsable', AppUrl.getResponsable3);
    // await dataManager.fetchAndFillBox<AdapterThree>(
    //     'Solicitante', AppUrl.getSolicitantes3);
    // await dataManager.fetchAndFillBox<AdapterThree>(
    //     'Aprobador', AppUrl.getAprobadores);
    // await dataManager.fetchAndFillBox<AdapterThree>(
    //     'Ejecutor', AppUrl.getEjecutor);
    await getForzados(context);
  }

// Funcion para llenar todos los forzados hive
  Future<void> getForzados(BuildContext context) async {
    CustomModal modal = CustomModal();

    try {
      final res = await ApiClient().get(AppUrl.getListForzados);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final decodedJson = json.decode(res.body);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson['data'] is List) {
          List<dynamic> dataList = decodedJson['data'];
          // await fillAllBoxe();
          List<Forzados> forzadosList = dataList.map((item) {
            return Forzados.fromJson(item);
          }).toList();
          await saveForzadoHive(forzadosList);
        }
      } else {
        modal.showModal(
          context,
          'Error desde el servidor: ${res.statusCode} - ${res.reasonPhrase}',
          Colors.red,
          false,
        );
      }
    } on SocketException {
      modal.showModal(
        context,
        'No hay conexión a internet. Por favor, verifique su conexión.',
        Colors.blue,
        false,
      );
    } on FormatException {
      modal.showModal(
        context,
        'La respuesta del servidor no tiene el formato esperado.',
        Colors.purple,
        false,
      );
    } catch (e) {
      modal.showModal(
        context,
        'Ocurrió un error interno: ${e.toString()}, contacte a soporte.',
        Colors.orange,
        false,
      );
    }
  }

  Future<void> saveForzadoHive(List<Forzados> list) async {
    final forzadosAlta = list.where((forzado) {
      return forzado.estado.toLowerCase() == 'ejecutado-alta';
    }).toList();
    var box = await Hive.openBox<Forzados>('Forzados');
    await box.clear();
    await box.addAll(forzadosAlta);
  }

  // Future<void> fillListByRole(BuildContext context) async {
  //   final boxSolicitante = Hive.isBoxOpen('Solicitante')
  //       ? Hive.box<AdapterThree>('Solicitante')
  //       : await Hive.openBox('Solicitante');

  //   final boxAprobador = Hive.isBoxOpen('Aprobador')
  //       ? Hive.box<AdapterThree>('Aprobador')
  //       : await Hive.openBox('Aprobador');

  //   final boxEjecutor = Hive.isBoxOpen('Ejecutor')
  //       ? Hive.box<AdapterThree>('Ejecutor')
  //       : await Hive.openBox('Ejecutor');

  //   // Limpiar contenido previo de las cajas
  //   await boxSolicitante.clear();
  //   await boxAprobador.clear();
  //   await boxEjecutor.clear();

  //   final dropdownProvider =
  //       Provider.of<DropDownValuesManagerProvider>(context, listen: false);
  // }

  // Future<void> fillTags(BuildContext context) async {
  //   final dropdownProviderOn =
  //       Provider.of<DropDownValuesManagerProvider>(context, listen: false);

  //   await await Hive.box<AdapterTwo>(HiveBoxes.projects).clear();
  //   Hive.box<AdapterTwo>(HiveBoxes.projects).addAll(dropdownProviderOn
  //       .listProjects
  //       .map((tag) => AdapterTwo(id: tag.id, descripcion: tag.descripcion)));

  //   await Hive.box<AdapterOne>(HiveBoxes.tagPrefijo).clear();
  //   await Hive.box<AdapterOne>(HiveBoxes.tagPrefijo).addAll(
  //       dropdownProviderOn.listPrefijos.map((tag) => AdapterOne(
  //           id: tag.id, codigo: tag.codigo, descripcion: tag.descripcion)));

  //   await Hive.box<AdapterOne>(HiveBoxes.tagCentro).clear();
  //   await Hive.box<AdapterOne>(HiveBoxes.tagCentro).addAll(
  //       dropdownProviderOn.listCentros.map((tag) => AdapterOne(
  //           id: tag.id, codigo: tag.codigo, descripcion: tag.descripcion)));

  //   await Hive.box<AdapterTwo>(HiveBoxes.riesgo).clear();
  //   await Hive.box<AdapterTwo>(HiveBoxes.riesgo).addAll(dropdownProviderOn
  //       .listRiesgos
  //       .map((tag) => AdapterTwo(id: tag.id, descripcion: tag.descripcion)));
  //   await Hive.box<AdapterUser>(HiveBoxes.users).clear();
  //   await Hive.box<AdapterUser>(HiveBoxes.users).addAll(dropdownProviderOn.users
  //       .map((tag) => AdapterUser(
  //           id: tag.id,
  //           apeMaterno: tag.apeMaterno,
  //           apePaterno: tag.apeMaterno,
  //           areaDescripcion: tag.areaDescripcion,
  //           areaId: tag.areaId,
  //           correo: tag.correo,
  //           dni: tag.dni,
  //           estado: tag.estado,
  //           nombre: tag.nombre,
  //           puestoDescripcion: tag.puestoDescripcion,
  //           puestoId: tag.puestoId,
  //           rolDescripcion: tag.rolDescripcion,
  //           rolId: tag.rolId,
  //           roles: tag.roles,
  //           usuario: tag.usuario)));

  //   // El segundo modelo
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(29, 0, 30, 57),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xff001d39), width: 2.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.sync,
                color: Color(0xff001d39),
                size: 40.0,
              ),
              const SizedBox(height: 10.0),
              const Text(
                "¡Recuerda Sincronizar!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff001d39),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "Antes de salir de casa para realizar inspecciones con la app móvil, "
                "asegúrate de presionar el botón de sincronizar para mantener toda la información actualizada.",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      synchronizing = true;
                    });
                    try {
                      final providerDropdownOff =
                          Provider.of<DropdownProviderManagerOffline>(context,
                              listen: false);
                      await Future.delayed(const Duration(seconds: 2));
                      await providerDropdownOff.clearAndPopulateBoxes(context);

                      // Mostramos el modal después de completar la sincronización
                      CustomModal().showModal(
                          context, 'Sincronizados', Colors.green, true);
                    } catch (e) {
                      CustomModal().showModal(
                          context, 'Ocurrió un error', Colors.red, false);
                    } finally {
                      setState(() {
                        synchronizing = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffc8a064),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    synchronizing == true
                        ? 'Sincronizando informacion'
                        : "Sincronizar",
                    style: const TextStyle(color: Color(0xff001d39)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: Consumer<AuthProvider>(
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.toggleModalSync();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.primary,
                  ),
                );
              },
            )),
      ],
    );
  }
}
