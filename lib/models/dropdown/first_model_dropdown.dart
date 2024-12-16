import 'package:forzado/core/abstract/drop_menu_item.dart';

class FirstModel implements DropDownItem {
  final int id;
  final String codigo;
  final String descripcion;

  FirstModel({
    required this.id,
    required this.codigo,
    required this.descripcion,
  });

  factory FirstModel.fromJson(Map<String, dynamic> json) {
    return FirstModel(
      id: json['id'],
      codigo: json['codigo'],
      descripcion: json['descripcion'],
    );
  }

  @override
  String getLabel() => descripcion;
}
