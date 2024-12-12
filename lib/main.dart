import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/forzado.dart';
import 'package:forzado/adapters/forzado_baja.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/data/providers/auth/password_provider.dart';
import 'package:forzado/data/providers/offline/list_forzados_ejecutados_provider.dart';
import 'package:forzado/data/providers/requester_provider.dart';
import 'package:forzado/data/providers/splash_provider.dart';
import 'package:forzado/home_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesHelper().init();
  await Hive.initFlutter();
  Hive.registerAdapter(AdapterOneAdapter());
  Hive.registerAdapter(AdapterTwoAdapter());
  Hive.registerAdapter(AdapterThreeAdapter());
  Hive.registerAdapter(ForzadoAdapter());
  Hive.registerAdapter(ForzadosAdapter());
  Hive.registerAdapter(ForzadoBajaAdapter());

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
  await Hive.openBox<ForzadoBaja>('forzadoBajaBox');
  await Hive.openBox<Forzados>('Forzados');

  await initializeDateFormatting('es_ES', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkSession()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => RequesterHomeProvider()),
        ChangeNotifierProvider(create: (_) => PasswordProvider()),
        ChangeNotifierProvider(create: (_) => ListForzadosEjecutadosProvider()),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Forzados',
          home: HomePage()),
    );
  }
}
