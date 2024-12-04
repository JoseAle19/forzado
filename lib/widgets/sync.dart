import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/services/manager.dart';
import 'package:forzado/widgets/modal_error.dart';

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
    await dataManager.fetchAndFillBox<AdapterThree>(
        'Solicitante', AppUrl.getSolicitantes3);
    await dataManager.fetchAndFillBox<AdapterThree>(
        'Aprobador', AppUrl.getAprobadores);
    await dataManager.fetchAndFillBox<AdapterThree>(
        'Ejecutor', AppUrl.getEjecutor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.sync,
            color: Colors.blue,
            size: 40.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            "¡Recuerda Sincronizar!",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
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
                try {
                  setState(() {
                    synchronizing = true;
                  });
                  await fillAllBoxes();
                  setState(() {
                    synchronizing = true;
                  });
                  CustomModal modal = CustomModal();
                  modal.showModal(
                      context, 'Datos sincronizados', Colors.green, true);
                } catch (e) {
                  setState(() {
                    synchronizing = false;
                  });

                  CustomModal modal = CustomModal();
                  modal.showModal(
                      context,
                      'Ocurrio un error al sincronizar, contacta a soporte',
                      Colors.redAccent,
                      false);
                } finally {
                  setState(() {
                    synchronizing = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                synchronizing == true
                    ? 'Sincronizando informacion'
                    : "Sincronizar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}