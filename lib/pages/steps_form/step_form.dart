import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/app_styles.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/form/forzado/model_forzado.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/service_one.dart';
import 'package:forzado/services/service_three.dart';
import 'package:forzado/services/service_two.dart';
import 'package:forzado/widgets/custom_dropdown_one.dart';
import 'package:forzado/widgets/custom_dropdown_three.dart';
import 'package:forzado/widgets/custom_dropdown_two.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:provider/provider.dart';

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

// Jose: valor para validar si esta o no haciendo la peticion
  bool isFetching = false;
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

// Jose: Mostrar error si lo hay al realizar la peticion
  String error = '';
  @override
  Widget build(BuildContext context) {
    final forzadosProveider = Provider.of<ForzadosProvider>(context);
    ServiceOne serviceOne = ServiceOne(ApiClient());
    ServiceTwo serviceTwo = ServiceTwo(ApiClient());
    ServiceThree serviceThree = ServiceThree(ApiClient());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alta Forzado'),
        leading: IconButton(
          onPressed: () {
            final newRoute = MaterialPageRoute(builder: (_) => const Home());
            Navigator.pushAndRemoveUntil(context, newRoute, (r) => false);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Stepper(
          controlsBuilder: (context, details) {
            bool validation = details.currentStep != 2 ? true : false;
            return GestureDetector(
              onTap: () {
                if (isFetching) {
                  return null;
                }
                // Validar Dropdown
                if (details.currentStep == 0
                    ? currentValueTagPrefijo.isNotEmpty &&
                        currentValueTagCentro.isNotEmpty &&
                        currentValueTagDisciplina.isNotEmpty &&
                        currentValueSlot.isNotEmpty
                    : details.currentStep == 1
                        ? currentStateResponsability.isNotEmpty &&
                            currentStateRisk.isNotEmpty &&
                            currentStateProbability.isNotEmpty &&
                            currentStateImpact.isNotEmpty
                        : currentStateapplicant.isNotEmpty &&
                            currentStateapprover.isNotEmpty &&
                            currentStateexecutor.isNotEmpty &&
                            currentStateForzado.isNotEmpty) {
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
                      try {
                        setState(() {
                          isFetching = true;
                        });

                        ApiClient client = new ApiClient();
                        final response = await client.post(
                            AppUrl.postAddForzado, json.encode(data.toMap()));

                        if (response.statusCode == 200) {
                            forzadosProveider.fetchCountForzados();
                          final route = MaterialPageRoute(
                              builder: (_) => CongratulationAnimation(
                                    page: const StepperForm(),
                                  ));
                          Navigator.pushReplacement(context, route);
                          setState(() {
                            isFetching = false;
                          });
                        } else {
                          setState(() {
                            error = 'Error al realizar la petición';
                          });
                          CustomModal modal = CustomModal();
                          modal.showModal(context, 'Error al realizar la petición',
                              Colors.redAccent, false);

                          setState(() {
                            isFetching = false;
                          });
                        }
                      } catch (e) {
                        print(e);
                        CustomModal modal = CustomModal();
                        modal.showModal(context, 'Contacte a soporte',
                            Colors.redAccent, false);

                        setState(() {
                          isFetching = false;
                        });
                      }
                    }

                    sendRequestPost();
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
                        ? const Color(0xff009283)
                        : isFetching
                            ? const Color.fromARGB(255, 51, 52, 57)
                            : const Color(0xff21378C),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                    child: Text(
                  validation
                      ? 'Continuar'
                      : isFetching == true
                          ? 'Espera'
                          : 'Finalizar',
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
                                onChanged: (value) => _updateCurrentValue(
                                    ValueType.tagPrefijo, value),
                                currentValue: currentValueTagPrefijo,
                                service: serviceOne,
                                descriptionField: 'Tag (Prefijo) *',
                                hintText: 'Prefijo del Tag o Sub Área',
                                endPoint: AppUrl.gettagPrefijo1),
                            CustomDropDownButtonOne(
                                onChanged: (value) => _updateCurrentValue(
                                    ValueType.tagCentro, value),
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
                                    onChanged: (value) => _updateCurrentValue(
                                        ValueType.description,
                                        value.toUpperCase()),
                                    maxLength: 100,
                                    maxLines: 2,
                                    decoration: const InputDecoration(
                                        hintText: 'Agregue una descripción'),
                                  )
                                ],
                              ),
                            ),
                            CustomDropDownButtonTwo(
                                onChanged: (value) => _updateCurrentValue(
                                    ValueType.tagDisciplina, value),
                                currentValue: currentValueTagDisciplina,
                                service: serviceTwo,
                                descriptionField: 'Disciplina *',
                                hintText: 'Disciplina que solicita el Forzado',
                                endPoint: AppUrl.getTagDisciplina2),
                            CustomDropDownButtonTwo(
                                onChanged: (value) =>
                                    _updateCurrentValue(ValueType.slot, value),
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
                child: Form(
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
                          onChanged: (value) => _updateCurrentValue(
                              ValueType.responsability, value),
                          currentValue: currentStateResponsability,
                          service: serviceThree,
                          descriptionField: 'Responsable *',
                          hintText:
                              'Seleccione Gerencia Responsable del Forzado',
                          endPoint: AppUrl.getResponsable3),
                      CustomDropDownButtonTwo(
                          onChanged: (value) =>
                              _updateCurrentValue(ValueType.risk, value),
                          currentValue: currentStateRisk,
                          service: serviceTwo,
                          descriptionField: 'Riesgo A *',
                          hintText: 'Riesgo',
                          endPoint: AppUrl.getRiesgoA2),
                      CustomDropDownButtonTwo(
                          onChanged: (value) =>
                              _updateCurrentValue(ValueType.probability, value),
                          currentValue: currentStateProbability,
                          service: serviceTwo,
                          descriptionField: 'Probabilidad *',
                          hintText: 'Categoria de Consecuencias',
                          endPoint: AppUrl.getProbabilidad2),
                      CustomDropDownButtonTwo(
                          onChanged: (value) =>
                              _updateCurrentValue(ValueType.impact, value),
                          currentValue: currentStateImpact,
                          service: serviceTwo,
                          descriptionField: 'Impacto *',
                          hintText: 'Seleccione Impacto de la Consecuencia',
                          endPoint: AppUrl.getImpacto2),
                    ],
                  ),
                ),
              ),
            ),
            Step(
              isActive: _currentState == 2,
              title: const Text(''),
              content: Container(
                width: double.infinity,
                child: Form(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomDropDownButtonThree(
                          onChanged: (value) =>
                              _updateCurrentValue(ValueType.applicant, value),
                          currentValue: currentStateapplicant,
                          service: serviceThree,
                          descriptionField: 'Solicitante (AN) *',
                          hintText: 'Seleccione Solicitante del Forzado',
                          endPoint: AppUrl.getSolicitantes3),
                      CustomDropDownButtonThree(
                          onChanged: (value) =>
                              _updateCurrentValue(ValueType.approver, value),
                          currentValue: currentStateapprover,
                          service: serviceThree,
                          descriptionField: 'Aprobador *',
                          hintText: 'Seleccione Aprobador del Forzado',
                          endPoint: AppUrl.getAprobadores),
                      CustomDropDownButtonThree(
                          onChanged: (value) =>
                              _updateCurrentValue(ValueType.executor, value),
                          currentValue: currentStateexecutor,
                          service: serviceThree,
                          descriptionField: 'Ejecutor *',
                          hintText: 'Seleccione Ejecutor',
                          endPoint: AppUrl.getEjecutor),
                      CustomDropDownButtonTwo(
                          onChanged: (value) =>
                              _updateCurrentValue(ValueType.forzado, value),
                          currentValue: currentStateForzado,
                          service: serviceTwo,
                          descriptionField: 'Tipo de Forzado *',
                          hintText: 'Seleccione Tipo de Forzado',
                          endPoint: AppUrl.getTipoForzado2),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
