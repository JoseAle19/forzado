import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/widgets/drop_down_offline/custom_drop_one.dart';
import 'package:hive_flutter/adapters.dart';

class StepperFormOffline extends StatefulWidget {
  const StepperFormOffline({super.key});

  @override
  State<StepperFormOffline> createState() => _StepperFormOfflineState();
}

class _StepperFormOfflineState extends State<StepperFormOffline> {
  int _currentStep = 0;
  String? selectedValue;

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
                    title: SizedBox(),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                CustomDropDownButtonOneOff(
                                  box: HiveBoxes.tagPrefijo,
                                  descriptionField: 'Tag (Prefijo) * ',
                                  hintText: 'Prefijo del Tag o Sub Área',
                                  currentValue: '',
                                  onChanged: (value) {},
                                ),
                                CustomDropDownButtonOneOff(
                                  box: HiveBoxes.tagCentro,
                                  descriptionField: 'Tag (Centro) *',
                                  hintText:
                                      'Parte Central  del Tag Asoc. al instrumento o Equipo',
                                  currentValue: '',
                                  onChanged: (value) {},
                                ),
                              ],
                            ),
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
                    content: Text('Contenido del paso 2'),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const SizedBox(),
                    content: Text('Contenido del paso 3'),
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
}
