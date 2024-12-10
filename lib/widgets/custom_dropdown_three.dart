import 'package:flutter/material.dart';
import 'package:forzado/models/model_three.dart';
import 'package:forzado/services/service_three.dart';

// ignore: must_be_immutable
class CustomDropDownButtonThree extends StatefulWidget {
  CustomDropDownButtonThree({
    super.key,
    required this.descriptionField,
    required this.hintText,
    this.service,
    required this.endPoint,
    required this.currentValue,
    required this.onChanged,
  });

  final String descriptionField;
  final String hintText;
  final ServiceThree? service;
  final String endPoint;
  String currentValue = '';
  final ValueChanged<String> onChanged;

  @override
  State<CustomDropDownButtonThree> createState() =>
      _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButtonThree> {
  late Future<ModelThree> _futureModel;
  late List<Value> items = [];

  @override
  void initState() {
    super.initState();
    _futureModel = widget.service!.getDataByEndpoint(widget.endPoint);
    _loadCentros();
  }

  Future<void> _loadCentros() async {
    try {
      final result = await _futureModel;
      if (!mounted) return;
      setState(() {
        items = result.values;
      });
    } catch (e) {
      if (mounted) {
        // Puedes manejar errores aquí si es necesario
        print('Error loading data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(widget.descriptionField),
        FutureBuilder<ModelThree>(
          future: _futureModel,
          builder: (BuildContext context, AsyncSnapshot<ModelThree> snapshot) {
            if (snapshot.hasError) {
              return const Text('Error al cargar los centros');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: DropdownButtonFormField(
                      value: null,
                      hint: const Text('Cargando.......'),
                      items: [],
                      onChanged: null));
            }
            if (snapshot.data?.success == false) {
              return const Text(
                  'Ocurró un errorr, Por favor contacta a soporte');
            }
            final items = snapshot.data!.values;
            if (items.isEmpty) {
              return const Text(
                  'No hay informacion disponible, por favor contacta a soporte');
            }
            return DropdownButtonFormField(
                value: widget.currentValue.isEmpty ? null : widget.currentValue,
                hint: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      widget.hintText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                items: items.map((item) {
                  return DropdownMenuItem(
                      value: item.id.toString(),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          item.nombre,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ));
                }).toList(),
                validator: (value) =>
                    value == null ? 'Seleccione una opción válida' : null,
                onChanged: (value) {
                  setState(() {
                    widget.onChanged(
                        value!); // Llamas al callback para notificar al padre
                  });
                });
          },
        ),
      ],
    );
  }
}
