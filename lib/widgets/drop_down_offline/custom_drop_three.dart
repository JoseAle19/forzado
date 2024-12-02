import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class CustomDropDownButtonThreeOff extends StatefulWidget {
  CustomDropDownButtonThreeOff({
    super.key,
    required this.descriptionField,
    required this.hintText,
    required this.currentValue,
    required this.onChanged,
    required this.box,
  });

  final String descriptionField;
  final String hintText;
  AdapterThree currentValue;
  final ValueChanged<AdapterThree> onChanged;
  final String box;
  @override
  State<CustomDropDownButtonThreeOff> createState() =>
      _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButtonThreeOff> {
  late Box<AdapterThree> boxAdapterThree;
  late List<AdapterThree> items = [];

  @override
  void initState() {
    super.initState();
    boxAdapterThree = Hive.box<AdapterThree>(widget.box);

    _loadDataFromHive();
    print(items);
  }

  void _loadDataFromHive() {
    setState(() {
      items = boxAdapterThree.values.toList();
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
            : DropdownButtonFormField<AdapterThree>(
                value: widget.currentValue.nombre.isEmpty
                    ? null
                    : widget.currentValue,
                hint: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      widget.hintText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                items: items.map((AdapterThree item) {
                  return DropdownMenuItem<AdapterThree>(
                      value: item,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          item.nombre,
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
