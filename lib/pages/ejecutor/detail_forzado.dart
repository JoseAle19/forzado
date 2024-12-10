import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forzado/core/urls.dart';
import 'package:forzado/models/remove_forzado/model_list_remove.dart';
import 'package:forzado/pages/ejecutor/forzados_executer.dart';
import 'package:forzado/pages/steps_form/congratulation.dart';
import 'package:forzado/services/api_client.dart';
import 'package:forzado/widgets/modal_error.dart';
import 'package:intl/intl.dart';

class DetailForzadoScreen extends StatefulWidget {
  const DetailForzadoScreen(
      {super.key, required this.forzado, required this.isExecuterAlta});
  final ForzadoM forzado;
  final bool isExecuterAlta;
  @override
  State<DetailForzadoScreen> createState() => _DetailForzadoScreenState();
}

class _DetailForzadoScreenState extends State<DetailForzadoScreen> {
  bool isFetching = false; // Variable para controlar el estado de carga
  DateTime? selectedDateTime ;

  void initState() {
    super.initState();
    // selectedDateTime = DateTime.now();
  }
 Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          selectedDateTime?.hour ?? 0,
          selectedDateTime?.minute ?? 0,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: selectedDateTime?.hour ?? TimeOfDay.now().hour,
        minute: selectedDateTime?.minute ?? TimeOfDay.now().minute,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime?.year ?? DateTime.now().year,
          selectedDateTime?.month ?? DateTime.now().month,
          selectedDateTime?.day ?? DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }


String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return 'No seleccionada';
    }

    final DateFormat dateFormatter = DateFormat('d \'de\' MMMM \'del\' y', 'es_ES');
    final String formattedDate = dateFormatter.format(dateTime);

    final String formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return '$formattedDate a las $formattedTime';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles Forzado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información inicial
              Text(
                'Fecha de Solicitud:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.forzado.fecha != null
                    ? "${widget.forzado.fecha!.day}/${widget.forzado.fecha!.month}/${widget.forzado.fecha!.year}"
                    : 'No especificada',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Solicitante:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.forzado.solicitante ?? 'No especificado',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                'Aprobador:',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.forzado.usuarioModificacion ?? 'No especificado',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Divider(),

              // Campos de información visual
              const Text(
                'Tag (Prefijo)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.forzado.subareaCodigo ?? 'Prefijo del Tag o Sub Área',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tag (Centro)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.forzado.tagCentroDescripcion ??
                      'Parte Central del Tag Asoc. al instrumento o Equipo',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tag (Sub Fijo) *',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.forzado.tagCentroCodigo ?? 'Ingrese Sub Fijo del Tag',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),
 Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Fecha y hora seleccionada:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _formatDateTime(selectedDateTime),
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.date_range, color: Colors.white,),
              label: Text('Seleccionar Fecha', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _selectTime(context),
              icon: const Icon(Icons.access_time, color: Colors.white,),
              label: Text('Seleccionar Hora', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    
              const Divider(),

              // Indicador de carga
              if (isFetching)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Center(
                  child: GestureDetector(
                    onTap: () async {

                      if(selectedDateTime==null) return;

                      await handleExecution(
                          widget.forzado.id.toString(), widget.isExecuterAlta,
                          selectedDateTime
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        color: selectedDateTime!=null? const Color(0xff009283) : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Ejecutar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
             
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleExecution(String id, bool iisExecuterAlta, DateTime? date) async {
    CustomModal modal = CustomModal();
    setState(() {
      isFetching = true;
    });

    int result = await executerAlta(id, iisExecuterAlta, date);

    setState(() {
      isFetching = false;
    });

    if (result == 0) {
      modal.showModal(context, 'Ejecutado', Colors.green, true);
      final route = MaterialPageRoute(
          builder: (_) => CongratulationAnimation(
                  page: ListExecuterForzado(
                isExecuterAlta: iisExecuterAlta == true ? true : false,
              )));
      Navigator.pushReplacement(context, route);
    } else {
      modal.showModal(
          context, 'Ocurrio un error, contacta a soporte', Colors.red, false);
    }
  }

  Future<int> executerAlta(String id, bool isAlta, DateTime? date) async {


    final detaFormat = '${date!.toIso8601String().split('T')[0]}T${date!.hour.toString().padLeft(2, '0')}:${date!.minute.toString().padLeft(2, '0')}';

    ApiClient client = ApiClient();
    final Map<String, dynamic> body = {'fechaEjecucion':detaFormat,'id': id};
    try {
      final res = await client.post(
          isAlta ? AppUrl.postEjecutarAlta : AppUrl.postEjecutarBaja,
          jsonEncode(body));
      print(res.statusCode);
      if (res.statusCode == 200) {
        return 0;
      } else {
        return 1;
      }
    } catch (e) {
      print('Ocurrió un error $e');
      return 1;
    }
  }
}
