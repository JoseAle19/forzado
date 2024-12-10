import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/aprobador/home_approve.dart';
import 'package:forzado/pages/solicitante/online/widgets/text_info.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/services/service_two.dart';
import 'package:forzado/widgets/custom_dropdown_two.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:intl/intl.dart';

class DetailApproveForzado extends StatefulWidget {
  const DetailApproveForzado(
      {super.key, required this.detailForzado, required this.isAlta});
  final ForzadoM detailForzado;
  final bool isAlta;
  @override
  State<DetailApproveForzado> createState() => _DetailApproveForzadoState();
}

class _DetailApproveForzadoState extends State<DetailApproveForzado> {
  String currentStateapplicant = '';
  String currentStateapprover = '';
  String currentStateejecutor = '';
  // ignore: unused_field, prefer_final_fields
  TextEditingController _controllerDes = TextEditingController();
  String currentValue = '';
  bool isFetching = false;
  String returnDate() {
    if (widget.detailForzado.fecha != null) {
      return DateFormat('dd/MM/yyyy').format(widget.detailForzado.fecha!);
    } else {
      return 'No hay fecha';
    }
  }

  Future<int> executerAlta(String id) async {
    ApiClient client = ApiClient();

    final Map<String, dynamic> body = {'id': id};
    try {
      setState(() {
        isFetching = true;
      });

      String isStateReque = widget.isAlta ? 'alta' : 'baja';
      final res = await client.post(
          '/api/solicitudes/${isStateReque}/aprobar', jsonEncode(body));
      if (res.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => CongratulationAnimation(
                    page: widget.isAlta
                        ? const HomeApprove()
                        : const HomeApprove())),
            (route) => false);
      } else {
        CustomModal modal = CustomModal();
        modal.showModal(context, 'Ocurrio un error', Colors.red, false);
      }
      return 0;
    } catch (e) {
      print('Ocurrió un error $e');
      return 1;
    } finally {
      setState(() {
        isFetching = false;
      });
    }
  }

  Future<int> executerDecline(String id) async {
    CustomModal modal = CustomModal();
    if (currentValue.isEmpty) {
      modal.showModal(context, 'Selecciona un motivo', Colors.red, false);
      return 0;
    }

    ApiClient client = ApiClient();
    final Map<String, dynamic> bodyA = {
      'id': id,
      'observaciones': currentValue.isEmpty
    };
    String isStateReque = widget.isAlta ? 'alta' : 'baja';

    try {
      final res = await client.post(
          '/api/solicitudes/${isStateReque}/rechazar', jsonEncode(bodyA));

      print('respuesta de la peticion ${res.body}');
      if (res.statusCode == 200) {
        print(res.body);
        modal.showModal(context, 'Operacion exitosa', Colors.green, true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => CongratulationAnimation(
                    page: widget.isAlta
                        ? const HomeApprove()
                        : const HomeApprove())),
            (route) => false);
      } else {
        print(res.body);
        print('Error en la solicitud: ${res.statusCode}');
      }
      return 0;
    } catch (e) {
      print('Ocurrió un error $e');
      return 1;
    } finally {
      setState(() {
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Detalles del forzado'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // Encabezado
            _buildHeaderSection(),

            const SizedBox(height: 20),

            // Información de Tags
            _buildTagInfoSection(),

            // Descripción
            _buildDescriptionSection(),

            // Información adicional
            _buildAdditionalInfoSection(),

            const SizedBox(height: 20),

            // Responsable y Riesgo
            _buildResponsableYriesgoSection(),

            const SizedBox(height: 20),

            // Autorización
            _buildAuthorizationSection(),

            const SizedBox(height: 30),

            // Botones de acción
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

// Métodos para organizar secciones

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.detailForzado.id.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Fecha de Solicitud: ${returnDate()}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTagInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextInfo(
          title: 'Tag (Prefijo) *',
          description: 'Prefijo del Tag o Sub Área',
        ),
        TextInfo(
          title: 'Tag (Centro) *',
          description:
              widget.detailForzado.tagCentroDescripcion ?? 'No especificado',
        ),
        TextInfo(
          title: 'Tag (Sub Fijo) *',
          description:
              widget.detailForzado.subareaDescripcion ?? 'No especificado',
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Descripción *',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: widget.detailForzado.descripcion,
                labelStyle:
                    const TextStyle(fontSize: 16, color: Colors.black87),
                filled: true,
                fillColor: const Color(0xFFE0E0E0),
              ),
              maxLines: 5,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInfo(
          title: 'Disciplina',
          description:
              widget.detailForzado.disciplinaDescripcion ?? 'No especificado',
        ),
        TextInfo(
          title: 'Turno',
          description:
              widget.detailForzado.turnoDescripcion?.name ?? 'No especificado',
        ),
      ],
    );
  }

  Widget _buildResponsableYriesgoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Responsable y Riesgo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const TextInfo(
          title: 'Interlock Seguridad',
          description: 'No especificado',
        ),
        TextInfo(
          title: 'Responsable',
          description:
              widget.detailForzado.responsableNombre?.name ?? 'No especificado',
        ),
        TextInfo(
          title: 'Riesgo',
          description:
              widget.detailForzado.riesgoDescripcion?.name ?? 'No especificado',
        ),
        const TextInfo(
          title: 'Probabilidad',
          description: 'No especificado',
        ),
        const TextInfo(
          title: 'Impacto',
          description: 'No especificado',
        ),
      ],
    );
  }

  Widget _buildAuthorizationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Autorización',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextInfo(
          title: 'Solicitante (AN)',
          description: widget.detailForzado.solicitante ?? 'No especificado',
        ),
        const TextInfo(
          title: 'Aprobador',
          description: 'No especificado',
        ),
        const TextInfo(
          title: 'Ejecutor',
          description: 'No especificado',
        ),
        const TextInfo(
          title: 'Autorización',
          description: 'No especificado',
        ),
        TextInfo(
          title: 'Tipo de Forzado',
          description: widget.detailForzado.tipoForzadoDescripcion?.name ??
              'No especificado',
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return isFetching
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (isFetching) return;
                  executerAlta(widget.detailForzado.id.toString());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff009283),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Aprobar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              widget.isAlta == false && isFetching
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            bool isFetch = false;
                            ServiceTwo serviceTwo = ServiceTwo(ApiClient());
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text(
                                    'Selecciona un Motivo',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomDropDownButtonTwo(
                                        service: serviceTwo,
                                        descriptionField: 'Motivos de la baja',
                                        hintText:
                                            'Selecciona un motivo de baja',
                                        endPoint: AppUrl.getMotivoRechazo,
                                        currentValue: currentValue,
                                        onChanged: (value) {
                                          setState(() {
                                            currentValue = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        setState(() {
                                          isFetch = true;
                                        });
                                        await executerDecline(
                                            widget.detailForzado.id.toString());
                                        setState(() {
                                          isFetch = false;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: isFetching
                                            ? Colors.orange
                                            : Colors.red,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                      ),
                                      child: Text(
                                          isFetch ? 'Procesando' : 'Rechazar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.grey,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                      ),
                                      child: const Text('Cancelar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff920000),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                      child: const Text(
                        'Rechazar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
            ],
          );
  }
}
