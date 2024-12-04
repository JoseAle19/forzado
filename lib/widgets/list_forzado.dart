// import 'package:flutter/material.dart';
// import 'package:forzado/core/urls.dart';
// import 'package:forzado/models/remove_forzado/model_list_remove.dart';

// import 'package:forzado/services/api_client.dart';
// import 'package:forzado/services/remove_forzado/list_service_remove.dart';

// class ListForzadoBY extends StatelessWidget {
//   const ListForzadoBY({super.key, required this.stateForzado});
//   final String stateForzado;
//   @override
//   Widget build(BuildContext context) {
//     final ListServiceForzados _listServiceRemove =
//         ListServiceForzados(ApiClient());

//     late List<ForzadoM> listData;

//     return FutureBuilder<ModelListForzados>(
//       future: _listServiceRemove.getDataByEndpoint(AppUrl.getListForzados).then(
//         (value) {
//           List<ForzadoM> data = value.data
//               .where((element) => element.estado == stateForzado)
//               .toList();
//           return ModelListForzados(
//             success: value.success,
//             message: value.message,
//             data: data,
//           );
//         },
//       ),
//       builder:
//           (BuildContext context, AsyncSnapshot<ModelListForzados> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           print(snapshot.error);
//           return const Center(
//               child: Text('Ocurrio un error, contacta a soporte'));
//         }
//         if (snapshot.data!.data.isEmpty) {
//           return const Center(child: Text('No hay datos'));
//         }

//         final List<ForzadoM> data = snapshot.data!.data;
//         listData = data;
//         return Expanded(
//           child: ListApproveForzado(data: data),
//         );
//       },
//     );
//   }
// }
