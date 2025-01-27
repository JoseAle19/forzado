import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/models/form/forzado/request_forced_forzado.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailsForzadorRequester extends StatefulWidget {
  const DetailsForzadorRequester({super.key, required this.detailForzado});
  final ForzadoItem detailForzado;

  @override
  State<DetailsForzadorRequester> createState() => _FormRemoveForzadoState();
}

enum ValuesType {
  applicant,
  approver,
  executor,
  description,
}

class _FormRemoveForzadoState extends State<DetailsForzadorRequester> {
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
    CustomModal modal = CustomModal();
    if (currentStateapplicant.isEmpty ||
        currentStateapprover.isEmpty ||
        currentStateexecutor.isEmpty ||
        currentValueDescription.isEmpty) {
      modal.showModal(
          context, 'Debes de llenar todos los campos', Colors.red, false);
      return;
    }
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
        modal.showModal(context, 'Ocurrio un error: ${response.statusCode}',
            Colors.red, false);
      }
    } catch (e) {
      modal.showModal(context, 'Ocurrio un error interno en el servidor',
          Colors.red, false);
      print('Error en la conexión: $e');
    } finally {
      setState(() {
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dropdownProvider =
        Provider.of<DropDownValuesManagerProvider>(context);
    final forzadosProvider = Provider.of<ForzadosProvider>(context);
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
              CustomDropdownButton<modelThree.Value>(
                hintText: 'Solicitante Retiro *:',
                items: dropdownProvider.listSolicitantes,
                // selectedItem: dropdownProvider.currentStateApplicant,
                onChanged: (value) {
                  _updateCurrentValue(
                      ValuesType.applicant, value!.id.toString());
                },
              ),
              // CustomDropDownButtonThree(
              //   service: serviceThree,
              //   descriptionField: 'Solicitante Retiro *',
              //   hintText: 'Seleccione Solicitante Retiro',
              //   endPoint: AppUrl.getSolicitantes3,
              //   currentValue: currentStateapplicant,
              //   onChanged: (value) =>
              //       _updateCurrentValue(ValuesType.applicant, value),
              // ),
              const SizedBox(height: 10),
              CustomDropdownButton<modelThree.Value>(
                hintText: 'Aprobador Retiro *:',
                items: dropdownProvider.listAprobadores,
                // selectedItem: dropdownProvider.currentStateApplicant,
                onChanged: (value) {
                  _updateCurrentValue(
                      ValuesType.approver, value!.id.toString());
                },
              ),
              // CustomDropDownButtonThree(
              //   onChanged: (value) =>
              //       _updateCurrentValue(ValuesType.approver, value),
              //   currentValue: currentStateapprover,
              //   service: serviceThree,
              //   descriptionField: 'Aprobador Retiro (AN)*',
              //   hintText: 'Seleccione Aprobador',
              //   endPoint: AppUrl.getAprobadores,
              // ),
              const SizedBox(height: 10),
              CustomDropdownButton<modelThree.Value>(
                hintText: 'Ejecutor del Retiro *:',
                items: dropdownProvider.listEjecutores,
                // selectedItem: dropdownProvider.c,
                onChanged: (value) {
                  _updateCurrentValue(
                      ValuesType.executor, value!.id.toString());
                },
              ),
              // CustomDropDownButtonThree(
              //   onChanged: (value) =>
              //       _updateCurrentValue(ValuesType.executor, value),
              //   currentValue: currentStateexecutor,
              //   service: serviceThree,
              //   descriptionField: 'Ejecutor del Retiro*',
              //   hintText: 'Seleccione Ejecutor del Retiro',
              //   endPoint: AppUrl.getEjecutor,
              // ),
              const SizedBox(height: 20),
              // const Text(
              //   'Observaciones',
              //   style: TextStyle(fontFamily: 'Hoto Sans'),
              // ),
              Container(
                // margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Observaciones *'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      initialValue: currentValueDescription,
                      onChanged: (value) =>
                          _updateCurrentValue(ValuesType.description, value),
                      maxLength: 100,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        hintText: 'Agregue una descripción',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade50),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                      ),
                    )
                  ],
                ),
              ),

              // TextFormField(
              //   initialValue: currentValueDescription,
              //   onChanged: (value) =>
              //       _updateCurrentValue(ValuesType.description, value),
              //   maxLength: 100,
              //   maxLines: 2,
              //   decoration: const InputDecoration(
              //     hintText: 'Agregue una descripción',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 20),
              isFetching
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () async {
                        if (!isFetching) sendRequestForcedForzado();
                        await forzadosProvider.fetchCountForzados();
                        await forzadosProvider.getForzados();
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
