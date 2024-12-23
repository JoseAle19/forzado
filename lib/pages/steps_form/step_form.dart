 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/app_styles.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/form/forzado/model_forzado.dart';

import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/service_one.dart';
import 'package:forzado/services/service_three.dart';
import 'package:forzado/services/service_two.dart';
import 'package:forzado/widgets/custom_dropdown_one.dart';
import 'package:forzado/widgets/custom_dropdown_three.dart';
import 'package:forzado/widgets/custom_dropdown_two.dart';
 import 'package:http/http.dart' as http;


class StepperForm extends StatefulWidget {
  const StepperForm({super.key});

  @override
  State<StepperForm> createState() => _StepperFormState();
}
 enum ValueType {
  tagPrefijo,
  tagCentro,
  description,
  tagDisciplina,
  slot,
  segurity,
  responsability,
  risk,
  probability,
  impact,
  applicant,
  approver,
  executor,
  forzado,
}

class _StepperFormState extends State<StepperForm> {
  // first screen
  String currentValueTagPrefijo = "";
  String currentValueTagCentro = "";
  String currentValueDescription = "";
  String currentValueTagDisciplina = "";
  String currentValueSlot = "";
  // second pantalla
  String currentValueSegurity = "";
  String currentStateResponsability = '';
  String currentStateRisk = '';
  String currentStateProbability = '';
  String currentStateImpact = '';
  // third screen
  String currentStateapplicant = '';
  String currentStateapprover = '';
  String currentStateexecutor = '';
  String currentStateForzado = '';
 
  int _currentState = 0;

void _updateCurrentValue(ValueType valueType, String newValue) {
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
        currentStateResponsability = newValue;
        break;
      case ValueType.risk:
        currentStateRisk = newValue;
        break;
      case ValueType.probability:
        currentStateProbability = newValue;
        break;
      case ValueType.impact:
        currentStateImpact = newValue;
        break;
      case ValueType.applicant:
        currentStateapplicant = newValue;
        break;
      case ValueType.approver:
        currentStateapprover = newValue;
        break;
      case ValueType.executor:
        currentStateexecutor = newValue;
        break;
      case ValueType.forzado:
        currentStateForzado = newValue;
        break;
    }
  });
}


  @override
  Widget build(BuildContext context) {
    ServiceOne serviceOne = ServiceOne(ApiClient());
    ServiceTwo serviceTwo = ServiceTwo(ApiClient());
    ServiceThree serviceThree = ServiceThree(ApiClient());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Stepper(
           controlsBuilder: (context, details) {
            print(details.currentStep);
            bool validation = details.currentStep != 2 ? true : false;
            return GestureDetector(
              onTap: () {
                if (validation) {
                  details.onStepContinue!();
                } else {
                  Future<void> sendRequestPost() async {
                    final data = InsertQueryParameters(
                        tagPrefijo: currentValueTagPrefijo,
                        tagCentro: currentValueTagCentro,
                        tagSubfijo: '1',
                        descripcion: currentValueDescription,
                        disciplina: currentValueTagDisciplina,
                        turno: currentValueSlot,
                        interlockSeguridad: currentValueSegurity,
                        responsable: currentStateResponsability,
                        riesgo: currentStateRisk,
                        probabilidad: currentStateResponsability,
                        impacto: currentStateImpact,
                        solicitante: currentStateapplicant,
                        aprobador: currentStateapprover,
                        ejecutor: currentStateexecutor,
                        autorizacion: '1',
                        tipoForzado: currentStateForzado);
                    print(json.encode(data.toMap()));
                    try {
                      ApiClient client = new ApiClient();
                      final response = await client.post(
                          AppUrl.postAddForzado, json.encode(data.toMap()));

                      if (response.statusCode == 200) {
                        print('Respuesta exitosa: ${response.body}');
                      } else {
                        print(response.body);
                        print('Error en la solicitud: ${response.statusCode}');
                      }
                    } catch (e) {
                      print('Error en la conexión: $e');
                    }
                  }

                  sendRequestPost();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: validation
                        ? const Color(0xff009283)
                        : const Color(0xff21378C),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                    child: Text(
                  validation ? 'Continuar' : 'Finalizar',
                  style: AppStyles.textStyle,
                )),
              ),
            );
          },

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
                               onChanged: (value) => _updateCurrentValue(ValueType.tagPrefijo, value ),
                                currentValue: currentValueTagPrefijo,
                                service: serviceOne,
                                descriptionField:
                                    'Tag (Prefijo) * ${currentValueTagPrefijo} ',
                                hintText: 'Prefijo del Tag o Sub Área',
                                endPoint: AppUrl.gettagPrefijo1),
                            CustomDropDownButtonOne(
                            onChanged: (value) => _updateCurrentValue(ValueType.tagCentro, value ),
                                currentValue: currentValueTagCentro,
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
                                     initialValue: currentValueDescription,
                                    onChanged: (value) => _updateCurrentValue(ValueType.description, value ),
                                     maxLength: 100,

                                    maxLines: 2,
                                    decoration: const InputDecoration(
                                        hintText: 'Agregue una descripción'),
                                  )
                                ],
                              ),
                            ),
                            CustomDropDownButtonTwo(
                                 onChanged: (value) => _updateCurrentValue(ValueType.tagDisciplina, value ),
                                currentValue: currentValueTagDisciplina,

                                service: serviceTwo,
                                descriptionField: 'Disciplina *',
                                hintText: 'Disciplina que solicita el Forzado',
                                endPoint: AppUrl.getTagDisciplina2),
                            CustomDropDownButtonTwo(
                                 onChanged: (value) => _updateCurrentValue(ValueType.slot, value ),
                                currentValue: currentValueSlot,

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
                         onChanged: (value) => _updateCurrentValue(ValueType.responsability, value ),
                        currentValue: currentStateResponsability,
 
                        service: serviceThree,
                        descriptionField: 'Responsable *',
                        hintText: 'Seleccione Gerencia Responsable del Forzado',
                        endPoint: AppUrl.getResponsable3),
                    CustomDropDownButtonTwo(
                         onChanged: (value) => _updateCurrentValue(ValueType.risk, value ),
                        currentValue: currentStateRisk,
 
                        service: serviceTwo,
                        descriptionField: 'Riesgo A *',
                        hintText: 'Riesgo',
                        endPoint: AppUrl.getRiesgoA2),
                    CustomDropDownButtonTwo(
                         onChanged: (value) => _updateCurrentValue(ValueType.probability, value ),
                        currentValue: currentStateProbability,
 
                        service: serviceTwo,
                        descriptionField: 'Probabilidad *',
                        hintText: 'Categoria de Consecuencias',
                        endPoint: AppUrl.getProbabilidad2),
                    CustomDropDownButtonTwo(
                         onChanged: (value) => _updateCurrentValue(ValueType.impact, value ),
                        currentValue: currentStateImpact,
 
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
                         onChanged: (value) => _updateCurrentValue(ValueType.applicant, value ),
                        currentValue: currentStateapplicant,
 
                        service: serviceThree,
                        descriptionField: 'Solicitante (AN) *',
                        hintText: 'Seleccione Solicitante del Forzado',
                        endPoint: AppUrl.getSolicitantes3),
                    CustomDropDownButtonThree(
                         onChanged: (value) => _updateCurrentValue(ValueType.approver, value ),
                        currentValue: currentStateapprover,

                        service: serviceThree,
                        descriptionField: 'Aprobador *',
                        hintText: 'Seleccione Aprobador del Forzado',
                        endPoint: AppUrl.getAprobadores),
                    CustomDropDownButtonThree(
                         onChanged: (value) => _updateCurrentValue(ValueType.executor, value ),
                        currentValue: currentStateexecutor,
 
                        service: serviceThree,
                        descriptionField: 'Ejecutor *',
                        hintText: 'Seleccione Ejecutor',
                        endPoint: AppUrl.getEjecutor),
                    CustomDropDownButtonTwo(
                         onChanged: (value) => _updateCurrentValue(ValueType.forzado, value ),
                        currentValue: currentStateForzado,
 
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
