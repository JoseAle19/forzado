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
  late modelone.Value _currentValueTagCentro;

  late modeltwo.Value _currentValueTagDisciplina;
  late modeltwo.Value _currentValueSlot;
  late modeltwo.Value _currentStateProbability;
  late modeltwo.Value _currentStateImpact;
  late modeltwo.Value _currentStateRisk;
  late modeltwo.Value _currentStateTypeForzado;

  late modelthird.Value _currentStateApplicant;
  late modelthird.Value _currentStateResponsibility;
  late modelthird.Value _currentStateApprover;
  late modelthird.Value _currentStateExecutor;

  // Getters para ModelOne
  modelone.Value? get currentValueTagPrefijo => _currentValueTagPrefijo;
  set currentValueTagPrefijo(modelone.Value? value) {
    _currentValueTagPrefijo = value;
    notifyListeners();
  }

  modelone.Value get currentValueTagCentro => _currentValueTagCentro;
  set currentValueTagCentro(modelone.Value value) {
    _currentValueTagCentro = value;
    notifyListeners();
  }

  // Getters para ModelTwo
  modeltwo.Value get currentValueTagDisciplina => _currentValueTagDisciplina;
  set currentValueTagDisciplina(modeltwo.Value value) {
    _currentValueTagDisciplina = value;
    notifyListeners();
  }

  modeltwo.Value get currentValueSlot => _currentValueSlot;
  set currentValueSlot(modeltwo.Value value) {
    _currentValueSlot = value;
    notifyListeners();
  }

  modeltwo.Value get currentStateProbability => _currentStateProbability;
  set currentStateProbability(modeltwo.Value value) {
    _currentStateProbability = value;
    notifyListeners();
  }

  modeltwo.Value get currentStateImpact => _currentStateImpact;
  set currentStateImpact(modeltwo.Value value) {
    _currentStateImpact = value;
    notifyListeners();
  }

  modeltwo.Value get currentStateRisk => _currentStateRisk;
  set currentStateRisk(modeltwo.Value value) {
    _currentStateRisk = value;
    notifyListeners();
  }

  modeltwo.Value get currentStateTypeForzado => _currentStateTypeForzado;
  set currentStateTypeForzado(modeltwo.Value value) {
    _currentStateTypeForzado = value;
    notifyListeners();
  }

  // Getters para ModelThird
  modelthird.Value get currentStateApplicant => _currentStateApplicant;
  set currentStateApplicant(modelthird.Value value) {
    _currentStateApplicant = value;
    notifyListeners();
  }

  modelthird.Value get currentStateResponsibility =>
      _currentStateResponsibility;
  set currentStateResponsibility(modelthird.Value value) {
    _currentStateResponsibility = value;
    notifyListeners();
  }

  modelthird.Value get currentStateApprover => _currentStateApprover;
  set currentStateApprover(modelthird.Value value) {
    _currentStateApprover = value;
    notifyListeners();
  }

  modelthird.Value get currentStateExecutor => _currentStateExecutor;
  set currentStateExecutor(modelthird.Value value) {
    _currentStateExecutor = value;
    notifyListeners();
  }

  // Llenar los dropdown co informacion de la api
  Future<void> getData() async {
    print('request ');
    ApiClient client = ApiClient();
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
      ]).timeout(const Duration(seconds: 5));
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
      final resSolicitantes = modelthird.modelThreeFromJson(responses[9].body);
      final resAprobadores = modelthird.modelThreeFromJson(responses[10].body);
      final resEjecutores = modelthird.modelThreeFromJson(responses[11].body);

      listSolicitantes = resSolicitantes.values;
      listAprobadores = resAprobadores.values;
      listEjecutores = resEjecutores.values;

      notifyListeners();
      print('datos cargados');
    } catch (e) {
      print('Ocurrio un error ${e.toString()}');
       notifyListeners();
    }
  }
}
