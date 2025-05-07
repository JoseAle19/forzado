// step_two.dart
import 'package:flutter/material.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:provider/provider.dart';

class StepTwoContent extends StatelessWidget {
  final DropDownValuesManagerProvider dropdownProvider;
  final bool isUpdate;
  final DateTime date;
  const StepTwoContent({
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
        const SizedBox(height: 10,),
        const Text('¿Es Interlock? *'),
        DropdownButtonFormField<String>(
          value: dropdownProvider.currentValueInterlock.isEmpty
              ? null
              : dropdownProvider.currentValueInterlock,
          hint: const Text('Seleccione Interlock'),
          items: const [
            DropdownMenuItem(value: 'si', child: Text('Si')),
            DropdownMenuItem(value: 'NO', child: Text('No')),
          ],
          onChanged: (v) {
            dropdownProvider.currentValueInterlock = v!;
            dropdownProvider.validateInterlok();
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 20),
        CustomDropdownButton<modelThree.Value>(
          hintText: 'Responsable *:',
          items: dropdownProvider.listResponsables,
          selectedItem: dropdownProvider.currentStateResponsibility,
          onChanged: (v) => dropdownProvider.currentStateResponsibility = v!,
        ),
        CustomDropdownButton<modelTwo.Value>(
          hintText: 'Riesgo a *:',
          items: dropdownProvider.listRiesgos,
          selectedItem: dropdownProvider.currentStateRisk,
          onChanged: (v) {
            dropdownProvider.currentStateRisk = v!;
            dropdownProvider.defineInterlockbyRiskA();
          },
        ),
        CustomDropdownButton<modelTwo.Value>(
          hintText: 'Probabilidad *:',
          items: dropdownProvider.listProbabilidades,
          selectedItem: dropdownProvider.currentStateProbability,
          onChanged: (v) {
            if (!(dropdownProvider.isEnabledRuletagMatriz && isUpdate)) {
              dropdownProvider.currentStateProbability = v!;
              if (dropdownProvider.isEnabledRuleRisk) {
                // dropdownProvider.defineRisk();
              }
            }
          },
        ),
        const SizedBox(height: 10),
        CustomDropdownButton<modelTwo.Value>(
          hintText: 'Impacto *:',
          items: dropdownProvider.listImpactos,
          selectedItem: dropdownProvider.currentStateImpact,
          onChanged: (v) {
            dropdownProvider.currentStateImpact = v!;
            // dropdownProvider.defineRisk();
          },
        ),
        const SizedBox(height: 10),
       AbsorbPointer(
  absorbing: true, // Esto deshabilita todas las interacciones
  child: Opacity(
    opacity: 0.7, // Le da un efecto de deshabilitado
    child: CustomDropdownButton<modelTwo.Value>(
      hintText: 'Riesgo *:',
      items: dropdownProvider.riskLevels,
      selectedItem: dropdownProvider.currentRisk,
      backgroundColor:
          dropdownProvider.currentRisk?.descripcion.toLowerCase() == 'bajo'
              ? const Color(0xffBBF7D0)
              : dropdownProvider.currentRisk?.descripcion.toLowerCase() ==
                      'moderado'
                  ? const Color(0xffFEF08A)
                  : dropdownProvider.currentRisk?.descripcion
                              .toLowerCase() ==
                          'alto'
                      ? const Color(0xffEF4444)
                      : Colors.transparent,
      textColor:
          dropdownProvider.currentRisk?.descripcion.toLowerCase() == 'alto'
              ? Colors.white
              : Colors.black,
      onChanged: (value) => null,
    ),
  ),
)
      ],
    );
  }
}
