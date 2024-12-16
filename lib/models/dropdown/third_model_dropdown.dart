import 'package:forzado/core/abstract/drop_menu_item.dart';

class ThirdModel implements DropDownItem {
  final int id;
  final String nombre;

  ThirdModel({
    required this.id,
    required this.nombre,
  });

  factory ThirdModel.fromJson(Map<String, dynamic> json) {
    return ThirdModel(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  @override
  String getLabel() => nombre;
}
