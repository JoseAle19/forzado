class AppUrl {
  // Base URL del servidor
  static const String url =
      "https://sntps2jn-3000.brs.devtunnels.ms"; // Cambia según tu configuración

  // Endpoints  para vitarme equivocacion de rutas
  static const String login = "api/mobile/auth/";

  static const String gettagPrefijo1 = "/api/maestras/subarea";
  static const String getTagCentro1 = "/api/maestras/activo";

  static const String getTagDisciplina2 = "/api/maestras/disciplina";
  static const String getTurno2 = "/api/maestras/impacto";
  static const String getRechazo2 = "/api/maestras/motivo-rechazo";
  static const String getProbabilidad2 = "/api/maestras/probabilidad";
  static const String getRiesgoA2 = "/api/maestras/riesgo-a";
  static const String getTipoForzado2 = "/api/maestras/tipo-forzado";
  static const String getImpacto2 = "/api/maestras/impacto";

  static const String getResponsable3 = "/api/maestras/responsable";
  static const String getSolicitantes3 = "/api/usuarios";

  // Endpoints lista de forzados
  static const String getListForzados = "/api/solicitudes/alta";
}
