import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/form/forzado/request_forced_forzado.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/service_three.dart';
import 'package:forzado/widgets/custom_dropdown_three.dart';

// ignore: must_be_immutable
class FormRemoveForzado extends StatefulWidget {
  const FormRemoveForzado({super.key, required this.detailForzado});
  final ForzadoM detailForzado;

  @override
  State<FormRemoveForzado> createState() => _FormRemoveForzadoState();
}

enum ValuesType {
  applicant,
  approver,
  executor,
  description,
}

class _FormRemoveForzadoState extends State<FormRemoveForzado> {
  bool isFetching = false;
  String currentStateapplicant = '';
  String currentStateapprover = '';
  String currentStateexecutor = '';

  String currentValueDescription = "";

  void _updateCurrentValue(ValuesType valueType, String newValue) {
    setState(() {
      switch (valueType) {
        case ValuesType.applicant:
          currentStateapplicant = newValue;
          break;
        case ValuesType.approver:
          currentStateapprover = newValue;
          break;
        case ValuesType.executor:
          currentStateexecutor = newValue;
          break;
        case ValuesType.description:
          currentValueDescription = newValue;
          break;
      }
    });
  }

  Future<void> sendRequestForcedForzado() async {
    FormRemoveForzadoQueryParameters data = FormRemoveForzadoQueryParameters(
      solicitanteRetiro: currentStateapplicant,
      aprobadorRetiro: currentStateapprover,
      ejecutorRetiro: currentStateexecutor,
      observaciones: currentValueDescription,
      id: widget.detailForzado.id.toString(),
    );

    try {
      setState(() {
        isFetching = true;
      });
      ApiClient client = ApiClient();
      final response = await client.post(
          AppUrl.postForcedForzado, json.encode(data.toJson()));

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CongratulationAnimation(
                    page: const Home(),
                  )),
        );
      } else {
        print(response.body);
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la conexión: $e');
    } finally {
      setState(() {
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ServiceThree serviceThree = ServiceThree(ApiClient());
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: widget.detailForzado.id.toString(),
            child:
                Text(widget.detailForzado.descripcion ?? 'No hay descripción')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDropDownButtonThree(
                service: serviceThree,
                descriptionField: 'Solicitante Retiro *',
                hintText: 'Seleccione Solicitante Retiro',
                endPoint: AppUrl.getSolicitantes3,
                currentValue: currentStateapplicant,
                onChanged: (value) =>
                    _updateCurrentValue(ValuesType.applicant, value),
              ),
              const SizedBox(height: 10),
              CustomDropDownButtonThree(
                onChanged: (value) =>
                    _updateCurrentValue(ValuesType.approver, value),
                currentValue: currentStateapprover,
                service: serviceThree,
                descriptionField: 'Aprobador Retiro (AN)*',
                hintText: 'Seleccione Aprobador',
                endPoint: AppUrl.getAprobadores,
              ),
              const SizedBox(height: 10),
              CustomDropDownButtonThree(
                onChanged: (value) =>
                    _updateCurrentValue(ValuesType.executor, value),
                currentValue: currentStateexecutor,
                service: serviceThree,
                descriptionField: 'Ejecutor del Retiro*',
                hintText: 'Seleccione Ejecutor del Retiro',
                endPoint: AppUrl.getEjecutor,
              ),
              const SizedBox(height: 20),
              const Text(
                'Observaciones',
                style: TextStyle(fontFamily: 'Hoto Sans'),
              ),
              TextFormField(
                initialValue: currentValueDescription,
                onChanged: (value) =>
                    _updateCurrentValue(ValuesType.description, value),
                maxLength: 100,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Agregue una descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              isFetching
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (!isFetching) sendRequestForcedForzado();
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