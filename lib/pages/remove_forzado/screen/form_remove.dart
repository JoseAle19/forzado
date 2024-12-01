import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/service_three.dart';
import 'package:forzado/widgets/custom_dropdown_three.dart';

// ignore: must_be_immutable
class FormRemoveForzado extends StatefulWidget {
  FormRemoveForzado({super.key, required this.detailForzado});
  final Datum detailForzado;

  @override
  State<FormRemoveForzado> createState() => _FormRemoveForzadoState();
}

enum ValuesType {
  applicant,
}

class _FormRemoveForzadoState extends State<FormRemoveForzado> {
  String currentStateapplicant = '';

  void _updateCurrentValue(ValuesType valueType, String newValue) {
    setState(() {
      switch (valueType) {
        case ValuesType.applicant:
          currentStateapplicant = newValue;
          break;
      }
    });
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
      body: CustomDropDownButtonThree(
          service: serviceThree,
          descriptionField: 'Hola',
          hintText: 'Wenas',
          endPoint: AppUrl.getSolicitantes3,
          currentValue: currentStateapplicant,
          onChanged: (value) =>
              _updateCurrentValue(ValuesType.applicant, value)),
    );
  }
}
