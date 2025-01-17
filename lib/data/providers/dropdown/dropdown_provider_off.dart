import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_tags.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/user_adapter.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/models/Boxes.dart';
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_three.dart' as modelthird;
import 'package:forzado/models/model_two.dart' as modeltwo;
import 'package:forzado/models/model_user_detail.dart';
import 'package:forzado/models/user/model_user.dart' as modeluser;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class DropdownProviderManagerOffline with ChangeNotifier {
// Getters y Setters para ModelOne
  List<modelone.Value> _listPrefijos = [];
  List<modelone.Value> _listCentros = [];

  List<modelone.Value> get listPrefijos => _listPrefijos;
  set listPrefijos(List<modelone.Value> value) {
    _listPrefijos = value;
  }

  List<modelone.Value> get listCentros => _listCentros;
  set listCentros(List<modelone.Value> value) {
    _listCentros = value;
  }

// Getters y Setters para ModelTwo
  List<modeltwo.Value> _listDiciplinas = [];
  List<modeltwo.Value> _listTurnos = [];
  List<modeltwo.Value> _listProbabilidades = [];
  List<modeltwo.Value> _listImpactos = [];
  List<modeltwo.Value> _listRiesgos = [];
  List<modeltwo.Value> _listTipoDeForzados = [];
  List<modeltwo.Value> _listprojects = [];

  List<modeltwo.Value> get listProjects => _listprojects;
  set listProjects(List<modeltwo.Value> value) {
    _listprojects = value;
  }

  List<modeltwo.Value> get listDiciplinas => _listDiciplinas;
  set listDiciplinas(List<modeltwo.Value> value) {
    _listDiciplinas = value;
  }

  List<modeltwo.Value> get listTurnos => _listTurnos;
  set listTurnos(List<modeltwo.Value> value) {
    _listTurnos = value;
  }

  List<modeltwo.Value> get listProbabilidades => _listProbabilidades;
  set listProbabilidades(List<modeltwo.Value> value) {
    _listProbabilidades = value;
  }

  List<modeltwo.Value> get listImpactos => _listImpactos;
  set listImpactos(List<modeltwo.Value> value) {
    _listImpactos = value;
  }

  List<modeltwo.Value> get listRiesgos => _listRiesgos;
  set listRiesgos(List<modeltwo.Value> value) {
    _listRiesgos = value;
  }

  List<modeltwo.Value> get listTipoDeForzados => _listTipoDeForzados;
  set listTipoDeForzados(List<modeltwo.Value> value) {
    _listTipoDeForzados = value;
  }

// Getters y Setters para ModelThird
  List<modelthird.Value> _listSolicitantes = [];
  List<modelthird.Value> _listResponsables = [];
  List<modelthird.Value> _listAprobadores = [];
  List<modelthird.Value> _listEjecutores = [];

  List<modelthird.Value> get listSolicitantes => _listSolicitantes;
  set listSolicitantes(List<modelthird.Value> value) {
    _listSolicitantes = value;
  }

  List<modelthird.Value> get listResponsables => _listResponsables;
  set listResponsables(List<modelthird.Value> value) {
    _listResponsables = value;
  }

  List<modelthird.Value> get listAprobadores => _listAprobadores;
  set listAprobadores(List<modelthird.Value> value) {
    _listAprobadores = value;
  }

  List<modelthird.Value> get listEjecutores => _listEjecutores;
  set listEjecutores(List<modelthird.Value> value) {
    _listEjecutores = value;
  }

  modelone.Value? _currentValueTagPrefijo;
  modelone.Value? _currentValueTagCentro;

  modeltwo.Value? _currentValueTagDisciplina;
  modeltwo.Value? _currentValueSlot;
  modeltwo.Value? _currentStateProbability;
  modeltwo.Value? _currentStateImpact;
  modeltwo.Value? _currentStateRisk;
  modeltwo.Value? _currentStateTypeForzado;
  modeltwo.Value? _currentStateProjectName;

  modelthird.Value? _currentStateApplicant;
  modelthird.Value? _currentStateResponsibility;
  modelthird.Value? _currentStateApprover;
  modelthird.Value? _currentStateExecutor;

  String _currentValueDescription = '';
  String _currentValueSubfijo = '';
  String _currentValueInterlock = '';
  modeltwo.Value? _currentRisk;

  modeltwo.Value? get currentRisk => _currentRisk;
  set currentRisk(modeltwo.Value? value) {
    _currentRisk = value;
    notifyListeners();
  }

  String get currentValueDescription => _currentValueDescription;
  set currentValueDescription(String value) {
    _currentValueDescription = value;
    notifyListeners();
  }

  String get currentValueSubfijo => _currentValueSubfijo;
  set currentValueSubfijo(String value) {
    _currentValueSubfijo = value;
    validateValues();
    notifyListeners();
  }

  String get currentValueInterlock => _currentValueInterlock;
  set currentValueInterlock(String value) {
    _currentValueInterlock = value;
    validateValues();
    notifyListeners();
  }

  // Getters para ModelOne
  modelone.Value? get currentValueTagPrefijo => _currentValueTagPrefijo;
  set currentValueTagPrefijo(modelone.Value? value) {
    _currentValueTagPrefijo = value;
    validateValues();
    notifyListeners();
  }

  modelone.Value? get currentValueTagCentro => _currentValueTagCentro;
  set currentValueTagCentro(modelone.Value? value) {
    _currentValueTagCentro = value;
    validateValues();
    notifyListeners();
  }

  // Getters para ModelTwo
  modeltwo.Value? get currentValueTagDisciplina => _currentValueTagDisciplina;
  set currentValueTagDisciplina(modeltwo.Value? value) {
    _currentValueTagDisciplina = value;
    notifyListeners();
  }

  modeltwo.Value? get currentValueSlot => _currentValueSlot;
  set currentValueSlot(modeltwo.Value? value) {
    _currentValueSlot = value;
    notifyListeners();
  }

  modeltwo.Value? get currentStateProbability => _currentStateProbability;
  set currentStateProbability(modeltwo.Value? value) {
    _currentStateProbability = value;
    validateValues();

    notifyListeners();
  }

  modeltwo.Value? get currentStateImpact => _currentStateImpact;
  set currentStateImpact(modeltwo.Value? value) {
    _currentStateImpact = value;
    validateValues();
    notifyListeners();
  }

  modeltwo.Value? get currentStateRisk => _currentStateRisk;
  set currentStateRisk(modeltwo.Value? value) {
    _currentStateRisk = value;
    validateValues();

    notifyListeners();
  }

  modeltwo.Value? get currentStateTypeForzado => _currentStateTypeForzado;
  set currentStateTypeForzado(modeltwo.Value? value) {
    _currentStateTypeForzado = value;
    notifyListeners();
  }

  modeltwo.Value? get currentStateProjectName => _currentStateProjectName;
  set currentStateProjectName(modeltwo.Value? value) {
    _currentStateProjectName = value;
    notifyListeners();
  }

  // Getters para ModelThird
  modelthird.Value? get currentStateApplicant => _currentStateApplicant;
  set currentStateApplicant(modelthird.Value? value) {
    _currentStateApplicant = value;
    notifyListeners();
  }

  modelthird.Value? get currentStateResponsibility =>
      _currentStateResponsibility;
  set currentStateResponsibility(modelthird.Value? value) {
    _currentStateResponsibility = value;
    notifyListeners();
  }

  modelthird.Value? get currentStateApprover => _currentStateApprover;
  set currentStateApprover(modelthird.Value? value) {
    _currentStateApprover = value;
    notifyListeners();
  }

  modelthird.Value? get currentStateExecutor => _currentStateExecutor;
  set currentStateExecutor(modelthird.Value? value) {
    _currentStateExecutor = value;
    notifyListeners();
  }

  List<modeluser.Value> _usersOff = [];
  List<modeluser.Value> get usersOff => _usersOff;
  set usersOff(List<modeluser.Value> value) {
    _usersOff = value;
  }

// Limpiar los valores de los dropdown
  void clearValues() {
    _currentValueTagPrefijo = null;
    _currentValueTagCentro = null;
    _currentValueTagDisciplina = null;
    _currentValueSlot = null;
    _currentStateProbability = null;
    _currentStateImpact = null;
    _currentStateRisk = null;
    _currentStateTypeForzado = null;
    _currentStateApplicant = null;
    _currentStateResponsibility = null;
    _currentStateApprover = null;
    _currentStateExecutor = null;
    _currentValueDescription = '';
    _currentValueInterlock = '';
    _currentStateProjectName = null;
    _currentRisk = null;
    notifyListeners();
  }

// Mapa para definir el riesgo según el impacto y la probabilidad
  Map<String, Map<String, int>> riskMatrix = {
    'INSIGNIFICANTE': {
      'CASI SEGURO': 11,
      'PROBABLE': 7,
      'POSIBLE': 4,
      'IMPROBABLE': 2,
      'RARO': 1,
    },
    'MENOR': {
      'CASI SEGURO': 16,
      'PROBABLE': 12,
      'POSIBLE': 8,
      'IMPROBABLE': 5,
      'RARO': 3,
    },
    'MODERADO': {
      'CASI SEGURO': 20,
      'PROBABLE': 15,
      'POSIBLE': 13,
      'IMPROBABLE': 9,
      'RARO': 6,
    },
    'MAYOR': {
      'CASI SEGURO': 24,
      'PROBABLE': 22,
      'POSIBLE': 17,
      'IMPROBABLE': 14,
      'RARO': 10,
    },
    'EXTREMO': {
      'CASI SEGURO': 25,
      'PROBABLE': 23,
      'POSIBLE': 21,
      'IMPROBABLE': 19,
      'RARO': 18,
    },
  };

// Definir el riesgo según la probabilidad e impacto
  void defineRisk() async {
    if (currentStateImpact?.descripcion == null ||
        currentStateProbability?.descripcion == null) {
      return;
    }
    // Obtener los valores normalizados (en mayúsculas)
    final impact = currentStateImpact?.descripcion.toUpperCase();
    final probability = currentStateProbability?.descripcion.toUpperCase();
    final nivel = riskMatrix[impact]?[probability] ?? '';
    final res = riskLevels.firstWhere((element) => element.id == nivel);
    ApiResponseDetailUser? user = await PreferencesHelper().getUser();
    if (user == null) {
      return; // Salir si el usuario es nulo.
    }
    if (res.descripcion == 'BAJO' && currentValueInterlock == 'NO') {
      // Verificar si el usuario actual no está en la lista de aprobadores
      if (!_listAprobadores.any((element) => element.id == user.id)) {
        _listAprobadores.add(
            modelthird.Value(id: user.id, nombre: user.name, apePaterno: ''));
        notifyListeners();
      }
    } else {
      _listAprobadores.removeWhere((element) => element.id == user.id);
      notifyListeners();
    }
    _currentRisk = res;
  }

  void validateInterlok() async {
    ApiResponseDetailUser? user = await PreferencesHelper().getUser();
    if (currentValueInterlock == 'NO') {
      addArobbadoresByRole();
      if (user == null) {
        return;
      }
      if (!_listAprobadores.any((element) => element.id == user.id)) {
        _listAprobadores.add(
            modelthird.Value(id: user.id, nombre: user.name, apePaterno: ''));
      }
    } else {
      addAprobadoresByPuesto();
    }
    if (!_listAprobadores.contains(currentStateApprover)) {
      currentStateApprover = null;
    }

    notifyListeners();
  }

  void defineInterlockbyRiskA() {
    if (currentStateRisk!.descripcion.isEmpty) return;
    if (currentStateRisk!.descripcion.toLowerCase() == 'personas') {
      addAprobadoresByPuesto();
    } else {
      addArobbadoresByRole();
    }
    notifyListeners();
  }

  bool isEnabledInterlock() {
    return currentStateRisk?.descripcion.toLowerCase() ==
            'personas'.toLowerCase()
        ? false
        : true;
  }

  void addAprobadoresByPuesto() {
    _listAprobadores.clear();
    for (var i = 0; i < _usersOff.length; i++) {
      if (_usersOff[i].puestoDescripcion!.toLowerCase() ==
          "GERENTE PLANTA PROCESO".toLowerCase()) {
        _listAprobadores.add(modelthird.Value(
          id: _usersOff[i].id!,
          nombre:
              '${_usersOff[i].nombre!} ${_usersOff[i].apePaterno!} ${_usersOff[i].apeMaterno!}',
        ));
      }
    }
  }

  void addArobbadoresByRole() {
    listAprobadores.clear();
    for (var i = 0; i < _usersOff.length; i++) {
      if (_usersOff[i].roles!.containsKey('2')) {
        listAprobadores.add(modelthird.Value(
          id: _usersOff[i].id!,
          nombre:
              '${_usersOff[i].nombre!} ${_usersOff[i].apePaterno!} ${_usersOff[i].apeMaterno!}',
        ));
      }
    }
  }

  // Lista manual de combinaciones de riesgo (basado en la tabla de tu imagen)
  final List<modeltwo.Value> _riskLevels = [
    modeltwo.Value(id: 1, descripcion: 'ALTO'),
    modeltwo.Value(id: 11, descripcion: 'MODERADO'),
    modeltwo.Value(id: 7, descripcion: 'BAJO'),
    modeltwo.Value(id: 4, descripcion: 'BAJO'),
    modeltwo.Value(id: 2, descripcion: 'BAJO'),
    modeltwo.Value(id: 1, descripcion: 'BAJO'),
    modeltwo.Value(id: 16, descripcion: 'MENOR MODERADO'),
    modeltwo.Value(id: 12, descripcion: 'MODERADO'),
    modeltwo.Value(id: 8, descripcion: 'MODERADO'),
    modeltwo.Value(id: 5, descripcion: 'BAJO'),
    modeltwo.Value(id: 3, descripcion: 'BAJO'),
    modeltwo.Value(id: 20, descripcion: 'MODERADO ALTO'),
    modeltwo.Value(id: 15, descripcion: 'MODERADO'),
    modeltwo.Value(id: 9, descripcion: 'MODERADO'),
    modeltwo.Value(id: 6, descripcion: 'BAJO'),
    modeltwo.Value(id: 3, descripcion: 'BAJO'),
    modeltwo.Value(id: 24, descripcion: 'MAYOR ALTO'),
    modeltwo.Value(id: 22, descripcion: 'ALTO'),
    modeltwo.Value(id: 17, descripcion: 'MODERADO'),
    modeltwo.Value(id: 14, descripcion: 'MODERADO'),
    modeltwo.Value(id: 10, descripcion: 'MODERADO'),
    modeltwo.Value(id: 25, descripcion: 'EXTREMO ALTO'),
    modeltwo.Value(id: 23, descripcion: 'ALTO'),
    modeltwo.Value(id: 21, descripcion: 'ALTO'),
    modeltwo.Value(id: 19, descripcion: 'ALTO'),
    modeltwo.Value(id: 18, descripcion: 'ALTO'),
    modeltwo.Value(id: 13, descripcion: 'MODERADO'),
  ];
  List<modeltwo.Value> get riskLevels => _riskLevels;

  List<modelone.Value> convertList(List<AdapterOne> list) {
    return list
        .map((item) => modelone.Value(
            id: item.id, descripcion: item.descripcion, codigo: item.codigo))
        .toList();
  }

  List<modeltwo.Value> convertListTwo(List<AdapterTwo> value) {
    return value
        .map((item) =>
            modeltwo.Value(id: item.id, descripcion: item.descripcion))
        .toList();
  }

  List<modelThree.Value> ConvertListThree(List<AdapterThree> value) {
    return value
        .map((item) => modelThree.Value(id: item.id, nombre: item.nombre))
        .toList();
  }

  Future<void> getDataHive() async {
    try {
      // Obtener datos desde Hive
      final listProjectsBox =
          Hive.box<AdapterTwo>(HiveBoxes.projects).values.toList();
      print('Proyectos ${listProjectsBox}');
      final listPrefijosBox =
          Hive.box<AdapterOne>(HiveBoxes.tagPrefijo).values.toList();
      final listCentrosBox =
          Hive.box<AdapterOne>(HiveBoxes.tagCentro).values.toList();
      final listDisciplinasBox =
          Hive.box<AdapterTwo>(HiveBoxes.disciplina).values.toList();
      final listTurnosBox =
          Hive.box<AdapterTwo>(HiveBoxes.turno).values.toList();
      final listResponsablesBox =
          Hive.box<AdapterThree>(HiveBoxes.responsable).values.toList();
      final listRiesgosABox =
          Hive.box<AdapterTwo>(HiveBoxes.riesgo).values.toList();
      final listProbabilidadesBox =
          Hive.box<AdapterTwo>(HiveBoxes.probabilidad).values.toList();
      final listImpactosBox =
          Hive.box<AdapterTwo>(HiveBoxes.impacto).values.toList();
      final listSolicitantesBox =
          Hive.box<AdapterThree>(HiveBoxes.solicitante).values.toList();
      final listAprobadoresBox =
          Hive.box<AdapterThree>(HiveBoxes.aprobador).values.toList();
      final listEjecutoresBox =
          Hive.box<AdapterThree>(HiveBoxes.ejecutor).values.toList();
      final listTipodeForzadosBox =
          Hive.box<AdapterTwo>(HiveBoxes.tipo).values.toList();
      final listUsersBox =
          Hive.box<AdapterUser>(HiveBoxes.users).values.toList();

      // Procesar datos obtenidos
      listProjects = convertListTwo(listProjectsBox);
      listPrefijos = convertList(listPrefijosBox);
      listCentros = convertList(listCentrosBox);
      listDiciplinas = convertListTwo(listDisciplinasBox);
      listTurnos = convertListTwo(listTurnosBox);
      listResponsables = ConvertListThree(listResponsablesBox);
      listRiesgos = convertListTwo(listRiesgosABox);
      listProbabilidades = convertListTwo(listProbabilidadesBox);
      listImpactos = convertListTwo(listImpactosBox);
      listSolicitantes = ConvertListThree(listSolicitantesBox);
      listAprobadores = ConvertListThree(listAprobadoresBox);
      listEjecutores = ConvertListThree(listEjecutoresBox);
      listTipoDeForzados = convertListTwo(listTipodeForzadosBox);
      usersOff = listUsersBox.map((u) {
        return modeluser.Value(
          id: u.id,
          apeMaterno: u.apeMaterno,
          apePaterno: u.apePaterno, // Corregido
          areaDescripcion: u.areaDescripcion,
          areaId: u.areaId,
          correo: u.correo,
          dni: u.dni,
          estado: u.estado,
          nombre: u.nombre,
          puestoDescripcion: u.puestoDescripcion,
          puestoId: u.puestoId,
          rolDescripcion: u.rolDescripcion,
          rolId: u.rolId,
          roles: u.roles,
          usuario: u.usuario,
        );
      }).toList();
      print('not error');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> clearAndPopulateBoxes(BuildContext context) async {
    final valuesDropdownOn =
        Provider.of<DropDownValuesManagerProvider>(context, listen: false);

    valuesDropdownOn.verifyRuleRisk();
    valuesDropdownOn.getTagsMatrizRiesgo(context);

    await populateBox(
        HiveBoxes.projects,
        valuesDropdownOn.listProjects.map((i) {
          return AdapterTwo(id: i.id, descripcion: i.descripcion);
        }).toList());

    await populateBox(
        HiveBoxes.tagPrefijo,
        valuesDropdownOn.listPrefijos.map((i) {
          return AdapterOne(
              codigo: i.codigo, descripcion: i.descripcion, id: i.id);
        }).toList());

    await populateBox(
        HiveBoxes.tagCentro,
        valuesDropdownOn.listCentros.map((i) {
          return AdapterOne(
              codigo: i.codigo, descripcion: i.descripcion, id: i.id);
        }).toList());

    await populateBox(
        HiveBoxes.disciplina,
        valuesDropdownOn.listDiciplinas.map((i) {
          return AdapterTwo(id: i.id, descripcion: i.descripcion);
        }).toList());

    await populateBox(
        HiveBoxes.turno,
        valuesDropdownOn.listTurnos.map((i) {
          return AdapterTwo(id: i.id, descripcion: i.descripcion);
        }).toList());
    await populateBox(
        HiveBoxes.responsable,
        valuesDropdownOn.listResponsables.map((i) {
          return AdapterThree(id: i.id, nombre: '${i.nombre} ${i.apePaterno}');
        }).toList());

    await populateBox(
        HiveBoxes.riesgo,
        valuesDropdownOn.listRiesgos.map((i) {
          return AdapterTwo(id: i.id, descripcion: i.descripcion);
        }).toList());

    await populateBox(
        HiveBoxes.probabilidad,
        valuesDropdownOn.listProbabilidades.map((i) {
          return AdapterTwo(id: i.id, descripcion: i.descripcion);
        }).toList());

    await populateBox(
        HiveBoxes.impacto,
        valuesDropdownOn.listImpactos.map((i) {
          return AdapterTwo(id: i.id, descripcion: i.descripcion);
        }).toList());

    await populateBox(
        HiveBoxes.tipo,
        valuesDropdownOn.listTipoDeForzados.map((i) {
          return AdapterTwo(id: i.id, descripcion: i.descripcion);
        }).toList());

    await populateBox(
        HiveBoxes.solicitante,
        valuesDropdownOn.listSolicitantes.map((i) {
          return AdapterThree(id: i.id, nombre: '${i.nombre} ');
        }).toList());

    await populateBox(
        HiveBoxes.aprobador,
        valuesDropdownOn.listAprobadores.map((i) {
          return AdapterThree(id: i.id, nombre: '${i.nombre} ');
        }).toList());

    await populateBox(
        HiveBoxes.ejecutor,
        valuesDropdownOn.listEjecutores.map((i) {
          return AdapterThree(id: i.id, nombre: '${i.nombre} ');
        }).toList());

    await populateBox(
        HiveBoxes.users,
        valuesDropdownOn.users.map((i) {
          return AdapterUser(
            id: i.id,
            apeMaterno: i.apeMaterno,
            apePaterno: i.apePaterno,
            areaDescripcion: i.areaDescripcion,
            areaId: i.areaId,
            correo: i.correo,
            dni: i.dni,
            estado: i.estado,
            nombre: i.nombre,
            puestoDescripcion: i.puestoDescripcion,
            puestoId: i.puestoId,
            rolDescripcion: i.rolDescripcion,
            rolId: i.rolId,
            roles: i.roles,
            usuario: i.usuario,
          );
        }).toList());

    notifyListeners();
  }

  Future<void> populateBox<T>(String boxName, List<T> data) async {
    try {
      final box = Hive.box<T>(boxName);
      await box.clear();
      await box.addAll(data);
    } catch (e, stackTrace) {
      print('Error al poblar la caja $boxName: $e');
      print('StackTrace: $stackTrace');
    }
  }
  bool _isEnabledRuletagMatriz = false;
  bool get isEnabledRuletagMatriz => _isEnabledRuletagMatriz;

  void validateValues() async {
 if (currentValueTagPrefijo == null ||
        currentValueTagCentro == null ||
        currentValueSubfijo == '') {
      return;
    }

    final idSubArea = currentValueTagPrefijo!.id;
    final idTagCentro = currentValueTagCentro!.id;
    final subfijo = currentValueSubfijo;







      if (!Hive.isBoxOpen(HiveBoxes.tags)) return;
      final tagsBox = Hive.box<AdapterTags>(HiveBoxes.tags);
      final List<AdapterTags> tags = tagsBox.values.toList();
      // Verificar si la regla de riesgo bajo está habilitada
      final isRiskEnabled = Hive.isBoxOpen('isEnabledRuleRisk')
          ? Hive.box('isEnabledRuleRisk').get('isRuleRiskActive')
          : false;
  final tag = tags.firstWhere(
      (tag) =>
          tag.prefijoId == idSubArea &&
          tag.centroId == idTagCentro &&
          tag.sufijo == subfijo,
      orElse: () => AdapterTags(
          id: 0000,
          prefijoId: 0000,
          centroId: 0000,
          sufijo: 'error',
          probabilidadId: 0000,
          impactoId: 0000), // Devuelve null si no encuentra un elemento
    );




    if (tag.sufijo != 'error') {
      // setear valores
      final probabilidad =
          listProbabilidades.firstWhere((p) => p.id == tag.probabilidadId);
      final impacto = listImpactos.firstWhere((i) => i.id == tag.impactoId);
      currentStateProbability = probabilidad;
      currentStateImpact = impacto;
      _isEnabledRuletagMatriz = true;
    } else {
      _isEnabledRuletagMatriz = false;
      currentStateProbability = null;
      currentStateImpact = null;
      currentRisk = null;
    }
    
  }
}
