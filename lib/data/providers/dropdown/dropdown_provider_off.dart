import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:forzado/adapters/adapter_matriz_riesgo.dart';
import 'package:forzado/adapters/adapter_one.dart';
import 'package:forzado/adapters/adapter_shifts.dart';
import 'package:forzado/adapters/adapter_tag_forzado.dart';
import 'package:forzado/adapters/adapter_three.dart';
import 'package:forzado/adapters/adapter_two.dart';
import 'package:forzado/adapters/staff_position.dart';
import 'package:forzado/adapters/user_adapter.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/models/mestras/puestos_model.dart' as modelp;
import 'package:forzado/models/model_one.dart' as modelone;
import 'package:forzado/models/model_tags_matriz.dart';
import 'package:forzado/models/model_three.dart' as modelthird;
import 'package:forzado/models/model_two.dart' as modeltwo;
import 'package:forzado/models/user/model_user.dart' as modeluser;
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DropdownProviderManagerOffline with ChangeNotifier {
// Controla si los valores de evaluación de riesgo son establecidos automáticamente por reglas
  bool _isRiskAssessmentAutoSet = false;
  bool get isRiskAssessmentAutoSet => _isRiskAssessmentAutoSet;
  set isRiskAssessmentAutoSet(bool value) {
    _isRiskAssessmentAutoSet = value;
    notifyListeners();
  }

  // === ModelOne ===
  List<modelone.Value> listPrefijos = [];
  List<modelone.Value> listCentros = [];

  modelone.Value? _currentValueTagPrefijo;
  modelone.Value? _currentValueTagCentro;

  modelone.Value? get currentValueTagPrefijo => _currentValueTagPrefijo;
  set currentValueTagPrefijo(modelone.Value? v) {
    if (v != _currentValueTagPrefijo) {
      _currentValueTagPrefijo = v;
      _updateTagValues();
      notifyListeners();
    }
  }

  modelone.Value? get currentValueTagCentro => _currentValueTagCentro;
  set currentValueTagCentro(modelone.Value? v) {
    if (v != _currentValueTagCentro) {
      _currentValueTagCentro = v;
      _updateTagValues();
      notifyListeners();
    }
  }

  // === ModelTwo ===
  List<modeltwo.Value> listDiciplinas = [];
  List<modeltwo.Value> listProbabilidades = [];
  List<modeltwo.Value> listImpactos = [];
  List<modeltwo.Value> listRiesgos = [];
  List<modeltwo.Value> listMatrizRiesgo = [];
  List<modeltwo.Value> listCircuitos = [];
  List<modeltwo.Value> listGrupos = [];
  List<modelp.Value> listPuestos = [];

  modeltwo.Value? _currentValueTagDisciplina;
  modeltwo.Value? _currentStateProbability;
  modeltwo.Value? _currentStateImpact;
  modeltwo.Value? _currentValueCircuitos;
  modeltwo.Value? _currentRiskA;
  modeltwo.Value? _currentRisk;
  modeltwo.Value? _currentValueGrupo;

  modeltwo.Value? get currentValueTagDisciplina => _currentValueTagDisciplina;
  set currentValueTagDisciplina(modeltwo.Value? v) {
    if (v != _currentValueTagDisciplina) {
      _currentValueTagDisciplina = v;
      notifyListeners();
    }
  }

  modeltwo.Value? get currentStateProbability => _currentStateProbability;
  set currentStateProbability(modeltwo.Value? v) {
    if (v != _currentStateProbability) {
      _currentStateProbability = v;
      definirRiesgo();
      validateInterlok();
      notifyListeners();
    }
  }

  modeltwo.Value? get currentStateImpact => _currentStateImpact;
  set currentStateImpact(modeltwo.Value? v) {
    if (v != _currentStateImpact) {
      _currentStateImpact = v;
      definirRiesgo();
      validateInterlok();
      notifyListeners();
    }
  }

  modeltwo.Value? get currentValueCircuitos => _currentValueCircuitos;
  set currentValueCircuitos(modeltwo.Value? v) {
    if (v != _currentValueCircuitos) {
      _currentValueCircuitos = v;
      notifyListeners();
    }
  }

  modeltwo.Value? get currentRiskA => _currentRiskA;
  set currentRiskA(modeltwo.Value? v) {
    if (v != _currentRiskA) {
      _currentRiskA = v;
      validateInterlok();
      notifyListeners();
    }
  }

  modeltwo.Value? get currentRisk => _currentRisk;
  set currentRisk(modeltwo.Value? v) {
    if (v != _currentRisk) {
      _currentRisk = v;
      validateInterlok();
      notifyListeners();
    }
  }

  modeltwo.Value? get currentGrupo => _currentValueGrupo;
  set currentGrupo(modeltwo.Value? v) {
    if (v != _currentValueGrupo) {
      _currentValueGrupo = v;
      notifyListeners();
    }
  }

  // === ModelThree ===
  List<modelthird.Value> listSolicitantes = [];
  List<modelthird.Value> listResponsables = [];
  List<modelthird.Value> listAprobadores = [];

  modelthird.Value? _currentStateApplicant;
  modelthird.Value? _currentStateResponsibility;
  modelthird.Value? _currentStateApprover;
  modelthird.Value? _currentStateExecutor;

  modelthird.Value? get currentStateApplicant => _currentStateApplicant;
  set currentStateApplicant(modelthird.Value? v) {
    if (v != _currentStateApplicant) {
      _currentStateApplicant = v;
      validateInterlok();
      notifyListeners();
    }
  }

  modelthird.Value? get currentStateResponsibility =>
      _currentStateResponsibility;
  set currentStateResponsibility(modelthird.Value? v) {
    if (v != _currentStateResponsibility) {
      _currentStateResponsibility = v;
      notifyListeners();
    }
  }

  modelthird.Value? get currentStateApprover => _currentStateApprover;
  set currentStateApprover(modelthird.Value? v) {
    if (v != _currentStateApprover) {
      _currentStateApprover = v;
      notifyListeners();
    }
  }

  modelthird.Value? get currentStateExecutor => _currentStateExecutor;
  set currentStateExecutor(modelthird.Value? v) {
    if (v != _currentStateExecutor) {
      _currentStateExecutor = v;
      notifyListeners();
    }
  }

  // === ModelUser ===
  List<modeluser.Value> usersOff = [];

  // === Otros campos simples ===
  String _currentValueDescription = '';
  String _currentValueSubfijo = '';
  int? _currentValueInterlock = null;

  String get currentValueDescription => _currentValueDescription;
  set currentValueDescription(String v) {
    if (v != _currentValueDescription) {
      _currentValueDescription = v;
      notifyListeners();
    }
  }

// Datos de la busqueda
  AdapterTagForzado? _resultado;
  AdapterTagForzado? get resultado => _resultado;
  String get currentValueSubfijo => _currentValueSubfijo;
  Timer? _debounce;

  set currentValueSubfijo(String v) {
    if (v != _currentValueSubfijo) {
      _currentValueSubfijo = v;

      _updateTagValues();
    }
  }

  int? get currentValueInterlock => _currentValueInterlock;
  set currentValueInterlock(int? v) {
    if (v != _currentValueInterlock) {
      _currentValueInterlock = v;
      validateInterlok();
      notifyListeners();
    }
  }

  // === Limpieza de valores ===
  void resetAll() {
    // Clear all lists
    listPrefijos.clear();
    listCentros.clear();
    listDiciplinas.clear();
    listProbabilidades.clear();
    listImpactos.clear();
    listRiesgos.clear();
    listMatrizRiesgo.clear();
    listCircuitos.clear();
    listGrupos.clear();
    listPuestos.clear();
    listSolicitantes.clear();
    listResponsables.clear();
    listAprobadores.clear();
    usersOff.clear();

    // Reset all current value properties to null
    _currentValueTagPrefijo = null;
    _currentValueTagCentro = null;
    _currentValueTagDisciplina = null;
    _currentStateProbability = null;
    _currentStateImpact = null;
    _currentValueCircuitos = null;
    _currentRiskA = null;
    _currentRisk = null;
    _currentValueGrupo = null;
    _currentStateApplicant = null;
    _currentStateResponsibility = null;
    currentStateApprover = null;
    _currentStateExecutor = null;

    // Reset string values
    _currentValueDescription = '';
    _currentValueSubfijo = '';
    _currentValueInterlock = null;

    // Cancel and clear debounce timer if it exists
    _debounce?.cancel();
    _debounce = null;

    // Reset resultado
    _resultado = null;

// flags
    isRiskAssessmentAutoSet = false;
    // Notify listeners
    notifyListeners();
  }

  // Se hace fectching de datos de los usaurips
  Future<void> pushUsers(BuildContext c) async {
    final provider =
        Provider.of<DropDownValuesManagerProvider>(c, listen: false);
    await provider.getData2();
    // print('users');
    await saveDataForm1(c);
    // print('form 1');
    await saveDataForm2(c);
    // print('form 2');
    saveDataForm3(c);
    // print('form 3');
    saveDataMasters(c);
    // print('maestras');
    saveUsersToHive(provider);
  }

//Llenar los datos del primer form
  Future<void> saveDataForm1(BuildContext c) async {
    final client = ApiClient();

    final boxTagPrefijo = Hive.box<AdapterOne>('TagPrefijo');
    final boxTagCentro = Hive.box<AdapterOne>('TagCentro');
    final boxDisciplina = Hive.box<AdapterTwo>('Disciplina');
    final boxCircuitos = Hive.box<AdapterTwo>('circuitos');

    try {
      final responses = await Future.wait([
        client.get(AppUrl.gettagPrefijo1),
        client.get(AppUrl.getTagCentro1),
        client.get(AppUrl.getTagDisciplina2),
        client.get(AppUrl.getCircuitos2),
      ]).timeout(const Duration(seconds: 60));

      final prefijosModel = modelone.modelOneFromJson(responses[0].body).values;
      final centrosModel = modelone.modelOneFromJson(responses[1].body).values;
      final disciplinasModel =
          modeltwo.modelTwoFromJson(responses[2].body).values;
      final circuitosModel =
          modeltwo.modelTwoFromJson(responses[3].body).values;

      // Convertir modelos a Adapters
      final prefijos =
          prefijosModel.map((v) => AdapterOne.fromValue(v)).toList();
      final centros = centrosModel.map((v) => AdapterOne.fromValue(v)).toList();
      final disciplinas =
          disciplinasModel.map((v) => AdapterTwo.fromValue(v)).toList();
      final circuitos =
          circuitosModel.map((v) => AdapterTwo.fromValue(v)).toList();

      // Limpiar cajas (opcional)
      await boxTagPrefijo.clear();
      await boxTagCentro.clear();
      await boxDisciplina.clear();
      await boxCircuitos.clear();

      // Guardar en Hive
      await Future.wait([
        boxTagPrefijo.addAll(prefijos),
        boxTagCentro.addAll(centros),
        boxDisciplina.addAll(disciplinas),
        boxCircuitos.addAll(circuitos),
      ]);
    } catch (e) {
      CustomModal modal = CustomModal();
      modal.showModal(c, 'Ocurrio un error, form 1', Colors.red, false);
    }
  }

  Future<void> saveDataForm2(BuildContext c) async {
    final client = ApiClient();

    final boxRiesgo = Hive.box<AdapterTwo>('Riesgo');
    final boxMatrizRiesgo =
        Hive.box<AdapterMatrizRiesgo>('matriz-riesgo'); // matriz riesgo
    final boxProbabilidad = Hive.box<AdapterTwo>('Probabilidad');
    final boxImpacto = Hive.box<AdapterTwo>('Impacto');

    try {
      final responses = await Future.wait([
        client.get(AppUrl.getRiesgoA2), // Riesgos generales
        client.get(AppUrl.getMatrizRiesgo), // Matriz de riesgo
        client.get(AppUrl.getProbabilidad2), // Probabilidad
        client.get(AppUrl.getImpacto2), // Impacto
      ]).timeout(const Duration(seconds: 60));

      // Parseo de modelos
      final riesgosModel = modeltwo.modelTwoFromJson(responses[0].body).values;
      final probabilidadModel =
          modeltwo.modelTwoFromJson(responses[2].body).values;
      final impactoModel = modeltwo.modelTwoFromJson(responses[3].body).values;

      // Convertir modelos a Adapters
      final riesgos = riesgosModel.map((v) => AdapterTwo.fromValue(v)).toList();
      final matrizRiesgoJson =
          (json.decode(responses[1].body)['values'] as List)
              .map((e) => AdapterMatrizRiesgo.fromJson(e))
              .toList();

      final probabilidades =
          probabilidadModel.map((v) => AdapterTwo.fromValue(v)).toList();
      final impactos =
          impactoModel.map((v) => AdapterTwo.fromValue(v)).toList();

      // Limpiar cajas
      await boxRiesgo.clear();
      await boxMatrizRiesgo.clear();
      await boxProbabilidad.clear();
      await boxImpacto.clear();

      // Guardar en Hive
      await Future.wait([
        boxRiesgo.addAll(riesgos),
        boxMatrizRiesgo.addAll(matrizRiesgoJson),
        boxProbabilidad.addAll(probabilidades),
        boxImpacto.addAll(impactos),
      ]);
    } catch (e) {
      CustomModal modal = CustomModal();
      modal.showModal(c, 'Ocurrió un error al guardar datos del formulario 2.',
          Colors.red, false);
    }
  }

  Future<void> saveDataForm3(BuildContext c) async {
    final boxGrupoEjecucion = Hive.box<AdapterTwo>('grupo-ejecucion');
    final client = ApiClient();
    try {
      final res = await client.get(AppUrl.getGrupos);

      final gruposEjecucionModel = modeltwo.modelTwoFromJson(res.body).values;
      final gruposEjecucion =
          gruposEjecucionModel.map((v) => AdapterTwo.fromValue(v)).toList();
      await boxGrupoEjecucion.clear();
      await Future.wait([
        boxGrupoEjecucion.addAll(gruposEjecucion),
      ]);
    } catch (e) {
      CustomModal modal = CustomModal();
      modal.showModal(c, 'Ocurrio un error, form 3', Colors.red, false);
    }
  }

  Future<void> saveUsersToHive(DropDownValuesManagerProvider provider) async {
    // Abre las cajas
    final boxSolicitante = Hive.box<AdapterThree>('Solicitante');
    final boxResponsable = Hive.box<AdapterThree>('Responsable');
    final boxAprobador = Hive.box<AdapterThree>('Aprobador');
    final boxEjecutor = Hive.box<AdapterThree>('Ejecutor');
    final boxUsers = Hive.box<AdapterUser>('users');

    await boxSolicitante.clear();
    await boxResponsable.clear();
    await boxAprobador.clear();
    await boxEjecutor.clear();
    await boxUsers.clear();

    for (var v in provider.listSolicitantes) {
      boxSolicitante.add(AdapterThree.fromValue(v));
    }
    for (var v in provider.listResponsables) {
      boxResponsable.add(AdapterThree.fromValue(v));
    }
    for (var v in provider.listAprobadores) {
      boxAprobador.add(AdapterThree.fromValue(v));
    }
    for (var v in provider.listEjecutores) {
      boxEjecutor.add(AdapterThree.fromValue(v));
    }

    // Guardar todos los usuarios completos
    for (var u in provider.users) {
      boxUsers.add(AdapterUser(
          apePaterno: u.apePaterno,
          apeMaterno: u.apeMaterno,
          areaId: u.areaId,
          areaDescripcion: u.areaDescripcion,
          rolId: u.rolId,
          rolDescripcion: u.rolDescripcion,
          roles: u.roles,
          estado: u.estado,
          dni: u.dni,
          puestoId: u.puestoId,
          puestoDescripcion: u.puestoDescripcion,
          correo: u.correo,
          usuario: u.usuario,
          id: u.id,
          nombre: u.nombre,
          grupoId: u.grupoId));
    }
  }

  Future<void> saveDataMasters(BuildContext c) async {
    final client = ApiClient();
    final boxTagsMtarizRiesgo =
        Hive.box<AdapterTagForzado>('tags-matriz-riesgo');

    final maestrasProvider = Provider.of<MastersProvider>(c, listen: false);
    final providerDropOn =
        Provider.of<DropDownValuesManagerProvider>(c, listen: false);
    await maestrasProvider.getShifts();

    try {
      final res = await client.get(AppUrl.tagsMatrizRiesgo);
      final tagMatrizRiesgoModel = modelTagsMatrizFromJson(res.body).values;
      final tagsMatrizRiesgo = tagMatrizRiesgoModel
          .map((v) => AdapterTagForzado.fromModel(v))
          .toList();
      await boxTagsMtarizRiesgo.clear();
      await Future.wait([
        boxTagsMtarizRiesgo.addAll(tagsMatrizRiesgo),
      ]);

      // Agregar los turnos a la caja
      final boxPuestos = Hive.box<PuestoValue>('staffPosition');
      await boxPuestos.clear();

      await boxPuestos.addAll(providerDropOn.listPuestos
          .map((lt) => PuestoValue.fromJson(lt))
          .toList());
    } catch (e) {
      CustomModal modal = CustomModal();
      modal.showModal(c, 'Ocurrio un error, form 3', Colors.red, false);
    }
  }

  Future<void> loadDataPromHive() async {
    resetAll();
    _determineCurrentShift();

    // tag subfijo
    // descripcion
    final boxPrefijos = Hive.box<AdapterOne>('TagPrefijo');
    final boxCentros = Hive.box<AdapterOne>('TagCentro');
    final boxCircuitos = Hive.box<AdapterTwo>('circuitos');
    final boxDiciplina = Hive.box<AdapterTwo>('Disciplina');

    // interlock
    final boxResponsable = Hive.box<AdapterThree>('Responsable');
    final boxRiesgo = Hive.box<AdapterTwo>('Riesgo');
    final boxProbabilidad = Hive.box<AdapterTwo>('Probabilidad');
    final boxImpacto = Hive.box<AdapterTwo>('Impacto');
    final boxMatrizRiesgo = Hive.box<AdapterMatrizRiesgo>('matriz-riesgo');

    final boxSolicitante = Hive.box<AdapterThree>('Solicitante');
    final boxAprobador = Hive.box<AdapterThree>('Aprobador');
    final boxGrupoEjecucion = Hive.box<AdapterTwo>('grupo-ejecucion');

// Datos del form 2

    listResponsables = boxResponsable.values
        .map((e) => modelthird.Value(id: e.id, nombre: e.nombre))
        .toList();

    listRiesgos = boxRiesgo.values
        .map((e) => modeltwo.Value(id: e.id, descripcion: e.descripcion))
        .toList();
    listProbabilidades = boxProbabilidad.values
        .map((e) => modeltwo.Value(id: e.id, descripcion: e.descripcion))
        .toList();
    listImpactos = boxImpacto.values
        .map((e) => modeltwo.Value(id: e.id, descripcion: e.descripcion))
        .toList();

    final Set<int> idsUnicos = {};
    listMatrizRiesgo = boxMatrizRiesgo.values.where((e) {
      final isNew = !idsUnicos.contains(e.riesgoId);
      idsUnicos.add(e.riesgoId);
      return isNew;
    }).map((e) {
      return modeltwo.Value(id: e.riesgoId, descripcion: e.riesgoDescripcion);
    }).toList();

    // Datos del form 3
    listSolicitantes = boxSolicitante.values
        .map((e) => modelthird.Value(id: e.id, nombre: e.nombre))
        .toList();
    listAprobadores = boxAprobador.values
        .map((e) => modelthird.Value(id: e.id, nombre: e.nombre))
        .toList();
    listGrupos = boxGrupoEjecucion.values
        .map((e) => modeltwo.Value(id: e.id, descripcion: e.descripcion))
        .toList();
// Datos del form 1
    listPrefijos = boxPrefijos.values
        .map((e) => modelone.Value(
            id: e.id, codigo: e.codigo, descripcion: e.descripcion))
        .toList();
    listCentros = boxCentros.values
        .map((e) => modelone.Value(
            id: e.id, codigo: e.codigo, descripcion: e.descripcion))
        .toList();
    listDiciplinas = boxDiciplina.values
        .map((e) => modeltwo.Value(id: e.id, descripcion: e.descripcion))
        .toList();
    listCircuitos = boxCircuitos.values
        .map((e) => modeltwo.Value(id: e.id, descripcion: e.descripcion))
        .toList();

    notifyListeners();
  }

  void _runDebounced(Duration delay, VoidCallback callback) {
    if (_debounce?.isActive ?? false) {
      print('[DEBUG] Debounce anterior cancelado');
      _debounce!.cancel();
    }

    _debounce = Timer(delay, callback);
  }

  // Definir el riesgo (No riesgo A)
  void definirRiesgo() {
    final boxMatrizRiesgo = Hive.box<AdapterMatrizRiesgo>('matriz-riesgo');
    if (currentStateImpact == null || currentStateProbability == null) {
      currentRisk = null;
      notifyListeners();
      return;
    }

    final _res = boxMatrizRiesgo.values.firstWhereOrNull((mr) =>
            mr.impactoId == currentStateImpact!.id &&
            mr.probabilidadId == currentStateProbability!.id // << Corregido
        );
    currentRisk = _res != null
        ? listMatrizRiesgo.firstWhereOrNull(
            (item) => item.id == _res.riesgoId,
          )
        : null;

    notifyListeners();
  }

  void _updateTagValues() {
    _runDebounced(const Duration(milliseconds: 300), () {
      final box = Hive.box<AdapterTagForzado>('tags-matriz-riesgo');

      _resultado = box.values.firstWhereOrNull((tg) =>
          tg.sufijo == currentValueSubfijo &&
          tg.prefijoId == currentValueTagPrefijo?.id &&
          tg.centroId == currentValueTagCentro?.id);

      if (_resultado != null) {
        final probabilidad = listProbabilidades
            .firstWhereOrNull((p) => p.id == _resultado!.probabilidadId);
        final impacto =
            listImpactos.firstWhereOrNull((i) => i.id == _resultado!.impactoId);
        final riesgoA =
            listRiesgos.firstWhereOrNull((r) => r.id == _resultado!.riesgoAId);

        currentRiskA = riesgoA;
        currentStateProbability = probabilidad;
        currentStateImpact = impacto;
        currentValueInterlock = _resultado!.interlock;
        isRiskAssessmentAutoSet = true;
      } else {
        currentRiskA = null;
        currentStateProbability = null;
        currentStateImpact = null;
        currentValueInterlock = null;
        isRiskAssessmentAutoSet = false;
      }

      notifyListeners();
    });
  }

  String? _shiftType; // 'DIA' o 'NOCHE'
  String? get shiftType => _shiftType;

  String _dateNow = '0000/00/00';
  String? get date => _dateNow;
  ShiftValue? _currentShift;
  ShiftValue? get currentShift => _currentShift;

  void formatDate() {
    final formattedDate =
        DateFormat('dd/MM/yyyy, HH:mm:ss').format(DateTime.now());
    _dateNow = formattedDate;
  }

  void _determineCurrentShift() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);
    final _turnos = Hive.box<ShiftValue>('shiftBox').values;

    for (final turno in _turnos) {
      final startTime = _parseTimeString(turno.horaInicio!);
      final endTime = _parseTimeString(turno.horaFin!);

      if (_isTimeInShift(currentTime, startTime, endTime)) {
        _currentShift = turno;
        _shiftType = normalizar(turno.descripcion ?? '--'); // 'DIA' o 'NOCHE'
        notifyListeners();
        return;
      }
    }
  }

  String normalizar(String texto) {
    return texto.characters.toString();
  }

  TimeOfDay _parseTimeString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  bool _isTimeInShift(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final nowInMinutes = current.hour * 60 + current.minute;
    final startInMinutes = start.hour * 60 + start.minute;
    final endInMinutes = end.hour * 60 + end.minute;

    if (startInMinutes <= endInMinutes) {
      // Turno normal (mismo día)
      return nowInMinutes >= startInMinutes && nowInMinutes <= endInMinutes;
    } else {
      // Turno que cruza medianoche (ej. 19:00-06:59)
      return nowInMinutes >= startInMinutes || nowInMinutes <= endInMinutes;
    }
  }

// Esto define la lista de aprobadores por: puesto al que pertenece, por el turno y por el grupo
  void addAprobadoresByPuesto() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('grupoId');
    
    final boxShifts = Hive.box<PuestoValue>('staffPosition').values.toList();
    final boxUsers = Hive.box<AdapterUser>('users').values.toList();

    final mapaPuestos = {
      for (var puesto in boxShifts) puesto.descripcion: puesto
    };

    final aprobadores = boxUsers.where((usuario) {
      final puesto = mapaPuestos[usuario.puestoDescripcion];
      return (puesto?.turnos?.contains(currentShift!.id) ?? false) &&
          usuario.grupoId == id;
    }).toList();

    final nuevosAprobadores = <modelthird.Value>[];
    final idsAgregados = <int>{};

    for (var user in aprobadores) {
      if (user.puestoDescripcion?.toLowerCase() == "gerente planta proceso") {
        final nuevoAprobador = modelthird.Value(
          id: user.id!,
          nombre: '${user.nombre!} ${user.apePaterno!} ${user.apeMaterno!}',
        );
        
        if (!idsAgregados.contains(nuevoAprobador.id)) {
          idsAgregados.add(nuevoAprobador.id);
          nuevosAprobadores.add(nuevoAprobador);
        }
      }
    }
    
    listAprobadores
      ..clear()
      ..addAll(nuevosAprobadores);
}


 void addArobbadoresByRole() async {
    final boxUsers = Hive.box<AdapterUser>('users').values.toList();
    final boxShifts = Hive.box<PuestoValue>('staffPosition').values.toList();
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('grupoId');

    final mapaPuestos = {
      for (var puesto in boxShifts) puesto.descripcion: puesto
    };

    final aprobadores = boxUsers.where((usuario) {
      final puesto = mapaPuestos[usuario.puestoDescripcion];
      return (puesto?.turnos?.contains(currentShift!.id) ?? false) &&
          usuario.grupoId == id;
    }).toList();

    final nuevosAprobadores = <modelthird.Value>[];
    final idsAgregados = <int>{};

    for (var user in aprobadores) {
      if (user.roles != null && user.roles!.containsKey('2')) {
        final nuevoAprobador = modelthird.Value(
          id: user.id!,
          nombre: '${user.nombre!} ${user.apePaterno!} ${user.apeMaterno!}',
        );
        
        if (!idsAgregados.contains(nuevoAprobador.id)) {
          idsAgregados.add(nuevoAprobador.id);
          nuevosAprobadores.add(nuevoAprobador);
        }
      }
    }
    
    listAprobadores
      ..clear()
      ..addAll(nuevosAprobadores);
}


void validateInterlok() async {
    if (_currentValueInterlock == 1) {
       addAprobadoresByPuesto();
      notifyListeners();
      return;
    }

    if (_currentValueInterlock == 1 ||
        (_currentValueInterlock == 0 &&
            _currentRiskA?.descripcion.toLowerCase() == 'personas')) {
       addAprobadoresByPuesto();
    } else {
       addArobbadoresByRole();
    }

    // Manejo seguro del solicitante como aprobador
    if (currentStateApplicant != null) {
      final solicitanteValue =modelthird.Value(
        id: currentStateApplicant!.id,
        nombre: '${currentStateApplicant!.nombre} ${currentStateApplicant!.apePaterno ?? ''}',
        apePaterno: '',
      );

      if (_currentRisk?.descripcion.toLowerCase() == 'bajo' &&
          _currentValueInterlock == 0 &&
          _currentRiskA?.descripcion.toLowerCase() != 'personas') {
        // Agregar solo si no existe
        if (!listAprobadores.any((a) => a.id == solicitanteValue.id)) {
          listAprobadores.add(solicitanteValue);
        }
      } else {
        // Remover si existe
        listAprobadores.removeWhere((a) => a.id == solicitanteValue.id);
      }
    }

    // Eliminar duplicados por si acaso
    final uniqueAprobadores = <modelthird.Value>[];
    final ids = <int>{};
    
    for (var aprobador in listAprobadores) {
      if (!ids.contains(aprobador.id)) {
        ids.add(aprobador.id);
        uniqueAprobadores.add(aprobador);
      }
    }
    
    listAprobadores
      ..clear()
      ..addAll(uniqueAprobadores);

    notifyListeners();
}
}
