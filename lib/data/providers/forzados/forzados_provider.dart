import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider_off.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/models/form/forzado/model_forzado.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/services/api_client.dart';
import 'package:http/http.dart' as http;

class ForzadosProvider with ChangeNotifier {
  bool _isFetch = false;
  String? _errorMessage;

  List<ForzadoItem> _forzados = [];
  Future<List<ForzadoItem>>? _futureForzados;

  // Atributo para manejar el mensaje de error
  String? get errorMessage => _errorMessage;

  Future<List<ForzadoItem>>? get futureForzados => _futureForzados;

  int _pendingHighCount = 0;
  int _pendingLowCount = 0;
  int _approvedHighCount = 0;
  int _approvedLowCount = 0;
  int _executedHighCount = 0;
  int _executedLowCount = 0;
  int _finalizedCount = 0;
  int _rejectedHighCount = 0;
  int _rejectedLowCount = 0;

  int get pendingHighCount => _pendingHighCount;
  int get pendingLowCount => _pendingLowCount;
  int get approvedHighCount => _approvedHighCount;
  int get approvedLowCount => _approvedLowCount;
  int get executedHighCount => _executedHighCount;
  int get executedLowCount => _executedLowCount;
  int get finalizedCount => _finalizedCount;
  int get rejectedHighCount => _rejectedHighCount;
  int get rejectedLowCount => _rejectedLowCount;
  bool get isFetch => _isFetch;
  List<ForzadoItem> get forzados => _forzados;
  ApiClient client = ApiClient();

  // Método principal para obtener datos y manejar errores
  Future<void> fetchCountForzados() async {
    _isFetch = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final res = await client.get(AppUrl.getListForzados).timeout(
            const Duration(seconds: 10),
          );

      ModelListForzados decodeData = ModelListForzadosFromJson(res.body);
      if (res.statusCode == 200) {
        _pendingHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'pendiente-forzado')
            .length;
        _pendingLowCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'pendiente-retiro')
            .length;
        _approvedHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'aprobado-forzado')
            .length;
        _approvedLowCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'aprobado-retiro')
            .length;
        _executedHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'ejecutado-forzado')
            .length;
        _executedLowCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'ejecutado-retiro')
            .length;
        _finalizedCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'finalizado')
            .length;
        _rejectedHighCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'rechazado-forzado')
            .length;
        _rejectedLowCount = decodeData.data
            .where((f) => f.estado!.toLowerCase() == 'rechazado-retiro')
            .length;
      } else {
        _errorMessage = decodeData.message.toString();
      }
    } on TimeoutException {
      _errorMessage =
          'La solicitud excedió el tiempo de espera. Intente nuevamente.';
    } on http.ClientException {
      _errorMessage = 'Error al conectar con el servidor. Verifique la URL.';
    } catch (e) {
      _errorMessage =
          'Error interno del servidor. Por favor, intente más tarde.';
    } finally {
      _isFetch = false;
      notifyListeners();
    }
  }

// obtener los forzados en general
  bool _loadingGetForzados = false;
  bool get loadingGetForzados => _loadingGetForzados;
  String? _errorMessageGetForzados = '';
  String? get errorMessageGetForzados => _errorMessageGetForzados;
  Future<void> getForzados() async {
    _loadingGetForzados = true;
    notifyListeners();
    try {
      _errorMessageGetForzados = '';
      _loadingGetForzados = false;

      notifyListeners();
      final res = await client
          .get(AppUrl.getListForzados)
          .timeout(const Duration(seconds: 60));
      if (res.statusCode == 200) {
        final jsonString = utf8.decode(res.bodyBytes);

        // 2) Parseas con tu helper generado por json_serializable o similar
        ForzadosModel decodeData = forzadosModelFromJson(jsonString);
        _forzados = decodeData.data!.map((f) {
          String state = f.estado!.toLowerCase();
          if (state.contains("retiro")) {
            state = state.replaceAll("retiro", "retiro");
            print(state);
          } else if (state.contains("forzado")) {
            state = state.replaceAll("forzado", "forzado");
          }

          return ForzadoItem(
              id: f.id,
              aprobador: f.aprobador,
              aprobadorAId: f.aprobadorAId,
              aprobadorBId: f.aprobadorBId,
              area: f.area,
              descripcion: f.descripcion,
              disciplinaDescripcion: f.disciplinaDescripcion,
              ejecutor: f.ejecutor,
              ejecutorAId: f.ejecutorAId,
              ejecutorBId: f.ejecutorBId,
              estadoSolicitud: f.estadoSolicitud,
              fecha: f.fecha,
              fechaCierre: f.fechaCierre,
              fechaCreacion: f.fechaCreacion,
              fechaModificacion: f.fechaModificacion,
              fechaRealizacion: f.fechaRealizacion,
              motivoRechazoDescripcion: f.motivoRechazoDescripcion,
              nombre: f.nombre,
              responsableNombre: f.responsableNombre,
              riesgoDescripcion: f.riesgoDescripcion,
              solicitanteAId: f.solicitanteAId,
              solicitanteBId: f.solicitanteBId,
              solicitante: f.solicitante,
              subareaCodigo: f.subareaCodigo,
              subareaDescripcion: f.subareaDescripcion,
              tagCentroCodigo: f.tagCentroCodigo,
              tagCentroDescripcion: f.tagCentroDescripcion,
              tipo: f.tipo,
              tipoForzadoDescripcion: f.tipoForzadoDescripcion,
              turnoDescripcion: f.turnoDescripcion,
              usuarioCreacion: f.usuarioCreacion,
              usuarioModificacion: f.usuarioModificacion,
              estado: state,
              interlock: f.interlock,
              observadoEjecucion: f.observadoEjecucion,
              proyectoDescripcion: f.proyectoDescripcion,
              proyectoId: f.proyectoId,
              subarea: f.subarea);
        }).toList();

        _forzados.sort((a, b) {
          DateTime dateA =
              DateTime.tryParse(a.fecha?.toString() ?? '') ?? DateTime(1900);
          DateTime dateB =
              DateTime.tryParse(b.fecha?.toString() ?? '') ?? DateTime(1900);
          return dateB.compareTo(dateA); // descendente
        });
      }
      if (res.statusCode == 500) {
        _errorMessageGetForzados =
            'Error interno del servidor. Por favor, intente más tarde.';
      }
    } on TimeoutException {
      _errorMessageGetForzados =
          'La solicitud excedió el tiempo de espera. Intente nuevamente.';
    } on http.ClientException {
      _errorMessageGetForzados =
          'Error al conectar con el servidor. Verifique la URL.';
    } catch (e) {
      print('Error: ${e}');
      _errorMessageGetForzados =
          'Error interno del servidor. Por favor, intente más tarde.';
    } finally {
      _loadingGetForzados = false;
      notifyListeners();
    }
  }

// Metodos post
  bool _isFecthingPostData = false;
  bool get isFetchingPostData => _isFecthingPostData;

  String _errorMessagePost = '';
  String get errorMessagePostData => _errorMessagePost;

  Future<bool> sendRequestPost(
      BuildContext context,
      DropDownValuesManagerProvider dropdownProvider,
      String id,
      MastersProvider mastersProvider) async {
    final data = InsertQueryParameters(
        id: id.toString(),
        usuario: PreferencesHelper().getUser()!.id.toString(),
        tagPrefijo: dropdownProvider.currentValueTagPrefijo!.id.toString(),
        tagCentro: dropdownProvider.currentValueTagCentro!.id.toString(),
        tagSubfijo: dropdownProvider.currentTagSubfijo,
        descripcion: dropdownProvider.currentValueDescription,
        disciplina: dropdownProvider.currentValueTagDisciplina!.id.toString(),
        turno: mastersProvider.currentShift!.id.toString(),
        interlockSeguridad: dropdownProvider.currentValueInterlock,
        responsable: dropdownProvider.currentStateResponsibility!.id.toString(),
        riesgoA: dropdownProvider.currentStateRisk!.id.toString(),
        riesgo: dropdownProvider.currentRisk!.id.toString(),
        probabilidad: dropdownProvider.currentStateProbability!.id.toString(),
        impacto: dropdownProvider.currentStateImpact!.id.toString(),
        solicitante: dropdownProvider.currentStateApplicant!.id.toString(),
        aprobador: dropdownProvider.currentStateApprover!.id.toString(),
        ejecutor: 'Default value',
        autorizacion: 'Default value',
        tipoForzado: 'Default value',
        projectName: 'Default value',
        circuito: dropdownProvider.currentValueCircuitos!.id.toString(),
        grupoA: dropdownProvider.currentStateGrupo!.id.toString(),
        fechaFinPlanificada: dropdownProvider.date);
    try {
      ApiClient client = ApiClient();
      _isFecthingPostData = true;
      notifyListeners();
      // late res;
      final res = id.isNotEmpty
          ? await client.put(AppUrl.postAddForzado, json.encode(data.toMap()))
          : await client.post(AppUrl.postAddForzado, json.encode(data.toMap()));
      print(res.body);
      print(json.encode(data));
      if (res.statusCode == 200) {
        // para volver a contar los forzados
        _isFecthingPostData = false;
        fetchCountForzados();
        getForzados();
        notifyListeners();
        return true;
      } else if (res.statusCode == 500) {
        _errorMessagePost =
            'Error interno del servidor. Por favor, intente más tarde.';
        _isFecthingPostData = false;
        notifyListeners();
        return false;
      } else {
        _errorMessagePost = 'Error al enviar la solicitud. Intente nuevamente.';
        _isFecthingPostData = false;
        notifyListeners();
        return false;
      }
    } on TimeoutException {
      _errorMessagePost =
          'La solicitud excedió el tiempo de espera. Intente nuevamente.';
      return false;
    } on http.ClientException {
      _errorMessagePost = 'Error al conectar con el servidor.';
      return false;
    } catch (e) {
      print(e);
      _errorMessagePost =
          'Error interno del servidor. Por favor, intente más tarde.';
      return false;
    } finally {
      _isFecthingPostData = false;
      notifyListeners();
    }
    // return errorMessagePostData;
  }

  // Validar step form 1
  bool validateStepFormOne(DropDownValuesManagerProvider dropdownProvider) {
    print('Hola');
    if (dropdownProvider.currentValueTagPrefijo == null) {
      return false;
    }
    if (dropdownProvider.currentValueTagCentro == null) {
      return false;
    }
    if (dropdownProvider.currentValueDescription.toString().isEmpty) {
      return false;
    }
    if (dropdownProvider.currentValueTagDisciplina == null) {
      return false;
    }

    return true;
  }

  bool validateStepFormTwo(DropDownValuesManagerProvider dropdownProvider) {
    if (dropdownProvider.currentValueInterlock.isEmpty) {
      return false;
    }
    if (dropdownProvider.currentStateResponsibility == null) {
      return false;
    }
    if (dropdownProvider.currentStateRisk == null) {
      return false;
    }
    if (dropdownProvider.currentStateProbability == null) {
      return false;
    }
    if (dropdownProvider.currentStateImpact == null) {
      return false;
    }
    return true;
  }

  // Validar step form 3
  bool validateStepFormThree(DropDownValuesManagerProvider dropdownProvider) {
    if (dropdownProvider.currentStateApplicant == null) {
      return false;
    }
    if (dropdownProvider.currentStateApprover == null) {
      return false;
    }

    return true;
  }

// off
  // Validar step form 1
  bool validateStepFormOneOff(DropdownProviderManagerOffline dropdownProvider) {
    if (dropdownProvider.currentValueTagPrefijo == null) {
      return false;
    }
    if (dropdownProvider.currentValueTagCentro == null) {
      return false;
    }
    if (dropdownProvider.currentValueDescription.toString().isEmpty) {
      return false;
    }
    if (dropdownProvider.currentValueTagDisciplina == null) {
      return false;
    }

    return true;
  }

  bool validateStepFormTwoOff(DropdownProviderManagerOffline dropdownProvider) {
    if (dropdownProvider.currentValueInterlock == null) {
      return false;
    }
    if (dropdownProvider.currentStateResponsibility == null) {
      return false;
    }

    if (dropdownProvider.currentStateProbability == null) {
      return false;
    }
    if (dropdownProvider.currentStateImpact == null) {
      return false;
    }
    return true;
  }

  // Validar step form 3
  bool validateStepFormThreeOff(
      DropdownProviderManagerOffline dropdownProvider) {
    if (dropdownProvider.currentStateApplicant == null) {
      return false;
    }
    if (dropdownProvider.currentStateApprover == null) {
      return false;
    }
    if (dropdownProvider.currentStateExecutor == null) {
      return false;
    }

    return true;
  }


}
