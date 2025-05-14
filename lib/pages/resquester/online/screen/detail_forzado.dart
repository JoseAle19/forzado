import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/core/utils/preferences_helper.dart';
import 'package:forzado/data/providers/dropdown/dropdown_provider.dart';
import 'package:forzado/data/providers/forzados/forzados_provider.dart';
import 'package:forzado/data/providers/maestras.dart';
import 'package:forzado/models/form/forzado/request_forced_forzado.dart';
import 'package:forzado/models/forzado/model_forzado.dart';
import 'package:forzado/models/model_three.dart' as modelThree;
import 'package:forzado/models/model_two.dart' as modelTwo;
import 'package:forzado/models/model_user_detail.dart';
import 'package:forzado/pages/resquester/home_requester.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/custom_dropdown_button.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailsForzadorRequester extends StatefulWidget {
  const DetailsForzadorRequester({super.key, required this.detailForzado});
  final ForzadoItem detailForzado;

  @override
  State<DetailsForzadorRequester> createState() => _FormRemoveForzadoState();
}

enum ValuesType { applicant, approver, executor, description, grupo }

class _FormRemoveForzadoState extends State<DetailsForzadorRequester> {
  bool isFetching = false;
  String currentStateapplicant = '';
  String currentStateapprover = '';
  String currentStateexecutor = '';

  String currentValueDescription = "";
  String currentValueGrupo = "";

  bool _obteniendoData = false;
  String _estadoDeLaConsulta = '';

  void _updateCurrentValue(ValuesType valueType, String newValue) {
    setState(() {
      switch (valueType) {
        case ValuesType.applicant:
          currentStateapplicant = newValue;
          break;
        case ValuesType.approver:
          currentStateapprover = newValue;
          break;
        case ValuesType.executor:
          currentStateexecutor = newValue;
          break;
        case ValuesType.description:
          currentValueDescription = newValue;
          break;
        case ValuesType.grupo:
          currentValueGrupo = newValue;
          break;
      }
    });
  }

  Future<void> sendRequestForcedForzado() async {
    CustomModal modal = CustomModal();
    if (currentStateapplicant.isEmpty ||
        currentStateapprover.isEmpty ||
        currentValueGrupo.isEmpty ||
        currentValueDescription.isEmpty) {
      modal.showModal(
          context, 'Debes de llenar todos los campos', Colors.red, false);
      return;
    }
    FormRemoveForzadoQueryParameters data = FormRemoveForzadoQueryParameters(
      solicitanteRetiro: currentStateapplicant,
      aprobadorRetiro: currentStateapprover,
      ejecutorRetiro: 'default value',
      observaciones: currentValueDescription,
      tipoGrupoB: currentValueGrupo,
      id: widget.detailForzado.id.toString(),
    );
    try {
      setState(() {
        isFetching = true;
      });
      ApiClient client = ApiClient();
      final response = await client.post(
          AppUrl.postForcedForzado, json.encode(data.toJson()));

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CongratulationAnimation(
                    page: const Home(),
                  )),
        );
      } else {
        modal.showModal(context, 'Ocurrio un error: ${response.statusCode}',
            Colors.red, false);
      }
    } catch (e) {
      modal.showModal(context, 'Ocurrio un error interno en el servidor',
          Colors.red, false);
    } finally {
      setState(() {
        isFetching = false;
      });
    }
  }

  modelThree.Value? usuarioSolicitante = null;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        try {
          // Inicio del proceso
          setState(() {
            _obteniendoData = true;
            _estadoDeLaConsulta = 'Iniciando obtención de datos...';
          });
          debugPrint('🟡 Estado: $_estadoDeLaConsulta');

          // Obtener datos del dropdown
          setState(() {
            _estadoDeLaConsulta = 'Cargando lista de solicitantes...';
          });
          debugPrint('🟡 Estado: $_estadoDeLaConsulta');

          final dropdownProvider = Provider.of<DropDownValuesManagerProvider>(
              context,
              listen: false);
          await dropdownProvider.getData2();
          debugPrint(
              '✅ Lista de solicitantes cargada (${dropdownProvider.listSolicitantes.length} elementos)');

          // Obtener turnos
          setState(() {
            _estadoDeLaConsulta = 'Cargando turnos disponibles...';
          });
          debugPrint('🟡 Estado: $_estadoDeLaConsulta');

          final mastersProvider =
              Provider.of<MastersProvider>(context, listen: false);
          await mastersProvider.getShifts();
          debugPrint('✅ Turnos cargados exitosamente');

          // Obtener usuario actual
          setState(() {
            _estadoDeLaConsulta = 'Verificando usuario autenticado...';
          });
          debugPrint('🟡 Estado: $_estadoDeLaConsulta');

          final ApiResponseDetailUser? _user = PreferencesHelper().getUser();
          if (_user == null) {
            throw Exception('Usuario no autenticado o ID no disponible');
          }
          debugPrint('✅ Usuario verificado (ID: ${_user.id})');

          // Buscar solicitante
          setState(() {
            _estadoDeLaConsulta = 'Espera...';
          });
          debugPrint('🟡 Estado: $_estadoDeLaConsulta');
          debugPrint(
              '🔍 Buscando ID ${_user.id} en ${dropdownProvider.listSolicitantes.length} elementos');

          final solicitante = dropdownProvider.listSolicitantes.firstWhere(
              (u) => u.id == _user.id,
              orElse: () => throw Exception(
                  "Usuario con ID ${_user.id} no encontrado en la lista de solicitantes"));

          // Asignar valores encontrados
          usuarioSolicitante = solicitante;
          _updateCurrentValue(ValuesType.applicant, solicitante.id.toString());
          debugPrint('✅ Usuario asignado como solicitante: ${solicitante.id}');

          // Finalización exitosa
          setState(() {
            _obteniendoData = false;
            _estadoDeLaConsulta = 'Carga completada exitosamente';
          });
          debugPrint('🟢 Estado: $_estadoDeLaConsulta');
        } catch (e) {
          // Manejo de errores
          debugPrint('🔴 Error: $e');
          setState(() {
            _obteniendoData = false;
            _estadoDeLaConsulta =
                'Error: ${e.toString().replaceAll('Exception: ', '')}';
          });

          if (mounted) {
            // Opcional: Mostrar snackbar con el error
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
              duration: const Duration(seconds: 4),
            ));
          }
        }
      }
    });
  }

  String _fixEncoding(String raw) {
    try {
      // toma cada código de carácter como Latin1 y lo reinterpreta como UTF-8
      return utf8.decode(latin1.encode(raw));
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dropdownProvider =
        Provider.of<DropDownValuesManagerProvider>(context);
    final forzadosProvider = Provider.of<ForzadosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.detailForzado.id.toString(),
          child: Text(
            _fixEncoding(widget.detailForzado.descripcion ?? 'No hay descripción'),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropdownButton<modelThree.Value>(
                    hintText: 'Solicitante Retiro *:',
                    items: dropdownProvider.listSolicitantes,
                    selectedItem: usuarioSolicitante,
                    onChanged: (value) {
                      _updateCurrentValue(
                          ValuesType.applicant, value!.id.toString());
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownButton<modelThree.Value>(
                    hintText: 'Aprobador Retiro *:',
                    items: dropdownProvider.listAprobadores,
                    // selectedItem: dropdownProvider.currentStateApplicant,
                    onChanged: (value) {
                      _updateCurrentValue(
                          ValuesType.approver, value!.id.toString());
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropdownButton<modelTwo.Value>(
                    hintText: 'Grupo de Ejecución *:',
                    items: dropdownProvider.listGrupos,
                    // selectedItem: dropdownProvider.currentStateGrupo,
                    onChanged: (value) {
                      _updateCurrentValue(
                          ValuesType.grupo, value!.id.toString());
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Observaciones *'),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        initialValue: currentValueDescription,
                        onChanged: (value) =>
                            _updateCurrentValue(ValuesType.description, value),
                        maxLength: 100,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          hintText: 'Agregue una descripción',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade50),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 15),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  isFetching
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () async {
                            if (!isFetching) sendRequestForcedForzado();
                            await forzadosProvider.fetchCountForzados();
                            await forzadosProvider.getForzados();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: const Center(
                              child: Text(
                                'Finalizar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          _obteniendoData == false
              ? const SizedBox()
              : Container(
                  color: const Color.fromARGB(147, 0, 0, 0),
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Indicador circular con color dinámico
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (_obteniendoData)
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _estadoDeLaConsulta.contains('Error')
                                          ? Colors.red
                                          : Colors.blueAccent,
                                    ),
                                    strokeWidth: 5,
                                  )
                                else
                                  Icon(
                                    _estadoDeLaConsulta.contains('Error')
                                        ? Icons.error_outline
                                        : Icons.check_circle_outline,
                                    size: 50,
                                    color: _estadoDeLaConsulta.contains('Error')
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Título del estado
                          Text(
                            _obteniendoData
                                ? 'Procesando...'
                                : _estadoDeLaConsulta.contains('Error')
                                    ? 'Error'
                                    : 'Completado',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _estadoDeLaConsulta.contains('Error')
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),

                          const SizedBox(height: 15),

                          // Descripción detallada
                          Text(
                            _estadoDeLaConsulta,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Barra de progreso lineal (opcional)
                          if (_obteniendoData)
                            LinearProgressIndicator(
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                              minHeight: 6,
                            ),

                          // Botón para reintentar en caso de error
                          if (_estadoDeLaConsulta.contains('Error'))
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  // Coloca aquí la función para reintentar
                                  // _tuFuncionParaReintentar();
                                },
                                child: const Text(
                                  'Reintentar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
