import 'package:flutter/material.dart';
import 'package:forzado/core/abstract/drop_menu_item.dart';

class CustomDropDownButton<T extends DropDownItem> extends StatelessWidget {
  final String descriptionField;
  final String hintText;
  final List<T> items;
  final String currentValue;
  final ValueChanged<String?> onChanged;

  const CustomDropDownButton({
    Key? key,
    required this.descriptionField,
    required this.hintText,
    required this.items,
    required this.currentValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(descriptionField),
        DropdownButtonFormField<String>(
          value: currentValue.isEmpty ? null : currentValue,
          hint: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              hintText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item.id.toString(),
              child: SizedBox(
                width: 200,
                child: Text(
                  item.getLabel(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          }).toList(),
          validator: (value) =>
              value == null ? 'Seleccione una opción válida' : null,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
