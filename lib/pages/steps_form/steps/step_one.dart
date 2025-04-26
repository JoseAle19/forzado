// step_one.dart
import 'package:flutter/material.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:provider/provider.dart';

class StepOneContent extends StatelessWidget {
  final DropDownValuesManagerProvider dropdownProvider;
  final bool isUpdate;
  final DateTime date;
  const StepOneContent({
    Key? key,
    required this.dropdownProvider,
    required this.isUpdate,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Consumer<MastersProvider>(
          builder: (context, provider, child) {
            if (provider.shiftLoaded) {
              return const Center(child: const CircularProgressIndicator());
            }

            final currentShift = provider.currentShift;
            if (currentShift == null) {
              return const Text('No hay turno asignado');
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text('Fecha y Hora de la Solicitud: ${provider.date}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
                Text('Turno actual: ${provider.shiftType}'),
                // Text('ID: ${currentShift.id}'),
              ],
            );
          },
        ),

        
        const SizedBox(height: 24),
        CustomDropdownButton<modelone.Value>(
          hintText: 'Sub Área (Tag Prefijo) *:',
          items: dropdownProvider.listPrefijos,
          selectedItem: dropdownProvider.currentValueTagPrefijo,
          onChanged: (v) => dropdownProvider.currentValueTagPrefijo = v!,
        ),
        CustomDropdownButton<modelone.Value>(
          hintText: 'Activo (Tag Centro) *:',
          items: dropdownProvider.listCentros,
          selectedItem: dropdownProvider.currentValueTagCentro,
          onChanged: (v) => dropdownProvider.currentValueTagCentro = v!,
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: dropdownProvider.currentTagSubfijo,
          onChanged: (v) => dropdownProvider.currentTagSubfijo = v,
          maxLength: 100,
          maxLines: 2,
          decoration: InputDecoration(
            labelText: 'Tag (Sufijo) *',
            hintText: isUpdate
                ? dropdownProvider.currentTagSubfijo
                : 'Ingrese el subfijo del tag',
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
        const SizedBox(height: 10),
        CustomDropdownButton<modelTwo.Value>(
          hintText: 'Circuito *:',
          items: dropdownProvider.listCircuitos,
          selectedItem: dropdownProvider.currentValueCircuitos,
          onChanged: (v) => dropdownProvider.currentValueCircuitos = v!,
        ),
        const SizedBox(height: 10),
        // Descripción (replicamos _inputDescription aquí)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Descripción *'),
            const SizedBox(height: 5),
            TextFormField(
              initialValue: dropdownProvider.currentValueDescription,
              onChanged: (v) => dropdownProvider.currentValueDescription = v,
              maxLength: 100,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Agregue una descripción',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomDropdownButton<modelTwo.Value>(
          hintText: 'Disciplina *:',
          items: dropdownProvider.listDiciplinas,
          selectedItem: dropdownProvider.currentValueTagDisciplina,
          onChanged: (v) => dropdownProvider.currentValueTagDisciplina = v!,
        ),
      ],
    );
  }
}
