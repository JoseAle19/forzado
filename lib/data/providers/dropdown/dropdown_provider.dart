import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/models/forzado/model_forzado_id.dart';
import 'package:forzado/models/model_flag.dart';
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_tags_matriz.dart';
import 'package:forzado/models/model_three.dart' as modelthird;
import 'package:forzado/models/model_two.dart' as modeltwo;
import 'package:forzado/models/model_user_detail.dart';
import 'package:forzado/models/user/model_user.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';

class DropDownValuesManagerProvider with ChangeNotifier {
  bool _isEnabledRuleRisk = false;
  bool get isEnabledRuleRisk => _isEnabledRuleRisk;
  List<Value> _users = [];
  List<Value> get users => _users;
  String _errorMessageGetUsers = '';
  bool _isLoadingGetUsers = false;
  // getters
  bool get isLoading => _isLoadingGetUsers;
  String get errorMessage => _errorMessageGetUsers;

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

  String get currentTagSubfijo => _currentValueSubfijo;
  set currentTagSubfijo(String value) {
    _currentValueSubfijo = value;
    setImpactAndProbabilidad();
    print('subfijo');
    notifyListeners();
  }

  String get currentValueInterlock => _currentValueInterlock;
  set currentValueInterlock(String value) {
    _currentValueInterlock = value;
    validateInterlok();
    notifyListeners();
  }

  // Getters para ModelOne
  modelone.Value? get currentValueTagPrefijo => _currentValueTagPrefijo;
  set currentValueTagPrefijo(modelone.Value? value) {
    _currentValueTagPrefijo = value;
    print('mod');
    setImpactAndProbabilidad();

    notifyListeners();
  }

  modelone.Value? get currentValueTagCentro => _currentValueTagCentro;
  set currentValueTagCentro(modelone.Value? value) {
    _currentValueTagCentro = value;
    setImpactAndProbabilidad();
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
    _updateCurrentRisk();
    validateInterlok();
    notifyListeners();
  }

  modeltwo.Value? get currentStateImpact => _currentStateImpact;
  set currentStateImpact(modeltwo.Value? value) {
    _currentStateImpact = value;
    _updateCurrentRisk();
    validateInterlok();
    notifyListeners();
  }

  modeltwo.Value? get currentStateRisk => _currentStateRisk;
  set currentStateRisk(modeltwo.Value? value) {
    _currentStateRisk = value;
    validateInterlok();
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
    _currentValueSubfijo = '';
    _currentStateProjectName = null;
    _currentRisk = null;
    notifyListeners();
  }

  // variable para el error
  String _error = '';
  String get error => _error;

  bool _isGettingData = false;
  bool get isGettingdata => _isGettingData;

  // Llenar los dropdown co informacion de la api

  Future<void> getData() async {
    ApiClient client = ApiClient();
    _error = '';
    _isGettingData = true;
    notifyListeners();
    try {
      final responses = await Future.wait([
        client.get(AppUrl.gettagPrefijo1),
        client.get(AppUrl.getTagCentro1),
        client.get(AppUrl.getTagDisciplina2),
        client.get(AppUrl.getTurno2),
        client.get(AppUrl.getResponsable3),
        client.get(AppUrl.getRiesgoA2),
        client.get(AppUrl.getProbabilidad2),
        client.get(AppUrl.getImpacto2),
        client.get(AppUrl.getTipoForzado2),
        client.get(AppUrl.getSolicitantes3),
        client.get(AppUrl.getAprobadores),
        client.get(AppUrl.getEjecutor),
        client.get(AppUrl.getProjects2),
      ]).timeout(const Duration(seconds: 60));

      for (final response in responses) {
        if (response.statusCode != 200) {
          throw HttpException(
              'Error en el servidor: ${response.statusCode}, URL: ${response.request?.url}');
        }
      }

      // Procesar respuestas para ModelOne
      final resPrefijos = modelone.modelOneFromJson(responses[0].body);
      final resCentros = modelone.modelOneFromJson(responses[1].body);
      listPrefijos = resPrefijos.values;
      listCentros = resCentros.values;

      // Procesar respuestas para ModelTwo
      final resDiciplinas = modeltwo.modelTwoFromJson(responses[2].body);
      final resTurnos = modeltwo.modelTwoFromJson(responses[3].body);
      final resRiesgos = modeltwo.modelTwoFromJson(responses[5].body);
      final resProbabilidades = modeltwo.modelTwoFromJson(responses[6].body);
      final resImpactos = modeltwo.modelTwoFromJson(responses[7].body);
      final resTipoForzados = modeltwo.modelTwoFromJson(responses[8].body);
      final resProjects = modeltwo.modelTwoFromJson(responses[12].body);
      listDiciplinas = resDiciplinas.values;
      listTurnos = resTurnos.values;
      listRiesgos = resRiesgos.values;
      listProbabilidades = resProbabilidades.values;
      listImpactos = resImpactos.values;
      listTipoDeForzados = resTipoForzados.values;
      listProjects = resProjects.values;
      final resResponsables = modelthird.modelThreeFromJson(responses[4].body);
      listResponsables = resResponsables.values;

      notifyListeners();
    } on TimeoutException {
      _error = 'Tiempo de espera agotado. Inténtelo de nuevo más tarde.';
      notifyListeners();
    } on SocketException {
      _error = 'Error de conexión. Verifique su conexión a internet.';
      notifyListeners();
    } on HttpException catch (e) {
      _error = 'Error en el servidor: ${e.message}';
      notifyListeners();
    } on FormatException {
      _error =
          'Error en el formato de los datos. Verifique la respuesta de la API.';
      notifyListeners();
    } catch (e) {
      _error = 'Ocurrió un error desconocido: $e';
      notifyListeners();
    } finally {
      _isGettingData = false;
      notifyListeners();
    }
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

// validar que la variable que esta en la base e deatos es true o false
  Future<void> verifyRuleRisk() async {
    ApiClient client = ApiClient();

    final res = await client.get(AppUrl.isEnabledRuleRisk);
    try {
      if (res.statusCode == 200) {
        final decodeData = modelFlagFromJson(res.body);
        _isEnabledRuleRisk = decodeData.values.aplicaReglaRiesgoBajo;
      } else {
        print('Fue diferente el estatuscode de la respuesta');
      }
    } catch (e) {
      print('Ocurrio un error al hacer la peticion del enpoint del flag');
    }
  }

// Definir el riesgo según la probabilidad e impacto
  // void defineRisk() async {
  //   if (currentStateImpact?.descripcion == null ||
  //       currentStateProbability?.descripcion == null) {
  //     return;
  //   }
  //   // Obtener los valores normalizados (en mayúsculas)
  //   final impact = currentStateImpact?.descripcion.toUpperCase();
  //   final probability = currentStateProbability?.descripcion.toUpperCase();
  //   final nivel = riskMatrix[impact]?[probability] ?? '';
  //   final res = riskLevels.firstWhere((element) => element.id == nivel);
  //   ApiResponseDetailUser? user = await PreferencesHelper().getUser();
  //   if (user == null) {
  //     return; // Salir si el usuario es nulo.
  //   }

  //   if (currentStateRisk?.descripcion.toLowerCase() != 'personas') {
  //     if (res.descripcion == 'BAJO' && currentValueInterlock == 'NO') {
  //       // Verificar si el usuario actual no está en la lista de aprobadores
  //       if (!_listAprobadores.any((element) => element.id == user.id)) {
  //         _listAprobadores.add(
  //             modelthird.Value(id: user.id, nombre: user.name, apePaterno: ''));
  //         notifyListeners();
  //       }
  //     } else {
  //       _listAprobadores.removeWhere((element) => element.id == user.id);
  //       notifyListeners();
  //     }
  //   }
  //   _currentRisk = res;
  // }

  void defineRisk() async {
    if (currentStateImpact?.descripcion == null ||
        currentStateProbability?.descripcion == null) {
      return;
    }

    // Obtener valores normalizados
    final impact = currentStateImpact?.descripcion.toUpperCase();
    final probability = currentStateProbability?.descripcion.toUpperCase();
    final nivel = riskMatrix[impact]?[probability] ?? '';
    final res = riskLevels.firstWhere((element) => element.id == nivel);

    // Verificar si la regla de riesgo está habilitada
    ApiResponseDetailUser? user = await PreferencesHelper().getUser();
    if (user == null) {
      return;
    }

    if (isEnabledRuleRisk &&
        res.descripcion == 'BAJO' &&
        currentValueInterlock == 'NO') {
      // Agregar usuario logeado como aprobador si no está
      if (!_listAprobadores.any((element) => element.id == user.id)) {
        _listAprobadores.add(
          modelthird.Value(id: user.id, nombre: user.name, apePaterno: ''),
        );
      }
    } else {
      // Remover al usuario logeado si no aplica
      _listAprobadores.removeWhere((element) => element.id == user.id);
    }

    _currentRisk = res;
    notifyListeners();
  }

  // void validateInterlok() async {
  //   ApiResponseDetailUser? user = await PreferencesHelper().getUser();
  //   if (currentValueInterlock == 'NO') {
  //     addArobbadoresByRole();
  //     if (user == null) {
  //       return;
  //     }
  //     if (!_listAprobadores.any((element) => element.id == user.id)) {
  //       _listAprobadores.add(
  //           modelthird.Value(id: user.id, nombre: user.name, apePaterno: ''));
  //     }
  //   } else {
  //     addAprobadoresByPuesto();
  //   }
  //   if (!_listAprobadores.contains(currentStateApprover)) {
  //     currentStateApprover = null;
  //   }

  //   notifyListeners();
  // }
  List<Tags> _listTagsMatriz = [];
  List<Tags> get listTagsMatriz => _listTagsMatriz;
  // String  _errorGetListTagsmatriz = '';
  // String get  errorGetListTagsmatriz =>_errorGetListTagsmatriz;

  Future<void> getTagsMatrizRiesgo(BuildContext context) async {
    ApiClient client = ApiClient();
    try {
      final res = await client.get(AppUrl.tagsMatrizRiesgo);
      if (res.statusCode == 200) {
        final decodeData = modelTagsMatrizFromJson(res.body);
        _listTagsMatriz = decodeData.values;
        notifyListeners();
      } else {
        CustomModal().showModal(
            context, 'Ocurrió un error inesperado', Colors.red, false);
      }
    } catch (e) {
      CustomModal()
          .showModal(context, 'Ocurrió un error inesperado', Colors.red, false);
    }
  }
// Settera valores de sub  probabilidad e impacto si hay conincidencias con los datos que retorna el endpint de tags matriz rieso

  void setImpactAndProbabilidad() {
    if (currentValueTagPrefijo == null ||
        currentValueTagCentro == null ||
        currentTagSubfijo == '') {
      return;
    }

    final idSubArea = currentValueTagPrefijo!.id;
    final idTagCentro = currentValueTagCentro!.id;
    final subfijo = currentTagSubfijo;

    final tag = _listTagsMatriz.firstWhere(
      (tag) =>
          tag.prefijoId == idSubArea &&
          tag.centroId == idTagCentro &&
          tag.sufijo == subfijo,
      orElse: () => Tags(
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
    }
    else{      currentStateProbability = null;
      currentStateImpact = null;
      currentRisk = null;
}
    print('Tag encontrada con coincidencias ${tag.sufijo}');
  }

  void validateInterlok() async {
    ApiResponseDetailUser? user = await PreferencesHelper().getUser();
    if (currentValueInterlock == 'si') {
      addAprobadoresByPuesto();
      print('by puesto');
      return;
    }
    if (_currentValueInterlock == 'si' ||
        (_currentValueInterlock == 'NO' &&
            _currentStateRisk?.descripcion.toLowerCase() == 'personas')) {
      addAprobadoresByPuesto();
      print('by puesto');
    } else {
      addArobbadoresByRole();
      print('by role');
    }

    if (isEnabledRuleRisk &&
        _currentRisk?.descripcion.toLowerCase() == 'bajo' &&
        user != null &&
        currentValueInterlock == 'NO' &&
        !_listAprobadores.any((element) => element.id == user.id)) {
      _listAprobadores.add(
        modelthird.Value(id: user.id, nombre: user.name, apePaterno: ''),
      );
    }

    notifyListeners();
  }

  void addAprobadoresByPuesto() {
    _listAprobadores.clear();
    for (var user in _users) {
      if (user.puestoDescripcion?.toLowerCase() == "gerente planta proceso") {
        _listAprobadores.add(
          modelthird.Value(
            id: user.id!,
            nombre: '${user.nombre!} ${user.apePaterno!} ${user.apeMaterno!}',
          ),
        );
      }
    }
  }

  bool isEnabledInterlock() {
    return currentStateRisk?.descripcion.toLowerCase() ==
            'personas'.toLowerCase()
        ? false
        : true;
  }

  void _updateCurrentRisk() {
    if (_currentStateImpact?.descripcion != null &&
        _currentStateProbability?.descripcion != null) {
      final impact = _currentStateImpact!.descripcion.toUpperCase();
      final probability = _currentStateProbability!.descripcion.toUpperCase();
      final nivel = riskMatrix[impact]?[probability] ?? '';
      _currentRisk = riskLevels.firstWhere((element) => element.id == nivel,
          orElse: () => modeltwo.Value(id: 1, descripcion: ''));
      notifyListeners();
    }
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

  void addArobbadoresByRole() {
    _listAprobadores.clear();
    for (var user in _users) {
      if (user.roles != null && user.roles!.containsKey('2')) {
        _listAprobadores.add(
          modelthird.Value(
            id: user.id!,
            nombre: '${user.nombre!} ${user.apePaterno!} ${user.apeMaterno!}',
          ),
        );
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

  Future<void> getUsersByRole() async {
    try {
      final res = await ApiClient()
          .get(AppUrl.getListUsers)
          .timeout(const Duration(seconds: 5));
      if (res.statusCode == 200) {
        final UserModelResponse response = userModelResponseFromJson(res.body);
        _users = response.values!;

        for (final user in _users) {
          if (user.roles != null && user.roles!.isNotEmpty) {
            if (user.roles!.containsKey('1')) {
              listSolicitantes.add(modelthird.Value(
                id: user.id!,
                nombre: '${user.nombre!} ${user.apePaterno} ${user.apeMaterno}',
              ));
            }
            if (user.roles!.containsKey('2')) {
              listAprobadores.add(modelthird.Value(
                id: user.id!,
                nombre: '${user.nombre!} ${user.apePaterno} ${user.apeMaterno}',
                apePaterno: user.apePaterno!,
              ));
            }
            if (user.roles!.containsKey('3')) {
              print('entro a ejecutores');
              listEjecutores.add(modelthird.Value(
                id: user.id!,
                nombre: '${user.nombre!} ${user.apePaterno} ${user.apeMaterno}',
                apePaterno: user.apePaterno!,
              ));
            }
          } else {}
        }
      } else if (res.statusCode == 401) {
        _errorMessageGetUsers = 'Error al obtener los usuarios';
      } else if (res.statusCode == 500) {
        _errorMessageGetUsers = 'Error interno del servidor';
      }
    } on TimeoutException catch (_) {
      _errorMessageGetUsers = 'La solicitud excedió el tiempo límite.';
    } catch (e) {
      _errorMessageGetUsers = 'Error en la solicitud: $e';
    } finally {
      _isLoadingGetUsers = false;
      notifyListeners();
      print('todos los usuarios: ${_users.length}');
    }
  }

  // Funciones para actualizar
  Future<void> fillDataUpdate(int id) async {
    ApiClient client = ApiClient();
    try {
      print('cargando');
      final res = await client.get('/api/solicitudes/alta/$id');
      if (res.statusCode == 200) {
        final decodeData = modelForzadoByIdFromJson(res.body);
        ForzadoId f = decodeData.data![0];

        // Filtrar valores de las listas y asignar
        currentValueTagPrefijo = _listPrefijos.firstWhere(
          (element) => element.id == f.tagPrefijo,
          orElse: () =>
              modelone.Value(id: 0, codigo: '', descripcion: 'No encontrado'),
        );

        currentValueTagCentro = _listCentros.firstWhere(
          (element) => element.id == f.tagCentro,
          orElse: () =>
              modelone.Value(id: 0, codigo: '', descripcion: 'No encontrado'),
        );

        currentValueTagDisciplina = _listDiciplinas.firstWhere(
          (element) => element.id == f.disciplina,
          orElse: () => modeltwo.Value(id: 0, descripcion: 'No encontrado'),
        );

        currentValueSlot = _listTurnos.firstWhere(
          (element) => element.id == f.turno,
          orElse: () => modeltwo.Value(id: 0, descripcion: 'No encontrado'),
        );

        currentStateProbability = _listProbabilidades.firstWhere(
          (element) => element.id == f.probabilidad,
          orElse: () => modeltwo.Value(id: 0, descripcion: 'No encontrado'),
        );

        currentStateImpact = _listImpactos.firstWhere(
          (element) => element.id == f.impacto,
          orElse: () => modeltwo.Value(id: 0, descripcion: 'No encontrado'),
        );

        currentStateRisk = _listRiesgos.firstWhere(
          (element) => element.id == f.riesgo,
          orElse: () => modeltwo.Value(id: 0, descripcion: 'No encontrado'),
        );

        currentStateTypeForzado = _listTipoDeForzados.firstWhere(
          (element) => element.id == f.tipoForzado,
          orElse: () => modeltwo.Value(id: 0, descripcion: 'No encontrado'),
        );

        currentStateProjectName = _listprojects.firstWhere(
          (element) => element.id == f.proyecto,
          orElse: () => modeltwo.Value(id: 0, descripcion: 'No encontrado'),
        );

        currentStateApplicant = _listSolicitantes.firstWhere(
          (element) => element.id == f.solicitante,
          orElse: () => modelthird.Value(id: 0, nombre: 'No encontrado'),
        );

        currentStateResponsibility = _listResponsables.firstWhere(
          (element) => element.idT == f.responsable,
          orElse: () => modelthird.Value(id: 0, nombre: 'No encontrado'),
        );
   

    print('id for ${f.aprobador}');
        for (var i = 0; i < listAprobadores.length; i++) {
          if (listAprobadores[i].id == f.aprobador) {
            final apro = listAprobadores[i];
          currentStateApprover = modelthird.Value(id: apro.id, nombre: '${apro.id} ${apro.apePaterno} ${apro.apePaterno}');
          notifyListeners();
          }
        }
        currentStateApprover = listAprobadores.firstWhere(
          (element) => element.idT.toString() == f.aprobador.toString(),
          orElse: () => modelthird.Value(id: 0, nombre: 'No encontrado'),
        ); 

        currentStateExecutor = _listEjecutores.firstWhere(
          (element) => element.idT == f.ejecutor,
          orElse: () => modelthird.Value(id: 0, nombre: 'No encontrado'),
        );

     // Asignar valores de cadenas directamente
        currentValueDescription = f.descripcion!;
        currentTagSubfijo = f.tagSubfijo!;
        currentValueInterlock = f.interlockSeguridad == 1 ? 'si' : "NO";
        if (currentStateImpact != null && currentStateProbability != null) {
          defineRisk();
        }

        notifyListeners(); // Notifica que los valores han sido actualizados
      } else {
        print('Ocurrió un error en la solicitud: ${res.statusCode}');
      }
    } catch (e) {
      print('Ocurrió un error: $e');
    }
  }
}
