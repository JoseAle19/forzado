import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider_off.dart';
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_three.dart' as modelthird;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class StepperForm extends StatefulWidget {
  final bool? isUpdate;
  final String? idForzado;

  const StepperForm({super.key, this.isUpdate, this.idForzado});

  @override
  State<StepperForm> createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  final CustomModal _modal = CustomModal();
  int _currentStep = 0;
  final DateTime _dateNow = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DropdownProviderManagerOffline>(context, listen: false)
          .loadDataPromHive();
    });
  }

  Widget _stepperIcons(int stepIndex, StepState stepState,
      DropdownProviderManagerOffline provider, _StepperFormState value) {
    final isActive = _currentStep == stepIndex;
    final isComplete = _currentStep > stepIndex;

    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF072B69)
            : isComplete
                ? Colors.green
                : Colors.grey.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isComplete
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : Text(
                '${stepIndex + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  bool _isStep0Complete(DropdownProviderManagerOffline provider) {
    return provider.currentValueSubfijo.isNotEmpty &&
        provider.currentValueTagPrefijo != null &&
        provider.currentValueTagCentro != null &&
        provider.currentValueTagDisciplina != null &&
        provider.currentValueCircuitos != null &&
        provider.currentValueDescription.isNotEmpty;
  }

  bool _isStep1Complete(DropdownProviderManagerOffline provider) {
    bool riskValid = provider.isRiskAssessmentAutoSet ||
        (provider.currentValueInterlock == 1 ||
            provider.currentValueInterlock == 0 &&
                provider.currentStateResponsibility != null &&
                provider.currentStateProbability != null &&
                provider.currentStateImpact != null &&
                provider.currentRiskA != null);

    return riskValid;
  }

  bool _isStep2Complete(DropdownProviderManagerOffline provider) {
    return provider.currentStateApplicant != null &&
        provider.currentGrupo != null &&
        provider.currentStateApprover != null;
  }

  bool _canAccessStep(int stepValue, DropdownProviderManagerOffline provider) {
    if (stepValue == 0) return true;
    if (stepValue == 1) return _isStep0Complete(provider);
    if (stepValue == 2) return _isStep1Complete(provider);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DropdownProviderManagerOffline>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear solicitud'),
      ),
      body: Stepper(
        stepIconHeight: 30,
        stepIconWidth: 30,
        stepIconBuilder: (stepIndex, stepState) =>
            _stepperIcons(stepIndex, stepState, provider, this),
        controlsBuilder: (context, details) {
          bool validation = details.currentStep != 2;
          bool isCurrentStepComplete = details.currentStep == 0
              ? _isStep0Complete(provider)
              : details.currentStep == 1
                  ? _isStep1Complete(provider)
                  : _isStep2Complete(provider);

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
                          if (details.currentStep == 0
                              ? _isStep0Complete(provider)
                              : details.currentStep == 1
                                  ? _isStep1Complete(provider)
                                  : _isStep2Complete(provider)) {
                            if (validation) {
                              details.onStepContinue!();
                            } else {
                              // Lógica para enviar el formulario
                              _modal.showModal(
                                  context,
                                  'Formulario enviado con éxito',
                                  Colors.green,
                                  true);

                              // todo:
                            }
                          } else {
                            _modal.showModal(
                              context,
                              'Completa todos los campos',
                              const Color(0xFF072B69),
                              false,
                            );
                          }
                        }
                      : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                      color: validation
                          ? (isCurrentStepComplete
                              ? const Color(0xFF072B69)
                              : Colors.grey)
                          : const Color(0xFF072B69),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        validation
                            ? 'Continuar'
                            : widget.isUpdate == true
                                ? 'Actualizar forzado'
                                : 'Realizar Solicitud',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        steps: [
          Step(
            isActive: _currentStep == 0,
            title: const Text(''),
            content: _StepOneContent(
              date: _dateNow,
              dropdownProvider: provider,
              isUpdate: widget.isUpdate ?? false,
            ),
          ),
          Step(
            isActive: _currentStep == 1,
            title: const Text(''),
            content: _StepTwoContent(
              date: _dateNow,
              dropdownProvider: provider,
              isUpdate: widget.isUpdate ?? false,
            ),
          ),
          Step(
            isActive: _currentStep == 2,
            title: const Text(''),
            content: _StepThreeContent(
              date: _dateNow,
              dropdownProvider: provider,
              isUpdate: widget.isUpdate ?? false,
            ),
          ),
        ],
        onStepContinue: () {
          if (_currentStep != 2) {
            bool canContinue = _currentStep == 0
                ? _isStep0Complete(provider)
                : _isStep1Complete(provider);
            if (canContinue) {
              setState(() => _currentStep += 1);
            } else {
              _modal.showModal(
                context,
                'Completa todos los campos',
                const Color(0xFF072B69),
                false,
              );
            }
          }
        },
        onStepCancel: () {
          if (_currentStep != 0) {
            setState(() => _currentStep -= 1);
          }
        },
        onStepTapped: (stepValue) {
          if (_canAccessStep(stepValue, provider)) {
            setState(() => _currentStep = stepValue);
          }
        },
        type: StepperType.horizontal,
        currentStep: _currentStep,
      ),
    );
  }
}

class _StepOneContent extends StatelessWidget {
  final DateTime date;
  final DropdownProviderManagerOffline dropdownProvider;
  final bool isUpdate;

  const _StepOneContent({
    required this.date,
    required this.dropdownProvider,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha y Hora de la Solicitud: ${dropdownProvider.date}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('Turno actual: ${dropdownProvider.shiftType}'),
            // Text('ID: ${currentShift.id}'),
          ],
        ),
        const SizedBox(height: 16),
        CustomDropdownButton<modelone.Value>(
          hintText: 'Sub Área (Tag Prefijo) *',
          items: dropdownProvider.listPrefijos,
          selectedItem: dropdownProvider.currentValueTagPrefijo,
          onChanged: (v) => dropdownProvider.currentValueTagPrefijo = v!,
        ),
        const SizedBox(height: 16),
        CustomDropdownButton<modelone.Value>(
          hintText: 'Centro (Tag Centro) *',
          items: dropdownProvider.listCentros,
          selectedItem: dropdownProvider.currentValueTagCentro,
          onChanged: (v) => dropdownProvider.currentValueTagCentro = v!,
        ),
        const SizedBox(height: 16),
        TextFormField(
          // initialValue: ,
          onChanged: (v) => dropdownProvider.currentValueSubfijo = v,
          maxLength: 100,
          maxLines: 2,
          decoration: InputDecoration(
            labelText: 'Tag (Sufijo) *',
            hintText: dropdownProvider.currentValueSubfijo,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        TextFormField(
          // initialValue: 'Agrega una descripción ',
          onChanged: (v) => dropdownProvider.currentValueDescription = v,
          maxLength: 100,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Descripción *',
            hintText: dropdownProvider.currentValueDescription,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        AbsorbPointer(
          absorbing: false,
          child: Opacity(
            opacity: 1,
            child: CustomDropdownButton<modelTwo.Value>(
              hintText: 'Disciplina *',
              items: dropdownProvider.listDiciplinas,
              selectedItem: dropdownProvider.currentValueTagDisciplina,
              onChanged: (v) => dropdownProvider.currentValueTagDisciplina = v!,
            ),
          ),
        ),
        AbsorbPointer(
          absorbing: false,
          child: Opacity(
            opacity: 1,
            child: CustomDropdownButton<modelTwo.Value>(
              hintText: 'Circuito *',
              items: dropdownProvider.listCircuitos,
              selectedItem: dropdownProvider.currentValueCircuitos,
              onChanged: (v) => dropdownProvider.currentValueCircuitos = v!,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepTwoContent extends StatelessWidget {
  final DateTime date;
  final DropdownProviderManagerOffline dropdownProvider;
  final bool isUpdate;

  const _StepTwoContent({
    required this.date,
    required this.dropdownProvider,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha y Hora de la Solicitud: ${dropdownProvider.date}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('Turno actual: ${dropdownProvider.shiftType}'),
            // Text('ID: ${currentShift.id}'),
          ],
        ),
        const SizedBox(height: 16),
        AbsorbPointer(
          absorbing: dropdownProvider.isRiskAssessmentAutoSet,
          child: Opacity(
            opacity: dropdownProvider.isRiskAssessmentAutoSet ? 0.5 : 1,
            child: DropdownButtonFormField<int>(
              value: dropdownProvider.currentValueInterlock,
              hint: const Text('Seleccione Interlock'),
              items: const [
                DropdownMenuItem(value: 1, child: Text('Si')),
                DropdownMenuItem(value: 0, child: Text('No')),
              ],
              onChanged: (v) {
                dropdownProvider.currentValueInterlock = v!;
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        const SizedBox(height: 16),
        AbsorbPointer(
          absorbing: false,
          child: Opacity(
            opacity: 1,
            child: CustomDropdownButton<modelthird.Value>(
              hintText: 'Gerencia Responsable *',
              items: dropdownProvider.listResponsables,
              selectedItem: dropdownProvider.currentStateResponsibility,
              onChanged: (v) =>
                  dropdownProvider.currentStateResponsibility = v!,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AbsorbPointer(
          absorbing: dropdownProvider.isRiskAssessmentAutoSet,
          child: Opacity(
            opacity: dropdownProvider.isRiskAssessmentAutoSet ? 0.5 : 1,
            child: CustomDropdownButton<modelTwo.Value>(
              hintText: 'Riesgo a*',
              items: dropdownProvider.listRiesgos,
              selectedItem: dropdownProvider.currentRiskA,
              onChanged: (v) => dropdownProvider.currentRiskA = v!,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AbsorbPointer(
          absorbing: dropdownProvider.isRiskAssessmentAutoSet,
          child: Opacity(
            opacity: dropdownProvider.isRiskAssessmentAutoSet ? 0.5 : 1,
            child: CustomDropdownButton<modelTwo.Value>(
              hintText: 'Probabilidad *',
              items: dropdownProvider.listProbabilidades,
              selectedItem: dropdownProvider.currentStateProbability,
              onChanged: (v) => dropdownProvider.currentStateProbability = v!,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AbsorbPointer(
          absorbing: dropdownProvider.isRiskAssessmentAutoSet,
          child: Opacity(
            opacity: dropdownProvider.isRiskAssessmentAutoSet ? 0.5 : 1,
            child: CustomDropdownButton<modelTwo.Value>(
              hintText: 'Impacto *',
              items: dropdownProvider.listImpactos,
              selectedItem: dropdownProvider.currentStateImpact,
              onChanged: (v) => dropdownProvider.currentStateImpact = v!,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.7,
            child: CustomDropdownButton<modelTwo.Value>(
              hintText: 'Riesgo Matriz *',
              items: dropdownProvider.listMatrizRiesgo,
              selectedItem: dropdownProvider.currentRisk,
              onChanged: (v) => dropdownProvider.currentRisk = v!,
              backgroundColor: dropdownProvider.currentRisk != null
                  ? dropdownProvider.currentRisk!.descripcion.toLowerCase() ==
                          'bajo'
                      ? Colors.greenAccent
                      : dropdownProvider.currentRisk!.descripcion
                                  .toLowerCase() ==
                              'alto'
                          ? Colors.redAccent
                          : Colors.orange
                  : Colors.grey,
              textColor: dropdownProvider.currentRisk != null
                  ? dropdownProvider.currentRisk!.descripcion.toLowerCase() ==
                          'bajo'
                      ? Colors.green.shade800
                      : dropdownProvider.currentRisk!.descripcion
                                  .toLowerCase() ==
                              'alto'
                          ? Colors.white
                          : Colors.white
                  : Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepThreeContent extends StatelessWidget {
  final DateTime date;
  final DropdownProviderManagerOffline dropdownProvider;
  final bool isUpdate;

  const _StepThreeContent({
    required this.date,
    required this.dropdownProvider,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha y Hora de la Solicitud: ${dropdownProvider.date}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('Turno actual: ${dropdownProvider.shiftType}'),
            // Text('ID: ${currentShift.id}'),
          ],
        ),
        const SizedBox(height: 16),
        CustomDropdownButton<modelthird.Value>(
          hintText: 'Solicitante *',
          items: dropdownProvider.listSolicitantes,
          selectedItem: dropdownProvider.currentStateApplicant,
          onChanged: (v) => dropdownProvider.currentStateApplicant = v!,
        ),
        const SizedBox(height: 16),
        CustomDropdownButton<modelthird.Value>(
          hintText: 'Aprobador *',
          items: dropdownProvider.listAprobadores,
          selectedItem: dropdownProvider.currentStateApprover,
          onChanged: (v) => dropdownProvider.currentStateApprover = v!,
        ),
        const SizedBox(height: 16),
        CustomDropdownButton<modelTwo.Value>(
          hintText: 'Grupo de Ejecución *',
          items: dropdownProvider.listGrupos,
          selectedItem: dropdownProvider.currentGrupo,
          onChanged: (v) => dropdownProvider.currentGrupo = v!,
        ),
      ],
    );
  }
}

class CustomModal {
  void showModal(
      BuildContext context, String error, Color color, bool? success) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            success == false ? Icons.error : Icons.check,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
