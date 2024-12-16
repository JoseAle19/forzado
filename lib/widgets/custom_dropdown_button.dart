import 'package:flutter/material.dart';
import 'package:forzado/core/abstract/dropdown_item.dart';

class CustomDropdownButton<T extends DropDownItem> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;

  const CustomDropdownButton(
      {super.key,
      required this.hintText,
      required this.items,
      this.selectedItem,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedItem??null,
      hint: Text(hintText),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.getLabel()),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      validator: (value) {
        if (value == null){
          return 'Selecciona una opcion';
        }
      },
    );
  }
}
