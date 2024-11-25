import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  const Steps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
             IconButton(onPressed: (){
              Navigator.pop(context);
             }, icon: const  Icon(Icons.arrow_back_ios)),
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
              LineSteps(),
              // Titulo de las inspecciones
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  'Identificación de la Tarea',
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'noto', color: Colors.black),
                ),
              ),
              // DropDown Buttons
              const CustomDropDownButton(
                descriptionField: 'Gerencia:',
              ),
              const CustomDropDownButton(
                descriptionField: 'Superintendencia:',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Supervisor Responsable del Trabajo'),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Supervisor ',
                    ),
                  ),
                ],
              ),
              const CustomDropDownButton(
                descriptionField: 'Lider de Equipo de Trabajo:',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Descripción de la Tarea'),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Supervisor ',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LineSteps extends StatelessWidget {
  List steps = [1, 2, 3];

  LineSteps({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Divider(
              color: Colors.grey,
              thickness: 5,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [for (var step in steps) _iconText(step)],
          )
        ],
      ),
    );
  }

  Widget _iconText(int index) {
    return Container(
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xffA6A5A5)),
      child: Center(
        child: Text(
            style: TextStyle(color: Colors.white, fontFamily: 'noto'),
            index.toString()),
      ),
    );
  }
}

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({super.key, required this.descriptionField});
  final String descriptionField;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(descriptionField),
        DropdownButtonFormField(
            value: 'opc1',
            hint: const Text('Selecciona una opcion'),
            items: const [
              DropdownMenuItem(value: 'opc1', child: Text('Opcion 1')),
              DropdownMenuItem(value: 'opc2', child: Text('Opcion 2')),
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Selecciona una opción';
              }
              return null;
            },
            onChanged: (value) {
              print(value);
            }),
      ],
    );
  }
}
