import 'package:flutter/material.dart';


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
