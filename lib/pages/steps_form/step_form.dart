import 'package:flutter/material.dart';
import 'package:forzado/core/app_styles.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/data/providers/Stepper/stepper_provider.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/pages/steps_form/steps/step_one.dart';
import 'package:forzado/pages/steps_form/steps/step_three.dart';
import 'package:forzado/pages/steps_form/steps/step_two.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StepperForm extends StatefulWidget {
  StepperForm({super.key, this.isUpdate, this.idForzado});
  final bool? isUpdate;
  final int? idForzado;
  @override
  State<StepperForm> createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  late DateTime dateNow;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        final dropdownProvider =
            Provider.of<DropDownValuesManagerProvider>(context, listen: false);
        widget.isUpdate != true ? dropdownProvider.clearValues() : null;
        await dropdownProvider.getData2();
        final mastersProvider =
            Provider.of<MastersProvider>(context, listen: false);
        await mastersProvider.getShifts();
        await dropdownProvider.getTagsMatrizRiesgo(context);
        dropdownProvider.seleccionarSolicitante();
      }
    });
    dateNow = DateTime.now();
  }

  // Helper method to check if Step 0 is fully filled
  bool _isStep0Complete(DropDownValuesManagerProvider dropdownProvider) {
    return dropdownProvider.currentValueTagPrefijo != null &&
        dropdownProvider.currentValueTagCentro != null &&
        dropdownProvider.currentTagSubfijo.isNotEmpty &&
        dropdownProvider.currentValueDescription.isNotEmpty &&
        dropdownProvider.currentValueTagDisciplina != null;
    // dropdownProvider.currentValueSlot != null;
  }

  // Helper method to check if Step 1 is fully filled
  bool _isStep1Complete(DropDownValuesManagerProvider dropdownProvider) {
    return dropdownProvider.currentValueInterlock.isNotEmpty &&
        dropdownProvider.currentStateResponsibility != null &&
        dropdownProvider.currentStateRisk != null &&
        dropdownProvider.currentStateProbability != null &&
        dropdownProvider.currentStateImpact != null &&
        dropdownProvider.currentRisk != null;
  }

  // Helper method to check if Step 2 is fully filled
  bool _isStep2Complete(DropDownValuesManagerProvider dropdownProvider) {
    return dropdownProvider.currentStateApplicant != null &&
        dropdownProvider.currentStateApprover != null;
    // dropdownProvider.currentStateExecutor != null &&
    // dropdownProvider.currentStateTypeForzado != null;
  }

  // Check if a step can be accessed based on previous steps completion
  bool _canAccessStep(
      int stepIndex, DropDownValuesManagerProvider dropdownProvider) {
    if (stepIndex == 0) return true; // Step 0 is always accessible
    if (stepIndex == 1) return _isStep0Complete(dropdownProvider);
    if (stepIndex == 2) {
      return _isStep0Complete(dropdownProvider) &&
          _isStep1Complete(dropdownProvider);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final forzadosProvider = Provider.of<ForzadosProvider>(context);
    final dropdownProvider =
        Provider.of<DropDownValuesManagerProvider>(context);
    // provider de las maestras en este caso es de turnos
    final mastersProvider = Provider.of<MastersProvider>(context);
    final stepperProvider = Provider.of<StepperProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creación solicitud de forzado'),
        leading: IconButton(
          onPressed: () {
            dropdownProvider.clearValues();
            stepperProvider.setCurrentStep(0);
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
                stepIconBuilder: (stepIndex, stepState) => _stepperIcons(
                    stepIndex, stepState, dropdownProvider, value),
                controlsBuilder: (context, details) {
                  bool validation = details.currentStep != 2 ? true : false;
                  bool isCurrentStepComplete = details.currentStep == 0
                      ? _isStep0Complete(dropdownProvider)
                      : details.currentStep == 1
                          ? _isStep1Complete(dropdownProvider)
                          : _isStep2Complete(dropdownProvider);

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
                          onTap: isCurrentStepComplete
                              ? () async {
                                  if (forzadosProvider.isFetchingPostData) {
                                    return;
                                  }
                                  if (details.currentStep == 0
                                      ? forzadosProvider
                                          .validateStepFormOne(dropdownProvider)
                                      : details.currentStep == 1
                                          ? forzadosProvider
                                              .validateStepFormTwo(
                                                  dropdownProvider)
                                          : forzadosProvider
                                              .validateStepFormThree(
                                                  dropdownProvider)) {
                                    if (validation) {
                                      details.onStepContinue!();
                                    } else {
                                      String id = widget.isUpdate == true
                                          ? widget.idForzado.toString()
                                          : '';
                                      final res = await forzadosProvider
                                          .sendRequestPost(
                                              context,
                                              dropdownProvider,
                                              id,
                                              mastersProvider);
                                      if (!res) {
                                        CustomModal().showModal(
                                            context,
                                            forzadosProvider
                                                .errorMessagePostData,
                                            Colors.red,
                                            false);
                                      } else {
                                        final route = MaterialPageRoute(
                                            builder: (_) =>
                                                CongratulationAnimation(
                                                  page: StepperForm(),
                                                ));
                                        Navigator.pushReplacement(
                                            context, route);
                                        dropdownProvider.clearValues();
                                        value.setCurrentStep(0);
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
                                }
                              : null, // Disable if step is incomplete
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                                color: validation
                                    ? (isCurrentStepComplete
                                        ? AppColors.primary
                                        : Colors.grey)
                                    : forzadosProvider.isFetchingPostData
                                        ? const Color.fromARGB(255, 51, 52, 57)
                                        : AppColors.primary,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10), // Reduced from 25 to 10
                            child: Center(
                                child: Text(
                              validation
                                  ? 'Continuar'
                                  : forzadosProvider.isFetchingPostData == true
                                      ? 'Espera'
                                      : widget.isUpdate == true
                                          ? 'Actualizar forzado'
                                          : 'Realizar Solicitud',
                              style: AppStyles.textStyle.copyWith(
                                  color: isCurrentStepComplete || !validation
                                      ? Colors.white
                                      : Colors.black),
                            )),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                steps: [
                  Step(
                    isActive: value.currentStep == 0,
                    title: const Text(''),
                    content: StepOneContent(
                      date: dateNow,
                      dropdownProvider: dropdownProvider,
                      isUpdate: widget.isUpdate ?? false,
                    ),
                  ),
                  Step(
                    isActive: value.currentStep == 1,
                    title: const Text(''),
                    content: StepTwoContent(
                      date: dateNow,
                      dropdownProvider: dropdownProvider,
                      isUpdate: widget.isUpdate ?? false,
                    ),
                  ),
                  Step(
                    isActive: value.currentStep == 2,
                    title: const Text(''),
                    content: StepThreeContent(
                      date: dateNow,
                      dropdownProvider: dropdownProvider,
                      isUpdate: widget.isUpdate ?? false,
                    ),
                  ),
                ],
                onStepContinue: () {
                  if (value.currentStep != 2) {
                    bool canContinue = value.currentStep == 0
                        ? _isStep0Complete(dropdownProvider)
                        : _isStep1Complete(dropdownProvider);
                    if (canContinue) {
                      value.setCurrentStep(value.currentStep + 1);
                    }
                  }
                },
                onStepCancel: () {
                  if (value.currentStep != 0) {
                    value.setCurrentStep(value.currentStep - 1);
                  }
                },
                onStepTapped: (stepValue) {
                  if (_canAccessStep(stepValue, dropdownProvider)) {
                    value.setCurrentStep(stepValue);
                  }
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
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 60,
                        color: Colors.blue,
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
                          color: const Color.fromARGB(147, 0, 0, 0),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Indicador circular con color dinámico
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        if (value.isGettingdata)
                                          CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              value.currentRequest
                                                      .contains('Error')
                                                  ? Colors.red
                                                  : Colors.blueAccent,
                                            ),
                                            strokeWidth: 5,
                                          )
                                        else
                                          Icon(
                                            value.currentRequest
                                                    .contains('Error')
                                                ? Icons.error_outline
                                                : Icons.check_circle_outline,
                                            size: 50,
                                            color: value.currentRequest
                                                    .contains('Error')
                                                ? Colors.red
                                                : Colors.green,
                                          ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Título del estado
                                  Text(
                                    value.isGettingdata
                                        ? 'Procesando...'
                                        : value.currentRequest.contains('Error')
                                            ? 'Error'
                                            : 'Completado',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          value.currentRequest.contains('Error')
                                              ? Colors.red
                                              : Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  // Descripción detallada
                                  Text(
                                    value.currentRequest,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Barra de progreso lineal (opcional)
                                  if (value.isGettingdata)
                                    LinearProgressIndicator(
                                      backgroundColor: Colors.grey[200],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor,
                                      ),
                                      minHeight: 6,
                                    ),

                                  // Botón para reintentar en caso de error
                                  if (value.currentRequest.contains('Error'))
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          'Reintentar',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox();
            },
          )
        ],
      )),
    );
  }

  // ignore: unused_element
  Container _inputDescription(DropDownValuesManagerProvider dropdownProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Descripción *'),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: dropdownProvider.currentValueDescription,
            onChanged: (value) =>
                dropdownProvider.currentValueDescription = value,
            maxLength: 100,
            maxLines: 2,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey.shade600),
              hintText: widget.isUpdate == true
                  ? dropdownProvider.currentValueDescription
                  : 'Agregue una descripción',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade50),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            ),
          )
        ],
      ),
    );
  }

  Widget _stepperIcons(
      int stepIndex,
      StepState stepState,
      DropDownValuesManagerProvider dropdownProvider,
      StepperProvider stepperProvider) {
    bool isCompleted = false;
    bool isActive = stepperProvider.currentStep == stepIndex;

    if (stepIndex == 0) {
      isCompleted = _isStep0Complete(dropdownProvider);
    } else if (stepIndex == 1) {
      isCompleted = _isStep1Complete(dropdownProvider);
    } else if (stepIndex == 2) {
      isCompleted = _isStep2Complete(dropdownProvider);
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: (isActive || isCompleted)
            ? const Color.fromARGB(255, 6, 43, 103)
            : const Color.fromARGB(255, 238, 236, 236),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '${stepIndex + 1}',
          style: TextStyle(
            color: (isActive || isCompleted) ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
