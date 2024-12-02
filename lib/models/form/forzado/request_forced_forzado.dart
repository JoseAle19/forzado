import 'dart:convert';

FormRemoveForzadoQueryParameters formRemoveForzadoModelFromJson(String str) =>
    FormRemoveForzadoQueryParameters.fromJson(json.decode(str));

String formRemoveForzadoModelToJson(FormRemoveForzadoQueryParameters data) =>
    json.encode(data.toJson());

class FormRemoveForzadoQueryParameters {
  final String solicitanteRetiro;
  final String aprobadorRetiro;
  final String ejecutorRetiro;
  final String observaciones;
  final String id;

  FormRemoveForzadoQueryParameters({
    required this.solicitanteRetiro,
    required this.aprobadorRetiro,
    required this.ejecutorRetiro,
    required this.observaciones,
    required this.id,
  });

  factory FormRemoveForzadoQueryParameters.fromJson(Map<String, dynamic> json) =>
      FormRemoveForzadoQueryParameters(
        solicitanteRetiro: json["solicitanteRetiro"],
        aprobadorRetiro: json["aprobadorRetiro"],
        ejecutorRetiro: json["ejecutorRetiro"],
        observaciones: json["observaciones"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "solicitanteRetiro": solicitanteRetiro,
        "aprobadorRetiro": aprobadorRetiro,
        "ejecutorRetiro": ejecutorRetiro,
        "observaciones": observaciones,
        "id": id,
      };
}
