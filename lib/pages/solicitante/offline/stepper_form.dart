import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/forzado.dart';
import 'package:forzado/core/app_styles.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/pages/steps_form/step_form.dart';
import 'package:forzado/widgets/drop_down_offline/custom_drop_one.dart';
import 'package:forzado/widgets/drop_down_offline/custom_drop_three.dart';
import 'package:forzado/widgets/drop_down_offline/custom_drop_two.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:hive_flutter/adapters.dart';

class StepperFormOffline extends StatefulWidget {
  const StepperFormOffline({super.key});

  @override
  State<StepperFormOffline> createState() => _StepperFormOfflineState();
}

class _StepperFormOfflineState extends State<StepperFormOffline> {
  // first step
  AdapterOne currentValueTagPrefijo =
      AdapterOne(id: 0, codigo: '0', descripcion: '');
  AdapterOne currentValueTagCentro =
      AdapterOne(id: 0, codigo: '0', descripcion: '');
  String currentValueDescription = '';
  AdapterTwo currentValueTagDisciplina = AdapterTwo(id: 1, descripcion: '');
  AdapterTwo currentValueSlot = AdapterTwo(id: 1, descripcion: '');

  // second step
  AdapterTwo currentValueSegurity = AdapterTwo(id: 1, descripcion: '');
  AdapterThree currentValueResponsability = AdapterThree(id: 0, nombre: '');
  AdapterTwo currentValueRisk = AdapterTwo(id: 1, descripcion: '');
  AdapterTwo currentValueProbability = AdapterTwo(id: 1, descripcion: '');
  AdapterTwo currentValueImpact = AdapterTwo(id: 1, descripcion: '');
  String currentValueInterlock = '';
  // third step
  AdapterThree currentValueapplicant = AdapterThree(id: 0, nombre: '');
  AdapterThree currentValueapprover = AdapterThree(id: 0, nombre: '');
  AdapterThree currentValueexecutor = AdapterThree(id: 0, nombre: '');
  AdapterTwo currentValueForzado = AdapterTwo(id: 1, descripcion: '');

  int _currentStep = 0;

// Para resetear todos los vlores

  void reset() {
    setState(() {
      currentValueTagPrefijo = AdapterOne(id: 0, codigo: '0', descripcion: '');
      currentValueTagCentro = AdapterOne(id: 0, codigo: '0', descripcion: '');
      currentValueDescription = '';
      currentValueTagDisciplina = AdapterTwo(id: 1, descripcion: '');
      currentValueSlot = AdapterTwo(id: 1, descripcion: '');
      currentValueSegurity = AdapterTwo(id: 1, descripcion: '');
      currentValueResponsability = AdapterThree(id: 0, nombre: '');
      currentValueRisk = AdapterTwo(id: 1, descripcion: '');
      currentValueProbability = AdapterTwo(id: 1, descripcion: '');
      currentValueImpact = AdapterTwo(id: 1, descripcion: '');
      currentValueInterlock = '';
      currentValueapplicant = AdapterThree(id: 0, nombre: '');
      currentValueapprover = AdapterThree(id: 0, nombre: '');
      currentValueexecutor = AdapterThree(id: 0, nombre: '');
      currentValueForzado = AdapterTwo(id: 1, descripcion: '');
      _currentStep = 0;
    });
  }

// Jose: valor para validar si esta o no haciendo la peticion
  bool isFetching = false;
  void _updateCurrentValue(ValueType valueType, dynamic newValue) {
    setState(() {
      switch (valueType) {
        case ValueType.tagPrefijo:
          currentValueTagPrefijo = newValue;
          break;
        case ValueType.tagCentro:
          currentValueTagCentro = newValue;
          break;
        case ValueType.description:
          currentValueDescription = newValue;
          break;
        case ValueType.tagDisciplina:
          currentValueTagDisciplina = newValue;
          break;
        case ValueType.slot:
          currentValueSlot = newValue;
          break;
        case ValueType.segurity:
          currentValueSegurity = newValue;
          break;
        case ValueType.responsability:
          currentValueResponsability = newValue;
          break;
        case ValueType.risk:
          currentValueRisk = newValue;
          break;
        case ValueType.probability:
          currentValueProbability = newValue;
          break;
        case ValueType.impact:
          currentValueImpact = newValue;
          break;
        case ValueType.applicant:
          currentValueapplicant = newValue;
          break;
        case ValueType.approver:
          currentValueapprover = newValue;
          break;
        case ValueType.executor:
          currentValueexecutor = newValue;
          break;
        case ValueType.forzado:
          currentValueForzado = newValue;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alta de forzando offline'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                controlsBuilder: (context, details) {
                  // Método para validar campos por paso
                  bool isStepValid(int currentStep) {
                    switch (currentStep) {
                      case 0:
                        return [
                          currentValueTagPrefijo.descripcion,
                          currentValueTagCentro.descripcion,
                          currentValueTagDisciplina.descripcion,
                          currentValueSlot.descripcion,
                          currentValueDescription,
                        ].every((field) => field.isNotEmpty);
                      case 1:
                        return [
                          currentValueResponsability.nombre,
                          currentValueRisk.descripcion,
                          currentValueProbability.descripcion,
                          currentValueImpact.descripcion,
                          currentValueInterlock,
                        ].every((field) => field.isNotEmpty);
                      case 2:
                        return [
                          currentValueapplicant.nombre,
                          currentValueapprover.nombre,
                          currentValueexecutor.nombre,
                          currentValueForzado.descripcion,
                        ].every((field) => field.isNotEmpty);
                      default:
                        return false;
                    }
                  }

                  void showErrorModal(BuildContext context, String message) {
                    CustomModal modal = CustomModal();
                    modal.showModal(context, message, Colors.red, false);
                  }

                  bool isFinalStep = details.currentStep == 2;
                  bool validation = isStepValid(details.currentStep);

                  return GestureDetector(
                    onTap: () async {
                      if (validation) {
                        if (isFinalStep) {
                          if (!isStepValid(details.currentStep)) {
                            showErrorModal(
                                context, 'Completa todos los campos');
                            return;
                          }
                          await saveData(
                            currentValueTagPrefijo,
                            currentValueTagCentro,
                            currentValueDescription,
                            currentValueTagDisciplina,
                            currentValueSlot,
                            currentValueSegurity,
                            currentValueResponsability,
                            currentValueRisk,
                            currentValueProbability,
                            currentValueImpact,
                            currentValueapplicant,
                            currentValueapprover,
                            currentValueexecutor,
                            currentValueForzado,
                            currentValueInterlock,
                          );
                        } else {
                          details.onStepContinue!();
                        }
                      } else {
                        showErrorModal(context, 'Completa todos los campos');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: validation
                            ? const Color(0xff009283)
                            : const Color(0xff21378C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          isFinalStep ? 'Finalizar' : 'Continuar',
                          style: AppStyles.textStyle,
                        ),
                      ),
                    ),
                  );
                },
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < 2) {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  }
                },
                steps: [
                  Step(
                    title: _currentStep == 0
                        ? const Text('Tag  y Subfijo')
                        : const SizedBox(),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomDropDownButtonOneOff(
                            box: HiveBoxes.tagPrefijo,
                            descriptionField: 'Tag (Prefijo) * ',
                            hintText: 'Prefijo del Tag o Sub Área',
                            currentValue: currentValueTagPrefijo,
                            onChanged: (value) => _updateCurrentValue(
                                ValueType.tagPrefijo, value),
                          ),
                          CustomDropDownButtonOneOff(
                            box: HiveBoxes.tagCentro,
                            descriptionField: 'Tag (Centro) *',
                            hintText:
                                'Parte Central  del Tag Asoc. al instrumento o Equipo',
                            currentValue: currentValueTagCentro,
                            onChanged: (value) =>
                                _updateCurrentValue(ValueType.tagCentro, value),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Descripción *'),
                                TextFormField(
                                  initialValue: currentValueDescription,
                                  onChanged: (value) {
                                    setState(() {
                                      currentValueDescription = value;
                                    });
                                  },
                                  maxLength: 100,
                                  maxLines: 2,
                                  decoration: const InputDecoration(
                                      hintText: 'Agregue una descripción'),
                                )
                              ],
                            ),
                          ),
                          CustomDropDownButtonTwoOff(
                            box: HiveBoxes.disciplina,
                            descriptionField: 'Disciplina *',
                            hintText: 'Disciplina que solicita el Forzado',
                            currentValue: currentValueTagDisciplina,
                            onChanged: (value) => _updateCurrentValue(
                                ValueType.tagDisciplina, value),
                          ),
                          CustomDropDownButtonTwoOff(
                            box: HiveBoxes.turno,
                            descriptionField: 'Turno *',
                            hintText: 'Disciplina que solicita el Forzado',
                            currentValue: currentValueSlot,
                            onChanged: (value) =>
                                _updateCurrentValue(ValueType.slot, value),
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const SizedBox(),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Iterlock Seguridad *'),
                                    DropdownButtonFormField(
                                      value: currentValueInterlock.isEmpty
                                          ? null
                                          : currentValueInterlock,
                                      hint: const Text('Seleccione Interlock'),
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'si', child: Text('Si')),
                                        DropdownMenuItem(
                                            value: 'NO', child: Text('No')),
                                      ],
                                      validator: (value) => value == null
                                          ? 'Seleccione una opción válida'
                                          : null,
                                      onChanged: (value) {
                                        setState(() {
                                          currentValueInterlock = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                CustomDropDownButtonThreeOff(
                                  box: HiveBoxes.responsable,
                                  descriptionField: 'Responsable *',
                                  hintText:
                                      'Seleccione Gerencia Responsable del Forzado',
                                  currentValue: currentValueResponsability,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.responsability, value),
                                ),
                                CustomDropDownButtonTwoOff(
                                  box: HiveBoxes.riesgo,
                                  descriptionField: 'Riesgo A * ',
                                  hintText: 'Riesgo',
                                  currentValue: currentValueRisk,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.risk, value),
                                ),
                                CustomDropDownButtonTwoOff(
                                  box: HiveBoxes.probabilidad,
                                  descriptionField: 'Probabilidad *',
                                  hintText: 'Categoria de Consecuencias',
                                  currentValue: currentValueProbability,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.probability, value),
                                ),
                                CustomDropDownButtonTwoOff(
                                  box: HiveBoxes.impacto,
                                  descriptionField: 'Impacto * *',
                                  hintText:
                                      'Seleccione Impacto de la Consecuencia',
                                  currentValue: currentValueImpact,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.impact, value),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const SizedBox(),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                CustomDropDownButtonThreeOff(
                                  box: HiveBoxes.solicitante,
                                  descriptionField: 'Solicitante (AN) *',
                                  hintText:
                                      'Seleccione Solicitante del Forzado',
                                  currentValue: currentValueapplicant,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.applicant, value),
                                ),
                                CustomDropDownButtonThreeOff(
                                  box: HiveBoxes.aprobador,
                                  descriptionField: 'Aprobador *',
                                  hintText: 'Seleccione Aprobador del Forzado',
                                  currentValue: currentValueapprover,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.approver, value),
                                ),
                                CustomDropDownButtonThreeOff(
                                  box: HiveBoxes.ejecutor,
                                  descriptionField: 'Ejecutor *',
                                  hintText: 'Seleccione Ejecutor',
                                  currentValue: currentValueexecutor,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.executor, value),
                                ),
                                CustomDropDownButtonTwoOff(
                                  box: HiveBoxes.tipo,
                                  descriptionField: 'Tipo de Forzado',
                                  hintText: 'Seleccione Tipo de Forzado',
                                  currentValue: currentValueForzado,
                                  onChanged: (value) => _updateCurrentValue(
                                      ValueType.forzado, value),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 2,
                    state: StepState.indexed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveData(
    AdapterOne prefijo,
    AdapterOne centro,
    String descripcion,
    AdapterTwo disciplina,
    AdapterTwo turno,
    AdapterTwo seguridad,
    AdapterThree responsable,
    AdapterTwo riesgo,
    AdapterTwo probabilidad,
    AdapterTwo impacto,
    AdapterThree solicitante,
    AdapterThree aprobador,
    AdapterThree ejecutor,
    AdapterTwo forzado,
    String interlock,
  ) async {
    late Box<Forzado> box;
    try {
      // Abrir la caja
      box = await Hive.openBox<Forzado>('forzado');
      final data = Forzado(
          tagPrefijo: prefijo.id.toString(),
          tagCentro: centro.id.toString(),
          descripcion: descripcion,
          disciplina: disciplina.id.toString(),
          turno: turno.id.toString(),
          iterlockSeguridad: seguridad.id.toString(),
          responsable: responsable.id.toString(),
          riesgo: riesgo.id.toString(),
          riesgoA: riesgo.id.toString(),
          probabilidad: probabilidad.id.toString(),
          impacto: impacto.id.toString(),
          solicitante: solicitante.id.toString(),
          aprobador: aprobador.id.toString(),
          ejecutor: ejecutor.id.toString(),
          autorizacion: '1',
          tipoDeForzado: forzado.id.toString(),
          interlock: interlock,
          tagPrefijoDescription: prefijo.descripcion,
          tagCentroDescription: prefijo.descripcion,
          descripcionDescription: descripcion,
          disciplinaDescription: disciplina.descripcion,
          turnoDescription: turno.descripcion,
          iterlockSeguridadDescription: interlock,
          responsableDescription: responsable.nombre,
          riesgoADescription: riesgo.descripcion,
          probabilidadDescription: probabilidad.descripcion,
          impactoDescription: impacto.descripcion,
          riesgoDescription: riesgo.descripcion,
          solicitanteDescription: solicitante.nombre,
          aprobadorDescription: aprobador.nombre,
          ejecutorDescription: ejecutor.nombre,
          autorizacionDescription: 'Hardcodeado',
          tipoDeForzadoDescription: forzado.descripcion,
          interlockDescription: interlock,
          status: 'pendiente-alta');
      // Guardar los datos en la caja
      await box.add(data);
      reset();
      CustomModal modal = CustomModal();
      modal.showModal(context, 'Forzado agregado', Colors.blue, true);
    } catch (e) {
      print('Error abriendo caja: $e');
      return;
    } finally {
      // Cerrar la caja
      await box.close();
    }
  }
}
