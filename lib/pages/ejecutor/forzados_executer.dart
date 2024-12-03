import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/ejecutor/detail_forzado.dart';
import 'package:forzado/pages/ejecutor/home_executor.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/remove_forzado/list_service_remove.dart';

class ListExecuterForzado extends StatelessWidget {
  const ListExecuterForzado({super.key, required this.isExecuterAlta});
final bool isExecuterAlta;
  @override
  Widget build(BuildContext context) {
    final ListServiceForzados _listServiceForzados =
        ListServiceForzados(ApiClient());


  


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          final route = MaterialPageRoute(builder: (_)=>HomeExecuter());
          Navigator.push(context, route);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text('Listado de Forzados'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implementar el evento para abrir el filtro
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: FutureBuilder<ModelListForzados>(
        future: _listServiceForzados.getDataByEndpoint(AppUrl.getListForzados).then(
            (value) {
              List<ForzadoM> data = value.data
                  .where((element) => element.estado == 'aprobado-alta')
                  .toList();
              return ModelListForzados(
                success: value.success,
                message: value.message,
                data: data,
              );
            },
          ),
        builder:
            (BuildContext context, AsyncSnapshot<ModelListForzados> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Ocurrio un error, contacte a soporte');
          }
          if (snapshot.data == null) {
            return Text('No hay datos disponibles');
          }

          ModelListForzados data = snapshot.data!;
          return ListView.separated(
            itemCount: data.data.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              ForzadoM forzado = snapshot.data!.data[index];
              return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          child: Text(forzado.nombre.substring(0, 1)),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        title: Text(
          forzado.id.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "Área: ${forzado.area ?? 'No especificada'}\n"
          "Solicitante: ${forzado.solicitante ?? 'No especificado'}\n"
          "Estado: ${forzado.estado ?? 'No especificado'}",
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(onPressed: (){
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailForzadoScreen(forzado: forzado, isExecuterAlta: isExecuterAlta,),
              ));
          
        }, icon: const Icon(Icons.arrow_forward_ios))
      ),
    );
            },
          );
        },
      ),
    );
  }
}
