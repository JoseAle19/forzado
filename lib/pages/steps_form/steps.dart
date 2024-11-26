import 'package:flutter/material.dart';
import 'package:forzado/widgets/custom_ropdown_button.dart';
import 'package:forzado/widgets/line_step.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          'IPERC',
          style: TextStyle(fontFamily: 'noto'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linea de los steps
              CustomStepper(),
              // Titulo de las inspecciones
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Tag y Subfijo',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'noto',
                      color: Color(0xff0F2851)),
                ),
              ),
              // DropDown Buttons
              const CustomDropDownButton(
                hintText: 'Prefijo del Tag o Sub Área',
                descriptionField: 'Tag (Prefijo)*',
              ),
              const CustomDropDownButton(
                hintText:
                    'Parte Central  del Tag Asoc. al instrumento o Equipo',
                descriptionField: 'Tag (Centro) *',
              ),

              const CustomDropDownButton(
                hintText: 'SubFijo del Tag',
                descriptionField: 'Tag (Sub Fijo) *',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Descripción *'),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Agregar descripción',
                    ),
                  ),
                ],
              ),

              const CustomDropDownButton(
                hintText: 'Disciplina que solicita el Forzado',
                descriptionField: 'Disciplina *',
              ),

              const CustomDropDownButton(
                hintText: 'Disciplina que solicita el Forzado',
                descriptionField: 'Turno *',
              ),

              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff009283),
                    borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'noto',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
