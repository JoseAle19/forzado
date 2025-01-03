import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_three.dart' as modelthird;
import 'package:forzado/models/model_two.dart' as modeltwo;
import 'package:forzado/services/api_client.dart';

class DropDownValuesManagerProvider with ChangeNotifier {
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

  modelthird.Value? _currentStateApplicant;
  modelthird.Value? _currentStateResponsibility;
  modelthird.Value? _currentStateApprover;
  modelthird.Value? _currentStateExecutor;

  String _currentValueDescription = '';
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

  String get currentValueInterlock => _currentValueInterlock;
  set currentValueInterlock(String value) {
    _currentValueInterlock = value;
    notifyListeners();
  }

  // Getters para ModelOne
  modelone.Value? get currentValueTagPrefijo => _currentValueTagPrefijo;
  set currentValueTagPrefijo(modelone.Value? value) {
    _currentValueTagPrefijo = value;
    notifyListeners();
  }

  modelone.Value? get currentValueTagCentro => _currentValueTagCentro;
  set currentValueTagCentro(modelone.Value? value) {
    _currentValueTagCentro = value;
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
    notifyListeners();
  }

  modeltwo.Value? get currentStateImpact => _currentStateImpact;
  set currentStateImpact(modeltwo.Value? value) {
    _currentStateImpact = value;
    notifyListeners();
  }

  modeltwo.Value? get currentStateRisk => _currentStateRisk;
  set currentStateRisk(modeltwo.Value? value) {
    _currentStateRisk = value;
    notifyListeners();
  }

  modeltwo.Value? get currentStateTypeForzado => _currentStateTypeForzado;
  set currentStateTypeForzado(modeltwo.Value? value) {
    _currentStateTypeForzado = value;
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
      listDiciplinas = resDiciplinas.values;
      listTurnos = resTurnos.values;
      listRiesgos = resRiesgos.values;
      listProbabilidades = resProbabilidades.values;
      listImpactos = resImpactos.values;
      listTipoDeForzados = resTipoForzados.values;

      // Procesar respuestas para ModelThree
      final resResponsables = modelthird.modelThreeFromJson(responses[4].body);
      final resSolicitantes = modelthird.modelThreeFromJson(responses[9].body);
      final resAprobadores = modelthird.modelThreeFromJson(responses[10].body);
      final resEjecutores = modelthird.modelThreeFromJson(responses[11].body);
      listResponsables = resResponsables.values;
      listSolicitantes = resSolicitantes.values;
      listAprobadores = resAprobadores.values;
      listEjecutores = resEjecutores.values;

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
      'POSIBLE': 9,
      'IMPROBABLE': 6,
      'RARO': 3,
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
  void defineRisk() {
    if (currentStateImpact?.descripcion == null ||
        currentStateProbability?.descripcion == null) {
      return;
    }
    // Obtener los valores normalizados (en mayúsculas)
    final impact = currentStateImpact?.descripcion.toUpperCase();
    final probability = currentStateProbability?.descripcion.toUpperCase();
    final nivel = riskMatrix[impact]?[probability] ?? '';
    final res = riskLevels.firstWhere((element) => element.id == nivel);
    _currentRisk = res;
  }

  // Lista manual de combinaciones de riesgo (basado en la tabla de tu imagen)
  final List<modeltwo.Value> _riskLevels = [
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
  ];
  List<modeltwo.Value> get riskLevels => _riskLevels;


}
