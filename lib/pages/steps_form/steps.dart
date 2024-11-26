import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  const Steps({super.key});

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
              LineSteps(),
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

// ignore: must_be_immutable
class LineSteps extends StatelessWidget {
  List steps = [1, 2, 3];

  LineSteps({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
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
          const BoxDecoration(shape: BoxShape.circle, color: Color(0xffA6A5A5)),
      child: Center(
        child: Text(
            style: const TextStyle(color: Colors.white, fontFamily: 'noto'),
            index.toString()),
      ),
    );
  }
}

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(
      {super.key, required this.descriptionField, required this.hintText});
  final String descriptionField;
  final String hintText;
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
            value: null,
            hint: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  hintText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
            items: const [
              DropdownMenuItem(
                  value: 'opc1', child: Text('Prefijo del Tag o Sub Área')),
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
