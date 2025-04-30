import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/models/form/forzado/request_forced_forzado.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/models/model_user_detail.dart';
import 'package:forzado/models/user/model_user.dart';
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

enum ValuesType { applicant, approver, executor, description, grupo }

class _FormRemoveForzadoState extends State<DetailsForzadorRequester> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        final dropdownProvider =
            Provider.of<DropDownValuesManagerProvider>(context, listen: false);
        await dropdownProvider.getData();
        final mastersProvider =
            Provider.of<MastersProvider>(context, listen: false);
        await mastersProvider.getShifts();
        dropdownProvider.seleccionarSolicitante();
        dropdownProvider.seleccionarSolicitante();
      }
    });
  }

  bool isFetching = false;
  String currentStateapplicant = '';
  String currentStateapprover = '';
  String currentStateexecutor = '';

  String currentValueDescription = "";
  String currentValueGrupo = "";

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
        case ValuesType.grupo:
          currentValueGrupo = newValue;
          break;
      }
    });
  }

  Future<void> sendRequestForcedForzado() async {
    ApiResponseDetailUser? userLogged = PreferencesHelper().getUser();
    CustomModal modal = CustomModal();
    if (currentStateapplicant.isEmpty ||
        currentStateapprover.isEmpty ||
        currentValueGrupo.isEmpty ||
        currentValueDescription.isEmpty) {
      modal.showModal(
          context, 'Debes de llenar todos los campos', Colors.red, false);
      return;
    }
    FormRemoveForzadoQueryParameters data = FormRemoveForzadoQueryParameters(
      solicitanteRetiro: currentStateapplicant,
      aprobadorRetiro: currentStateapprover,
      ejecutorRetiro: 'default value',
      observaciones: currentValueDescription,
      tipoGrupoB: currentValueGrupo,
      id: widget.detailForzado.id.toString(),
     );
print(json.encode(data.toJson()));
    try {
      setState(() {
        isFetching = true;
      });
      ApiClient client = ApiClient();
      final response = await client.post(
          AppUrl.postForcedForzado, json.encode(data.toJson()));
      print(response.body);

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CongratulationAnimation(
                    page: const Home(),
                  )),
        );
      } else {
        modal.showModal(context, 'Ocurrio un error: ${response.statusCode}',
            Colors.red, false);
      }
    } catch (e) {
      modal.showModal(context, 'Ocurrio un error interno en el servidor',
          Colors.red, false);
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
              const SizedBox(height: 10),
              CustomDropdownButton<modelTwo.Value>(
                hintText: 'Grupo de Ejecución *:',
                items: dropdownProvider.listGrupos,
                // selectedItem: dropdownProvider.currentStateGrupo,
                onChanged: (value) {
                  _updateCurrentValue(
                      ValuesType.grupo, value!.id.toString());
                },
              ),
              const SizedBox(height: 20),
              Column(
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
