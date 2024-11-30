import 'package:flutter/material.dart';
import 'package:forzado/models/model_three.dart';
import 'package:forzado/services/service_three.dart';

class CustomDropDownButtonThree extends StatefulWidget {
  const CustomDropDownButtonThree(
      {super.key,
      required this.descriptionField,
      required this.hintText,
      this.service,
      required this.endPoint});
  final String descriptionField;
  final String hintText;
  final ServiceThree? service;
  final String endPoint;

  @override
  State<CustomDropDownButtonThree> createState() =>
      _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButtonThree> {
  String currentValue = '';
  late Future<ModelThree> _futureModel;
  late List<Value> items = [];

  @override
  void initState() {
    super.initState();
    _futureModel = widget.service!.getDataByEndpoint(widget.endPoint);
    _loadCentros();
  }

  Future<void> _loadCentros() async {
    final result = await _futureModel;
    setState(() {
      items = result.values;
    });
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
              return const Center(child: CircularProgressIndicator());
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
                value: currentValue.isEmpty ? null : currentValue,
                hint: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ));
                }).toList(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Selecciona una opción';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    currentValue = value!;
                  });
                });
          },
        ),
      ],
    );
  }
}
