import 'package:flutter/material.dart';
import 'package:forzado/core/app_styles.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/Stepper/stepper_provider.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:provider/provider.dart';

class StepperForm extends StatefulWidget {
  const StepperForm({super.key});

  @override
  State<StepperForm> createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {

  String error = '';
  @override
  Widget build(BuildContext context) {
    final forzadosProvider = Provider.of<ForzadosProvider>(context);
    final dropdownProvider =
        Provider.of<DropDownValuesManagerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alta Forzado'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
          child: Stack(
        children: [
          Consumer<StepperProvider>(
            builder: (context, value, child) {
              return Stepper(
                stepIconHeight: 30,
                stepIconWidth: 30,
                stepIconBuilder: (stepIndex, stepState) =>
                    _stepperIcons(stepIndex, stepState), // Iconos de los steps
                controlsBuilder: (context, details) {
                  bool validation = details.currentStep != 2 ? true : false;
                  return GestureDetector(
                    onTap: () async {
                      if (forzadosProvider.isFetchingPostData) {
                        return;
                      }
                      // Validar Dropdown
                      if (details.currentStep == 0
                          ? forzadosProvider
                              .validateStepFormOne(dropdownProvider)
                          : details.currentStep == 1
                              ? forzadosProvider
                                  .validateStepFormTwo(dropdownProvider)
                              : forzadosProvider
                                  .validateStepFormThree(dropdownProvider)) {
                        if (validation) {
                          details.onStepContinue!();
                        } else {
                          final res = await forzadosProvider.sendRequestPost(
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
                                      page: const StepperForm(),
                                    ));
                            Navigator.pushReplacement(context, route);
                            dropdownProvider.clearValues();
                          }
                        }
                      } else {
                        CustomModal modal = CustomModal();
                        modal.showModal(context, 'Completa todos los campos',
                            Colors.redAccent, false);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                          color: validation
                              ? const Color(0xff001d39)
                              : forzadosProvider.isFetchingPostData
                                  ? const Color.fromARGB(255, 51, 52, 57)
                                  : const Color(0xff21378C),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                          child: Text(
                        validation
                            ? 'Continuar'
                            : forzadosProvider.isFetchingPostData == true
                                ? 'Espera'
                                : 'Finalizar',
                        style: AppStyles.textStyle,
                      )),
                    ),
                  );
                },
                steps: [
                  Step(
                      isActive: value.currentStep == 0,
                      title: const Text(''),
                      content: Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .6,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              CustomDropdownButton<modelone.Value>(
                                hintText: 'Prefijo del Tag o Sub Área',
                                items: dropdownProvider.listPrefijos,
                                selectedItem:
                                    dropdownProvider.currentValueTagPrefijo,
                                onChanged: (value) {
                                  dropdownProvider.currentValueTagPrefijo =
                                      value!;
                                },
                              ),
                              CustomDropdownButton<modelone.Value>(
                                hintText: 'Tag (centro) *:',
                                items: dropdownProvider.listCentros,
                                selectedItem:
                                    dropdownProvider.currentValueTagCentro,
                                onChanged: (value) {
                                  dropdownProvider.currentValueTagCentro =
                                      value!;
                                },
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
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
                                  const Text('Iterlock Seguridad *'),
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
                              hintText: 'Riesgo A *:',
                              items: dropdownProvider.listRiesgos,
                              selectedItem: dropdownProvider.currentStateRisk,
                              onChanged: (value) {
                                dropdownProvider.currentStateRisk = value!;
                              },
                            ),
                            CustomDropdownButton<modelTwo.Value>(
                              hintText: 'Riesgo *:',
                              items: dropdownProvider.riskLevels,
                              selectedItem: dropdownProvider.currentRisk,
                              onChanged: (value) {
                                dropdownProvider.currentStateRisk = value!;
                              },
                            ),
                            CustomDropdownButton<modelTwo.Value>(
                              hintText: 'Probabilidad *:',
                              items: dropdownProvider.listProbabilidades,
                              selectedItem:
                                  dropdownProvider.currentStateProbability,
                              onChanged: (value) {
                                dropdownProvider.currentStateProbability =
                                    value!;
                                dropdownProvider.defineRisk();
                              },
                            ),
                            CustomDropdownButton<modelTwo.Value>(
                              hintText: 'Impacto *:',
                              items: dropdownProvider.listImpactos,
                              selectedItem: dropdownProvider.currentStateImpact,
                              onChanged: (value) {
                                dropdownProvider.currentStateImpact = value!;
                                dropdownProvider.defineRisk();
                              },
                            ),
                          ],
                        ),
                      )),
                  Step(
                    isActive: value.currentStep == 2,
                    title: const Text(''),
                    content: Container(
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
                  if (value.currentStep != 2) {
                    value.setCurrentStep(value.currentStep + 1);
                  }
                },
                onStepCancel: () {
                  if (value.currentStep != 0) {
                    value.setCurrentStep(value.currentStep - 1);
                  }
                },
                onStepTapped: (stepValue) {
                  value.setCurrentStep(stepValue);
                },
                type: StepperType.horizontal,
                currentStep: value.currentStep,
              );
            },
          ),
          Consumer<DropDownValuesManagerProvider>(
            builder: (context, value, child) {
              return value.error.isNotEmpty
                  ? Positioned(
                      // top: 0,
                      left: 0,
                      right: 0,
                      // bottom: 0,
                      child: Container(
                        width: 60,
                        // height: 60,
                        color: Colors.red,
                        child: Center(
                          child: TextButton(
                            onPressed: null,
                            child: Column(
                              children: [
                                Text(
                                  value.error,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    value.getData();
                                  },
                                  child: const Text('Reintentar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  : value.isGettingdata
                      ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: const Color.fromARGB(184, 0, 0, 0),
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primary,
                          )))
                      : const SizedBox();
            },
          )
        ],
      )),
    );
  }

  Widget _stepperIcons(stepIndex, stepState) {
    return stepIndex == 0
        ? Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primary,
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
                    color: AppColors.primary,
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
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ));
  }
}
