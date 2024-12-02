class AppUrl {
  // Base URL del servidor
  static const String url =
      "https://sntps2jn-3001.brs.devtunnels.ms"; // Cambia según tu configuración

  // Endpoints  para vitarme equivocacion de rutas
  static const String login = "api/mobile/auth/";

  static const String gettagPrefijo1 = "/api/maestras/subarea";
  static const String getTagCentro1 = "/api/maestras/activo";

  static const String getTagDisciplina2 = "/api/maestras/disciplina";
  static const String getTurno2 = "/api/maestras/turno";
  static const String getRechazo2 = "/api/maestras/motivo-rechazo";
  static const String getProbabilidad2 = "/api/maestras/probabilidad";
  static const String getRiesgoA2 = "/api/maestras/riesgo-a";
  static const String getTipoForzado2 = "/api/maestras/tipo-forzado";
  static const String getImpacto2 = "/api/maestras/impacto";

  static const String getResponsable3 = "/api/maestras/responsable";
  static const String getSolicitantes3 = "/api/usuarios";
  static const String getEjecutor = "/api/usuarios";
  static const String getAprobadores = "/api/usuarios/aprobadores";

// Endpoitn de alta de forzado
  static const String postAddForzado = "/api/solicitudes/alta";
  static const String postForcedForzado = "/api/solicitudes/baja";
  static const String getListForzados = "/api/solicitudes/alta";
}
