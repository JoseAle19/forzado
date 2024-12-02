// import 'package:flutter/material.dart';

// class InterlockDrop extends StatelessWidget {
//   InterlockDrop({super.key, required this.onChanged});
//   String currentValue;
//   final ValueChanged<String> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Iterlock Seguridad *'),
//                           DropdownButtonFormField(
//                             value: null,
//                             hint: const Text('Seleccione Interlock'),
//                             items: const [
//                               DropdownMenuItem(value: 'si', child: Text('Si')),
//                               DropdownMenuItem(value: 'NO', child: Text('No')),
//                             ],
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Seleccione una opcion';
//                               }
//                               return '';
//                             },
//                             onChanged: (value) {
//                               // Todo: rear logica despues
//                             },
//                           ),
//                         ],
//                       );
//   }
// }