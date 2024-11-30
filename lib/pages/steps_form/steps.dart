// import 'package:flutter/material.dart';
// import 'package:forzado/core/urls.dart';
// import 'package:forzado/services/api_client.dart';
// import 'package:forzado/services/service_one.dart';
// import 'package:forzado/services/service_three.dart';
// import 'package:forzado/services/service_two.dart';
// import 'package:forzado/widgets/custom_dropdown_one.dart';
// import 'package:forzado/widgets/custom_dropdown_three.dart';
// import 'package:forzado/widgets/custom_dropdown_two.dart';

// class Steps extends StatefulWidget {
//   const Steps({super.key});

//   @override
//   State<Steps> createState() => _StepsState();
// }

// class _StepsState extends State<Steps> {
//   int currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.arrow_back_ios)),
//           title: const Text(
//             'IPERC',
//             style: TextStyle(fontFamily: 'noto'),
//           ),
//         ),
//         body: PageView(
//           scrollDirection: Axis.horizontal,
//           children: [
//             TabOne(),
//             TabTwo(),
//             TabThree(),
//           ],
//         ));
//   }
// }

// // ignore: must_be_immutable
// class TabOne extends StatelessWidget {
//   TabOne({super.key});
//   ServiceOne serviceOne = ServiceOne(ApiClient());
//   ServiceTwo serviceTwo = ServiceTwo(ApiClient());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Text(
//                 'Tag y Subfijo',
//                 style: TextStyle(
//                     fontSize: 18, fontFamily: 'noto', color: Color(0xff0F2851)),
//               ),
//             ),
//             // DropDown Buttons
//             CustomDropDownButtonOne(
//               endPoint: AppUrl.gettagPrefijo1,
//               service: serviceOne,
//               hintText: 'Prefijo del Tag o Sub Área',
//               descriptionField: 'Tag (Prefijo)*',
//             ),
//             CustomDropDownButtonOne(
//               endPoint: AppUrl.getTagCentro1,
//               service: serviceOne,
//               hintText: 'Parte Central  del Tag Asoc. al instrumento o Equipo',
//               descriptionField: 'Tag (Centro) *',
//             ),
         
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text('Descripción *'),
//                 TextFormField(
//                   maxLines: 5,
//                   decoration: const InputDecoration(
//                     hintText: 'Agregar descripción',
//                   ),
//                 ),
//               ],
//             ),

//             CustomDropDownButtonTwo(
//               endPoint: AppUrl.getTagDisciplina2,
//               service: serviceTwo,
//               hintText: 'Disciplina que solicita el Forzado',
//               descriptionField: 'Disciplina *',
//             ),

//             CustomDropDownButtonTwo(
//               endPoint: AppUrl.getTurno2,
//               service: serviceTwo,
//               hintText: 'Disciplina que solicita el Forzado',
//               descriptionField: 'Turno *',
//             ),

//             Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: const Color(0xff009283),
//                   borderRadius: BorderRadius.circular(15)),
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//               margin: const EdgeInsets.symmetric(vertical: 20),
//               child: const Text(
//                 'Continuar',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontFamily: 'noto',
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class TabTwo extends StatelessWidget {
//    TabTwo({super.key});
//   ServiceOne serviceOne = ServiceOne(ApiClient());
//   ServiceTwo serviceTwo = ServiceTwo(ApiClient());
//   ServiceThree serviceThree = ServiceThree(ApiClient());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Text(
//                 'Responsable y riesgo',
//                 style: TextStyle(
//                     fontSize: 18, fontFamily: 'noto', color: Color(0xff0F2851)),
//               ),
//             ),
//             // DropDown Buttons
//             DropdownButtonFormField(
//               value: null,
//               hint: const Text('Requiere Interlock'),
//               items: const [
//                 DropdownMenuItem(value: 'si', child: Text('Si')),
//                 DropdownMenuItem(value: 'NO', child: Text('No')),
//               ],
//               onChanged: (value) {
//                 // Todo: rear logica despues
//               },
//             ),
//             CustomDropDownButtonThree(
//               endPoint: AppUrl.getResponsable3,
//               service: serviceThree,
//               descriptionField: 'Responsable*',
//               hintText: 'Seleccione Gerencia Responsable del Forzado',
//             ),

//             CustomDropDownButtonTwo(
//               endPoint: AppUrl.getRiesgoA2,
//               service: serviceTwo,
//               descriptionField: 'Riesgo A*',
//               hintText: 'Riesgo',
//             ),

//             CustomDropDownButtonTwo(
//               endPoint: AppUrl.getProbabilidad2,
//               service: serviceTwo,
//               descriptionField: 'Probabilidad*',
//               hintText: 'Categoria de Consecuencias',
//             ),

//             CustomDropDownButtonTwo(
//               endPoint: AppUrl.getImpacto2,
//               service: serviceTwo,
//               descriptionField: 'Impacto*',
//               hintText: 'Seleccione Impacto de la Secuencia',
//             ),
//             // esta esta pendiente
//             CustomDropDownButtonTwo(
//               endPoint: AppUrl.getRiesgoA2,
//               service: serviceTwo,
//               descriptionField: 'Riesgo*',
//               hintText: 'Riesgo',
//             ),
//             Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: const Color(0xff009283),
//                   borderRadius: BorderRadius.circular(15)),
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//               margin: const EdgeInsets.symmetric(vertical: 20),
//               child: const Text(
//                 'Continuar',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontFamily: 'noto',
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class TabThree extends StatelessWidget {
//    TabThree({super.key});
//   ServiceOne serviceOne = ServiceOne(ApiClient());
//   ServiceTwo serviceTwo = ServiceTwo(ApiClient());
//   ServiceThree serviceThree = ServiceThree(ApiClient());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               child: Text(
//                 'Autorización',
//                 style: TextStyle(
//                     fontSize: 18, fontFamily: 'noto', color: Color(0xff0F2851)),
//               ),
//             ),
//             // DropDown Buttons
//             CustomDropDownButtonThree(
//               endPoint: AppUrl.getSolicitantes3,
//               service: serviceThree,
//               descriptionField: 'Solicitante (AN) *',
//               hintText: 'Seleccione Solicitante del Forzado',
//             ),
//             CustomDropDownButtonThree(
//               endPoint: AppUrl.getResponsable3,
//               service: serviceThree,
//               descriptionField: 'Aprobador *',
//               hintText: 'Seleccione Aprobador del Forzado',
//             ),

//             CustomDropDownButtonThree(
//               endPoint: AppUrl.getResponsable3,
//               service: serviceThree,
//               descriptionField: 'Ejecutor *',
//               hintText: 'Seleccione Ejecutor',
//             ),

//             CustomDropDownButtonThree(
//               endPoint: AppUrl.getResponsable3,
//               service: serviceThree,
//               descriptionField: 'Autorización *',
//               hintText: 'Carlos Meneses Garcia',
//             ),

//             CustomDropDownButtonThree(
//               endPoint: AppUrl.getResponsable3,
//               service: serviceThree,
//               descriptionField: 'Tipo de Forzado*',
//               hintText: 'Seleccione Tipo de Forzado',
//             ),

//             Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: const Color(0xff21378C),
//                   borderRadius: BorderRadius.circular(15)),
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//               margin: const EdgeInsets.symmetric(vertical: 20),
//               child: const Text(
//                 'Finalizar',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontFamily: 'noto',
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
