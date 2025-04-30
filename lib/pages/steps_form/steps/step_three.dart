// step_three.dart
import 'package:flutter/material.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:provider/provider.dart';

class StepThreeContent extends StatelessWidget {
  final DropDownValuesManagerProvider dropdownProvider;
  final bool isUpdate;
  final DateTime date;

  const StepThreeContent({
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
                Text(
                  'Fecha y Hora de la Solicitud: ${provider.date}',
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
        CustomDropdownButton<modelThree.Value>(
          hintText: 'Solicitante (AN) *:',
          items: dropdownProvider.listSolicitantes,
          selectedItem: dropdownProvider.currentStateApplicant,
          onChanged: (v) => dropdownProvider.currentStateApplicant = v!,
        ),
        CustomDropdownButton<modelThree.Value>(
          hintText: 'Aprobador *:',
          items: dropdownProvider.listAprobadores,
          selectedItem: isUpdate ? dropdownProvider.currentStateApprover : null,
          onChanged: (v) => dropdownProvider.currentStateApprover = v!,
        ),
        CustomDropdownButton<modelTwo.Value>(
          hintText: 'Grupo de Ejecución *:',
          items: dropdownProvider.listGrupos,
          selectedItem: dropdownProvider.currentStateGrupo,
          onChanged: (v) => dropdownProvider.currentStateGrupo = v!,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fecha fin planificada:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                dropdownProvider.date,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => dropdownProvider.selectDate(context),
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Seleccionar Fecha'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
