import 'package:flutter/material.dart';

class BajasForzadoOffline extends StatelessWidget {
  const BajasForzadoOffline({super.key});

  // Future<void> getRequestBajas() async {
  //   final box = await Hive.box<ForzadoBaja>('forzadoBajaBox');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Lista de forzados baja pendientes de sincronizar'),
        ));
  }
}