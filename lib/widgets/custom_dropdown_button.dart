import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/abstract/dropdown_item.dart';

class CustomDropdownButton<T extends DropDownItem> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final Color textColor;
  final Color backgroundColor;

  const CustomDropdownButton({
    super.key,
    required this.hintText,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
          
          ),
          const SizedBox(
            height: 5,
          ),
          DropdownButtonFormField<T>(
            value: selectedItem,
            hint: const Text(
              'Selecciona una opción',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
             
            ),
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    ' ${utf8.decode(latin1.encode(
                          item.getCode(),
                        ), allowMalformed: true)} ${utf8.decode(latin1.encode(
                          item.getLabel(),
                        ), allowMalformed: true)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: textColor),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade600),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            ),
            validator: (value) {
              if (value == null) {
                return 'Este campo es requerido';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
