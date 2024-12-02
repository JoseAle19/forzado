import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class CustomDropDownButtonTwoOff extends StatefulWidget {
  CustomDropDownButtonTwoOff({
    super.key,
    required this.descriptionField,
    required this.hintText,
    required this.currentValue,
    required this.onChanged,
    required this.box,
  });

  final String descriptionField;
  final String hintText;
  AdapterTwo currentValue;
  final ValueChanged<AdapterTwo> onChanged;
  final String box;
  @override
  State<CustomDropDownButtonTwoOff> createState() =>
      _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButtonTwoOff> {
  late Box<AdapterTwo> boxAdaptertwo;
  late List<AdapterTwo> items = [];

  @override
  void initState() {
    super.initState();
    boxAdaptertwo = Hive.box<AdapterTwo>(widget.box);
    _loadDataFromHive();
  }

  void _loadDataFromHive() {
    setState(() {
      items = boxAdaptertwo.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(widget.descriptionField),
        items.isEmpty
            ? const Text(
                'No hay información disponible. Por favor, contacta a soporte.')
            : DropdownButtonFormField<AdapterTwo>(
 value: widget.currentValue.descripcion.isEmpty ?null: widget.currentValue,                hint: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      widget.hintText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                items: items.map((AdapterTwo item) {
                  return DropdownMenuItem<AdapterTwo>(
                      value: item,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          item.descripcion,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ));
                }).toList(),
                validator: (value) =>
                    value == null ? 'Seleccione una opción válida' : null,
                onChanged: (value) {
                  setState(() {
                    widget.currentValue = value!;
                    widget.onChanged(value);
                  });
                },
              ),
      ],
    );
  }
}
