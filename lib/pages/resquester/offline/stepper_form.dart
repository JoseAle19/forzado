import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/forzado.dart';
import 'package:forzado/core/app_styles.dart';
import 'package:forzado/data/providers/Stepper/stepper_provider.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider_off.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class StepperFormOffline extends StatefulWidget {
  const StepperFormOffline({super.key});

  @override
  State<StepperFormOffline> createState() => _StepperFormOfflineState();
}

class _StepperFormOfflineState extends State<StepperFormOffline> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        final dropdownProvider =
            Provider.of<DropdownProviderManagerOffline>(context, listen: false);

        dropdownProvider.clearValues();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final forzadosProvider = Provider.of<ForzadosProvider>(context);
    final dropdownProvider =
        Provider.of<DropdownProviderManagerOffline>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creación solicitud de forzado'),
      ),
      body: Column(
        children: [
          Expanded(child: Consumer<StepperProvider>(
            builder: (context, value, child) {
              return Stepper(
                stepIconHeight: 30,
                stepIconWidth: 30,
                stepIconBuilder: (stepIndex, stepState) =>
                    _stepperIcons(stepIndex, stepState), // Iconos de los steps
                controlsBuilder: (context, details) {
                  bool validation = details.currentStep != 2 ? true : false;
                  return Row(
                    children: [
                      Container(
                        width: 70,
                        child: GestureDetector(
                          onTap: () => details.onStepCancel!(),
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            // Validar Dropdown
                            if (details.currentStep == 0
                                ? forzadosProvider
                                    .validateStepFormOneOff(dropdownProvider)
                                : details.currentStep == 1
                                    ? forzadosProvider.validateStepFormTwoOff(
                                        dropdownProvider)
                                    : forzadosProvider.validateStepFormThreeOff(
                                        dropdownProvider)) {
                              if (validation) {
                                details.onStepContinue!();
                              } else {
                                final res =
                                    await forzadosProvider.sendRequestPostOff(
                                        context, dropdownProvider);
                                if (!res) {
                                  CustomModal().showModal(
                                      context,
                                      forzadosProvider.errorMessagePostData,
                                      Colors.red,
                                      false);
                                } else {
                                  final route = MaterialPageRoute(
                                      builder: (_) => CongratulationAnimation(
                                            page: const StepperFormOffline(),
                                          ));
                                  Navigator.pushReplacement(context, route);
                                  dropdownProvider.clearValues();
                                  value.setCurrentStepOff(0);
                                }
                              }
                            } else {
                              CustomModal modal = CustomModal();
                              modal.showModal(
                                  context,
                                  'Completa todos los campos',
                                  Colors.redAccent,
                                  false);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                                color: validation
                                    ? const Color(0xff3b82f6)
                                    : const Color(0xff3b82f6),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                                child: Text(
                              validation ? 'Continuar' : 'Rezalizar Solicitud',
                              style: AppStyles.textStyle,
                            )),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                steps: [
                  Step(
                      isActive: value.currentStepOff == 0,
                      title: const Text(''),
                      content: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .6,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            CustomDropdownButton<modelTwo.Value>(
                              hintText: 'Área de Forzado *:',
                              items: dropdownProvider.listProjects,
                              selectedItem:
                                  dropdownProvider.currentStateProjectName,
                              onChanged: (value) {
                                dropdownProvider.currentStateProjectName =
                                    value!;
                              },
                            ),
                            CustomDropdownButton<modelone.Value>(
                              hintText: 'Sub Área (Tag Prefijo) *:',
                              items: dropdownProvider.listPrefijos,
                              selectedItem:
                                  dropdownProvider.currentValueTagPrefijo,
                              onChanged: (value) {
                                dropdownProvider.currentValueTagPrefijo =
                                    value!;
                              },
                            ),
                            CustomDropdownButton<modelone.Value>(
                              hintText: 'Activo (Tag Centro) *:',
                              items: dropdownProvider.listCentros,
                              selectedItem:
                                  dropdownProvider.currentValueTagCentro,
                              onChanged: (value) {
                                dropdownProvider.currentValueTagCentro = value!;
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Tag (Sufijo) *'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    initialValue:
                                        dropdownProvider.currentValueSubfijo,
                                    onChanged: (value) => dropdownProvider
                                        .currentValueSubfijo = value,
                                    maxLength: 100,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      hintText: 'Ingrese el subfijo del tag',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade50),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Descripción *'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    initialValue: dropdownProvider
                                        .currentValueDescription,
                                    onChanged: (value) => dropdownProvider
                                        .currentValueDescription = value,
                                    maxLength: 100,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      hintText: 'Agregue una descripción',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade50),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            CustomDropdownButton<modelTwo.Value>(
                              hintText: 'Disciplina *:',
                              items: dropdownProvider.listDiciplinas,
                              selectedItem:
                                  dropdownProvider.currentValueTagDisciplina,
                              onChanged: (value) {
                                dropdownProvider.currentValueTagDisciplina =
                                    value!;
                              },
                            ),
                            CustomDropdownButton<modelTwo.Value>(
                              hintText: 'Turno *:',
                              items: dropdownProvider.listTurnos,
                              selectedItem: dropdownProvider.currentValueSlot,
                              onChanged: (value) {
                                dropdownProvider.currentValueSlot = value!;
                              },
                            ),
                          ],
                        ),
                      )),
                  Step(
                      isActive: value.currentStep == 1,
                      title: const Text(''),
                      content: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .6,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('¿Es Interlock? *'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DropdownButtonFormField(
                                    value: dropdownProvider
                                            .currentValueInterlock.isEmpty
                                        ? null
                                        : dropdownProvider
                                            .currentValueInterlock,
                                    hint: const Text('Seleccione Interlock'),
                                    items: const [
                                      DropdownMenuItem(
                                          value: 'si', child: Text('Si')),
                                      DropdownMenuItem(
                                          value: 'NO', child: Text('No')),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Seleccione una opcion';
                                      }
                                      return '';
                                    },
                                    onChanged: (value) {
                                      dropdownProvider.currentValueInterlock =
                                          value.toString();
                                      // dropdownProvider.validateInterlok();
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade50),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomDropdownButton<modelThree.Value>(
                              hintText: 'Responsable *:',
                              items: dropdownProvider.listResponsables,
                              selectedItem:
                                  dropdownProvider.currentStateResponsibility,
                              onChanged: (value) {
                                dropdownProvider.currentStateResponsibility =
                                    value!;
                              },
                            ),
                            CustomDropdownButton<modelTwo.Value>(
                              hintText: 'Riesgo a *:',
                              items: dropdownProvider.listRiesgos,
                              selectedItem: dropdownProvider.currentStateRisk,
                              onChanged: (value) {
                                dropdownProvider.currentStateRisk = value!;
                                // dropdownProvider.defineInterlockbyRiskA();
                              },
                            ),
                            Stack(
                              children: [
                                CustomDropdownButton<modelTwo.Value>(
                                  hintText: 'Probabilidad *:',
                                  items: dropdownProvider.listProbabilidades,
                                  selectedItem:
                                      dropdownProvider.currentStateProbability,
                                  onChanged: (value) {
                                    if (dropdownProvider
                                        .isEnabledRuletagMatriz) {
                                      print('no editable');
                                      return;
                                    }

                                    dropdownProvider.currentStateProbability =
                                        value!;
                                    dropdownProvider.defineRisk();
                                  },
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    bottom: 0,
                                    left: 0,
                                    child:
                                        dropdownProvider.isEnabledRuletagMatriz
                                            ? Container(
                                                color: Colors.transparent,
                                              )
                                            : SizedBox())
                              ],
                            ),
                            Stack(
                              children: [
                                CustomDropdownButton<modelTwo.Value>(
                                  hintText: 'Impacto *:',
                                  items: dropdownProvider.listImpactos,
                                  selectedItem:
                                      dropdownProvider.currentStateImpact,
                                  onChanged: (value) {
                                    dropdownProvider.currentStateImpact =
                                        value!;
                                    dropdownProvider.defineRisk();
                                  },
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    bottom: 0,
                                    left: 0,
                                    child:
                                        dropdownProvider.isEnabledRuletagMatriz
                                            ? Container(
                                                color: Colors.transparent,
                                              )
                                            : const SizedBox())
                              ],
                            ),
                            Stack(
                              children: [
                                CustomDropdownButton<modelTwo.Value>(
                                  hintText: 'Riesgo *:',
                                  items: dropdownProvider.riskLevels,
                                  selectedItem: dropdownProvider.currentRisk,
                                  onChanged: (value) {
                                    dropdownProvider.currentStateRisk = value!;
                                  },
                                  backgroundColor: dropdownProvider
                                              .currentRisk?.descripcion
                                              .toLowerCase() ==
                                          'bajo'
                                      ? Color(0xffBBF7D0)
                                      : dropdownProvider
                                                  .currentRisk?.descripcion
                                                  .toLowerCase() ==
                                              'moderado'
                                          ? Color(0xffFEF08A)
                                          : dropdownProvider
                                                      .currentRisk?.descripcion
                                                      .toLowerCase() ==
                                                  'alto'
                                              ? Color(0xffEF4444)
                                              : Colors.transparent,
                                  textColor: dropdownProvider
                                              .currentRisk?.descripcion
                                              .toLowerCase() ==
                                          'alto'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      color: Colors.transparent,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )),
                  Step(
                    isActive: value.currentStep == 2,
                    title: const Text(''),
                    content: SizedBox(
                      width: double.infinity,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          CustomDropdownButton<modelThree.Value>(
                            hintText: 'Solicitante (AN) *:',
                            items: dropdownProvider.listSolicitantes,
                            selectedItem:
                                dropdownProvider.currentStateApplicant,
                            onChanged: (value) {
                              dropdownProvider.currentStateApplicant = value!;
                            },
                          ),
                          CustomDropdownButton<modelThree.Value>(
                            hintText: 'Aprobador *:',
                            items: dropdownProvider.listAprobadores,
                            selectedItem: dropdownProvider.currentStateApprover,
                            onChanged: (value) {
                              dropdownProvider.currentStateApprover = value!;
                            },
                          ),
                          CustomDropdownButton<modelThree.Value>(
                            hintText: 'Ejecutor *:',
                            items: dropdownProvider.listEjecutores,
                            selectedItem: dropdownProvider.currentStateExecutor,
                            onChanged: (value) {
                              dropdownProvider.currentStateExecutor = value!;
                            },
                          ),
                          CustomDropdownButton<modelTwo.Value>(
                            hintText: 'Tipo de Forzado *:',
                            items: dropdownProvider.listTipoDeForzados,
                            selectedItem:
                                dropdownProvider.currentStateTypeForzado,
                            onChanged: (value) {
                              dropdownProvider.currentStateTypeForzado = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                onStepContinue: () {
                  if (value.currentStepOff != 2) {
                    value.setCurrentStepOff(value.currentStepOff + 1);
                  }
                },
                onStepCancel: () {
                  if (value.currentStepOff != 0) {
                    value.setCurrentStepOff(value.currentStepOff - 1);
                  }
                },
                onStepTapped: (stepValue) {
                  value.setCurrentStepOff(stepValue);
                },
                type: StepperType.horizontal,
                currentStep: value.currentStepOff,
              );
            },
          )),
        ],
      ),
    );
  }

  Widget _stepperIcons(stepIndex, stepState) {
    return stepIndex == 0
        ? Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xff3b82f6),
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
              child: Text(
                '1',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ))
        : stepIndex == 1
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff3b82f6),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ))
            : Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff3b82f6),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ));
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
