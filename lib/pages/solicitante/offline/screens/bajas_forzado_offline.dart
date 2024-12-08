import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:forzado/data/provider/auth_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class BajasForzadoOffline extends StatelessWidget {
  const BajasForzadoOffline({super.key});

  Future<List<Forzados>> getForzadosOffline() async {
    var box = await Hive.openBox<Forzados>('Forzados');
    return box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Text('Hola ${value.user?.name}');
          },
        ),
      ),
      body: FutureBuilder(
        future: getForzadosOffline(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Forzados>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono informativo
                  Icon(
                    Icons.hourglass_empty,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  // Título principal
                  Text(
                    'No tienes forzados disponibles',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Descripción adicional
                  Text(
                    'Los forzados con estado ejecutado alta \nestán en proceso. Por favor, espera.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox.shrink();
            },
            itemBuilder: (BuildContext context, int index) {
              Forzados forzado = snapshot.data![index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(forzado.id.toString()),
                ),
                title: Text(forzado.descripcion),
              );
            },
          );
        },
      ),
    );
  }
}
