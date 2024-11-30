import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/service_one.dart';
import 'package:forzado/services/service_three.dart';
import 'package:forzado/services/service_two.dart';
import 'package:forzado/widgets/custom_dropdown_one.dart';
import 'package:forzado/widgets/custom_dropdown_three.dart';
import 'package:forzado/widgets/custom_dropdown_two.dart';

class StepperForm extends StatefulWidget {
  const StepperForm({super.key});

  @override
  State<StepperForm> createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  int _currentState = 0;
  @override
  Widget build(BuildContext context) {
    ServiceOne serviceOne = ServiceOne(ApiClient());
    ServiceTwo serviceTwo = ServiceTwo(ApiClient());
    ServiceThree serviceThree = ServiceThree(ApiClient());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentState,
          steps: [
            Step(
                isActive: _currentState == 0,
                title: const Text(''),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            CustomDropDownButtonOne(
                                service: serviceOne,
                                descriptionField: 'Tag (Prefijo) * ',
                                hintText: 'Prefijo del Tag o Sub Área',
                                endPoint: AppUrl.gettagPrefijo1),
                            CustomDropDownButtonOne(
                                service: serviceOne,
                                descriptionField: 'Tag (Centro) *',
                                hintText:
                                    'Parte Central  del Tag Asoc. al instrumento o Equipo',
                                endPoint: AppUrl.getTagCentro1),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Descripción *'),
                                  TextFormField(
                                    maxLines: 2,
                                    decoration: const InputDecoration(
                                        hintText: 'Agregue una descripción'),
                                  )
                                ],
                              ),
                            ),
                            CustomDropDownButtonTwo(
                                service: serviceTwo,
                                descriptionField: 'Disciplina *',
                                hintText: 'Disciplina que solicita el Forzado',
                                endPoint: AppUrl.getTagDisciplina2),
                            CustomDropDownButtonTwo(
                                service: serviceTwo,
                                descriptionField: 'Turno *',
                                hintText: 'Turno',
                                endPoint: AppUrl.getTurno2),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Step(
              isActive: _currentState == 1,
              title: const Text(''),
              content: SizedBox(
                width: double.infinity,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Iterlock Seguridad *'),
                        DropdownButtonFormField(
                          value: null,
                          hint: const Text('Seleccione Interlock'),
                          items: const [
                            DropdownMenuItem(value: 'si', child: Text('Si')),
                            DropdownMenuItem(value: 'NO', child: Text('No')),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Seleccione una opcion';
                            }
                            return '';
                          },
                          onChanged: (value) {
                            // Todo: rear logica despues
                          },
                        ),
                      ],
                    ),
                    CustomDropDownButtonThree(
                        service: serviceThree,
                        descriptionField: 'Responsable *',
                        hintText: 'Seleccione Gerencia Responsable del Forzado',
                        endPoint: AppUrl.getResponsable3),
                    CustomDropDownButtonTwo(
                        service: serviceTwo,
                        descriptionField: 'Riesgo A *',
                        hintText: 'Riesgo',
                        endPoint: AppUrl.getRiesgoA2),
                    CustomDropDownButtonTwo(
                        service: serviceTwo,
                        descriptionField: 'Probabilidad *',
                        hintText: 'Categoria de Consecuencias',
                        endPoint: AppUrl.getProbabilidad2),
                    CustomDropDownButtonTwo(
                        service: serviceTwo,
                        descriptionField: 'Impacto *',
                        hintText: 'Seleccione Impacto de la Consecuencia',
                        endPoint: AppUrl.getImpacto2),
                  ],
                ),
              ),
            ),
            Step(
              isActive: _currentState == 2,
              title: const Text(''),
              content: Container(
                width: double.infinity,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomDropDownButtonThree(
                        service: serviceThree,
                        descriptionField: 'Solicitante (AN) *',
                        hintText: 'Seleccione Solicitante del Forzado',
                        endPoint: AppUrl.getSolicitantes3),
                    CustomDropDownButtonThree(
                        service: serviceThree,
                        descriptionField: 'Aprobador *',
                        hintText: 'Seleccione Aprobador del Forzado',
                        endPoint: AppUrl.getAprobadores),
                    CustomDropDownButtonThree(
                        service: serviceThree,
                        descriptionField: 'Ejecutor *',
                        hintText: 'Seleccione Ejecutor',
                        endPoint: AppUrl.getEjecutor),
                    CustomDropDownButtonTwo(
                        service: serviceTwo,
                        descriptionField: 'Tipo de Forzado *',
                        hintText: 'Seleccione Tipo de Forzado',
                        endPoint: AppUrl.getTipoForzado2),
                  ],
                ),
              ),
            ),
          ],
          // type: StepperType.horizontal,
          onStepTapped: (value) {
            setState(() {
              _currentState = value;
            });
          },
          onStepContinue: () {
            if (_currentState != 2) {
              setState(() {
                _currentState += 1;
              });
            }
          },
          onStepCancel: () {
            if (_currentState != 0) {
              setState(() {
                _currentState -= 1;
              });
            }
          },
        ),
      ),
    );
  }
}
