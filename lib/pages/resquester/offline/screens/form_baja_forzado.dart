import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/forzado_baja.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/pages/resquester/offline/screens/list_forzados_ejecutado_alta.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/pages/steps_form/step_form.dart';
import 'package:forzado/widgets/drop_down_offline/custom_drop_three.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:hive_flutter/adapters.dart';

class FormBajaForzado extends StatefulWidget {
  const FormBajaForzado({super.key, required this.detailForzado});
  final Forzados detailForzado;

  @override
  State<FormBajaForzado> createState() => _FormBajaForzadoState();
}

class _FormBajaForzadoState extends State<FormBajaForzado> {
  String currentValueDescription = "";

  AdapterThree currentValueapplicant = AdapterThree(id: 0, nombre: '');
  AdapterThree currentValueapprover = AdapterThree(id: 0, nombre: '');
  AdapterThree currentValueexecutor = AdapterThree(id: 0, nombre: '');

  void _updateCurrentValue(ValueType valueType, dynamic newValue) {
    setState(() {
      switch (valueType) {
        case ValueType.applicant:
          currentValueapplicant = newValue;
          break;
        case ValueType.approver:
          currentValueapprover = newValue;
          break;
        case ValueType.executor:
          currentValueexecutor = newValue;
          break;
        case ValueType.description:
          currentValueDescription = newValue;
          break;
        default:
      }
    });
  }

  Future<void> saveForzadoHive(List<Forzados> list) async {
    var box = await Hive.openBox<Forzados>('Forzados');
    if (list.isEmpty) {
      print('La lista esta vacia');
      await box.clear();
      return;
    }
    await box.clear();
    await box.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Id Forzado: ${widget.detailForzado.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDropDownButtonThreeOff(
                box: HiveBoxes.solicitante,
                descriptionField: 'Solicitante (AN) *',
                hintText: 'Seleccione Solicitante del Forzado',
                currentValue: currentValueapplicant,
                onChanged: (value) =>
                    _updateCurrentValue(ValueType.applicant, value),
              ),
              CustomDropDownButtonThreeOff(
                box: HiveBoxes.aprobador,
                descriptionField: 'Aprobador *',
                hintText: 'Seleccione Aprobador del Forzado',
                currentValue: currentValueapprover,
                onChanged: (value) =>
                    _updateCurrentValue(ValueType.approver, value),
              ),
              CustomDropDownButtonThreeOff(
                box: HiveBoxes.ejecutor,
                descriptionField: 'Ejecutor *',
                hintText: 'Seleccione Ejecutor',
                currentValue: currentValueexecutor,
                onChanged: (value) =>
                    _updateCurrentValue(ValueType.executor, value),
              ),
              const SizedBox(height: 20),
              const Text(
                'Observaciones',
                style: TextStyle(fontFamily: 'Hoto Sans'),
              ),
              TextFormField(
                initialValue: currentValueDescription,
                onChanged: (value) =>
                    _updateCurrentValue(ValueType.description, value),
                maxLength: 100,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Agregue una descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final box = Hive.box<ForzadoBaja>('forzadoBajaBox');
                  var boxForzadosEjecutados =
                      await Hive.openBox<Forzados>('Forzados');
                  if (currentValueDescription.isEmpty ||
                      currentValueapplicant.nombre.isEmpty ||
                      currentValueapprover.nombre.isEmpty ||
                      currentValueexecutor.nombre.isEmpty) {
                    CustomModal modal = CustomModal();
                    modal.showModal(context, 'Completa todos los campos',
                        Colors.red, false);
                    return;
                  }
                  final newForzadoBaja = ForzadoBaja(
                    id: 1,
                    descripcion: currentValueDescription,
                    idApplicant: currentValueapplicant.id,
                    descripcionApplicant: currentValueapplicant.nombre,
                    idApprover: currentValueapprover.id,
                    descripcionApprover: currentValueapprover.nombre,
                    idExecutor: currentValueexecutor.id,
                    descripcionExecutor: currentValueexecutor.nombre,
                    id_forzado: widget.detailForzado.id,
                  );

                  final forzadosUpdate =
                      boxForzadosEjecutados.values.where((forzado) {
                    return forzado.id != widget.detailForzado.id;
                  }).toList();
                  saveForzadoHive(forzadosUpdate);
                  await box.add(newForzadoBaja);
                  final newRoute = MaterialPageRoute(
                      builder: (context) => CongratulationAnimation(
                          page: const ListForzadosEjecutadoAlta()));
                  Navigator.pushReplacement(context, newRoute);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Center(
                    child: Text(
                      'Finalizar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
