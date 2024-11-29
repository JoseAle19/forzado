import 'package:flutter/material.dart';
import 'package:forzado/models/center_model.dart';
import 'package:forzado/services/center_service.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {super.key,
      required this.descriptionField,
      required this.hintText,
      this.service});
  final String descriptionField;
  final String hintText;
  final CenterService? service;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String currentValue = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(widget.descriptionField),
        FutureBuilder(
          future: widget.service!.getTagCentros(),
          builder: (BuildContext context, AsyncSnapshot<CenterModel> snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!.values;
              return DropdownButtonFormField(
                  value: currentValue.isEmpty ? null : currentValue,
                  hint: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        widget.hintText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                  items: items.map((item) {
                    return DropdownMenuItem(
                        value: item.id.toString(),
                        child: Text(item.descripcion));
                  }).toList(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Selecciona una opción';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      currentValue = value!;
                    });
                  });
            } else {
              // Retornar DropdownButton por default
              return DropdownButtonFormField(
                value: currentValue.isEmpty ? null : currentValue,
                onChanged: (newValue) {},
                items: const [
                  DropdownMenuItem(
                    value: 'opc1',
                    child: Text('Seleccione un centro'),
                  )
                ],
                hint: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      widget.hintText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
              );
            }
          },
        ),
      ],
    );
  }
}
