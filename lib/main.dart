import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:forzado/adapters/adapter_forzados.dart';
import 'package:forzado/adapters/adapter_matriz_riesgo.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_shifts.dart';
import 'package:forzado/adapters/adapter_tag_forzado.dart';
import 'package:forzado/adapters/adapter_tags.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/forzado.dart';
import 'package:forzado/adapters/forzado_baja.dart';
import 'package:forzado/adapters/staff_position.dart';
import 'package:forzado/adapters/user_adapter.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/Stepper/stepper_provider.dart';
import 'package:forzado/data/providers/auth/auth_provider.dart';
import 'package:forzado/data/providers/auth/password_provider.dart';
import 'package:forzado/data/providers/bottom/bottom_navigationbar_provider.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider_off.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/data/providers/offline/list_forzados_ejecutados_provider.dart';
import 'package:forzado/data/providers/requester_provider.dart';
import 'package:forzado/data/providers/splash_provider.dart';
import 'package:forzado/data/providers/users/user_provider.dart';
import 'package:forzado/home_page.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/pages/aprobador/provider/forzados_provider.dart';
import 'package:forzado/pages/ejecutor/provider/forzados_provider.dart';
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
  Hive.registerAdapter(ForzadosAdapter());
  Hive.registerAdapter(ForzadoBajaAdapter());
  Hive.registerAdapter(AdapterUserAdapter());
  Hive.registerAdapter(AdapterTagsAdapter());
  Hive.registerAdapter(AdapterMatrizRiesgoAdapter());
  Hive.registerAdapter(AdapterTagForzadoAdapter());
  Hive.registerAdapter(PuestoValueAdapter());

  Hive.registerAdapter(ForzadoAdapter());
  // Abre las cajas para cada modelo
  await Hive.openBox<AdapterOne>('TagPrefijo');
  await Hive.openBox<AdapterOne>('TagCentro');

  await Hive.openBox<AdapterTwo>('Disciplina');
  await Hive.openBox<AdapterTwo>('Turno');
  await Hive.openBox<AdapterTwo>('grupo-ejecucion');
  // este es el de riesgoA
  await Hive.openBox<AdapterTwo>('Riesgo');
  // este adapter es el dropdown el que no es editable
  await Hive.openBox<AdapterMatrizRiesgo>('matriz-riesgo');
  await Hive.openBox<AdapterTagForzado>('tags-matriz-riesgo');
  Hive.registerAdapter(ShiftValueAdapter());


  
  await Hive.openBox<ShiftValue>('shiftBox');
  await Hive.openBox<PuestoValue>('staffPosition');

  await Hive.openBox<AdapterTwo>('Probabilidad');
  await Hive.openBox<AdapterTwo>('Impacto');
  await Hive.openBox<AdapterTwo>('Tipo');
  await Hive.openBox<AdapterTwo>('circuitos');

  await Hive.openBox<AdapterThree>('Responsable');
  await Hive.openBox<AdapterThree>('Solicitante');
  await Hive.openBox<AdapterThree>('Aprobador');
  await Hive.openBox<AdapterThree>('Ejecutor');
  await Hive.openBox<AdapterUser>('users');
  await Hive.openBox<ForzadoBaja>('forzadoBajaBox');
  await Hive.openBox<Forzados>('Forzados');

  await Hive.openBox<Forzado>('Forzado');

  await Hive.openBox('isEnabledRuleRisk');
  await Hive.openBox<AdapterTags>(HiveBoxes.tags);
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
        ChangeNotifierProvider(
            create: (_) => ForzadosProvider()
              ..fetchCountForzados() 
              ..getForzados()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (_) => DropdownProviderManagerOffline()),
        ChangeNotifierProvider(create: (_) => StepperProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ForzadosProviderAjecutor()),
        ChangeNotifierProvider(create: (_) => ForzadosProviderApprove()),
        ChangeNotifierProvider(create: (_) => MastersProvider()),
        ChangeNotifierProxyProvider<MastersProvider,
            DropDownValuesManagerProvider>(
          create: (context) {
            final mastersProvider =
                Provider.of<MastersProvider>(context, listen: false);
            return DropDownValuesManagerProvider(mastersProvider)..initialize();
          },
          update: (context, mastersProvider, dropDownManager) {
            if (dropDownManager == null) {
              return DropDownValuesManagerProvider(mastersProvider)
                ..initialize();
            }
            return dropDownManager..updateMastersProvider(mastersProvider);
          },
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'NotoSans'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', ''),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Forzados',
          home: const HomePage()),
    );
  }
}
