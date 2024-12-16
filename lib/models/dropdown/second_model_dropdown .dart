import 'package:forzado/core/abstract/drop_menu_item.dart';

class SecondModel implements DropDownItem {
  final int id;
  final String descripcion;

  SecondModel({
    required this.id,
    required this.descripcion,
  });

  factory SecondModel.fromJson(Map<String, dynamic> json) {
    return SecondModel(
      id: json['id'],
      descripcion: json['descripcion'],
    );
  }

  @override
  String getLabel() => descripcion;
}
