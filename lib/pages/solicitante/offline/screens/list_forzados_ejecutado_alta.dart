import 'package:flutter/material.dart';
import 'package:forzado/data/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ListForzadosEjecutadoAlta extends StatelessWidget {
  const ListForzadosEjecutadoAlta({super.key});

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
      body: SizedBox(),
    );
  }
}
