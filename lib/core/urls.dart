class AppUrl {
  // Base URL del servidor
  static const String url = "https://sntps2jn-3001.brs.devtunnels.ms";
  // Cambia según tu configuración

  // Endpoints  para vitarme equivocacion de rutas
  static const String login = "/api/mobile/auth/";

  static const String gettagPrefijo1 = "/api/maestras/subarea";
  static const String getTagCentro1 = "/api/maestras/activo";

  static const String getTagDisciplina2 = "/api/maestras/disciplina";
  static const String getCircuitos2 = "/api/maestras/circuito";
  static const String getTurno2 = "/api/maestras/turno";
  static const String getRechazo2 = "/api/maestras/motivo-rechazo";
  static const String getProbabilidad2 = "/api/maestras/probabilidad";
  static const String getRiesgoA2 = "/api/maestras/riesgo-a";
  static const String getTipoForzado2 = "/api/maestras/tipo-forzado";
  static const String getImpacto2 = "/api/maestras/impacto";
  static const String getProjects2 = "/api/maestras/proyecto";

  static const String getResponsable3 = "/api/maestras/responsable";
  static const String getSolicitantes3 = "/api/usuarios";
  static const String getEjecutor = "/api/usuarios";
  static const String getAprobadores = "/api/usuarios/aprobadores";

// Endpoitn de forzado de forzado
  static const String postAddForzado = "/api/solicitudes/forzado";
  static const String postForcedForzado = "/api/solicitudes/retiro";
  static const String getListForzados = "/api/solicitudes/forzado";

  static const String postEjecutarforzado = "/api/solicitudes/forzado/ejecutar";
  static const String postEjecutaretiro = "/api/solicitudes/retiro/ejecutar";

  static const String getMotivoRechazo = "/api/maestras/motivo-rechazo";

  static const String getforzadoRechazar = "/api/solicitudes/forzado/rechazar";
  static const String getretiroAprobar = "/api/solicitudes/retiro/aprobar";

  static const String getForzadoByState = "/api/solicitudes/estado";

  static const String getListUsers = "/api/usuarios";

  // validar si la regla se puede aplicar o no

  static const String isEnabledRuleRisk = "/api/parametros-globales";
  static const String tagsMatrizRiesgo = "/api/maestras/tags-matriz-riesgo";

  
  
  
  static const String getGrupos = "/api/maestras/grupo";
  //Para los turnos
  static const String getturnos = "/api/maestras/turno";
  static const String getPuestos = "/api/puesto-turno";



  // combinacionaciones de la matriz de riesgo
  static const String getMatrizRiesgo= "/api/maestras/matriz-riesgo";
  
}
