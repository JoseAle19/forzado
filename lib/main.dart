import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/forzado.dart';
import 'package:forzado/home_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdapterOneAdapter());
  Hive.registerAdapter(AdapterTwoAdapter());
  Hive.registerAdapter(AdapterThreeAdapter());
  Hive.registerAdapter(ForzadoAdapter());

  // Abre las cajas para cada modelo
  await Hive.openBox<AdapterOne>('TagPrefijo');
  await Hive.openBox<AdapterOne>('TagCentro');

  await Hive.openBox<AdapterTwo>('Disciplina');
  await Hive.openBox<AdapterTwo>('Turno');
  await Hive.openBox<AdapterTwo>('Riesgo');
  await Hive.openBox<AdapterTwo>('Probabilidad');
  await Hive.openBox<AdapterTwo>('Impacto');
  await Hive.openBox<AdapterTwo>('Tipo');

  await Hive.openBox<AdapterThree>('Responsable');
  await Hive.openBox<AdapterThree>('Solicitante');
  await Hive.openBox<AdapterThree>('Aprobador');
  await Hive.openBox<AdapterThree>('Ejecutor');

  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Forzados', home: HomePage());
  }
}
