class InsertQueryParameters {
  String? id;
  String usuario;
  String tagPrefijo;
  String tagCentro;
  String tagSubfijo;
  String descripcion;
  String disciplina;
  String turno;
  String interlockSeguridad;
  String responsable;
  String riesgoA;
  String riesgo;
  String probabilidad;
  String impacto;
  String solicitante;
  String aprobador;
  String ejecutor;
  String autorizacion;
  String tipoForzado;
  String projectName;

  // Constructor
  InsertQueryParameters({
    this.id,
    required this.usuario,
    required this.tagPrefijo,
    required this.tagCentro,
    required this.tagSubfijo,
    required this.descripcion,
    required this.disciplina,
    required this.turno,
    required this.interlockSeguridad,
    required this.responsable,
    required this.riesgoA,
    required this.riesgo,
    required this.probabilidad,
    required this.impacto,
    required this.solicitante,
    required this.aprobador,
    required this.ejecutor,
    required this.autorizacion,
    required this.tipoForzado,
    required this.projectName,
  });

  // Método para convertir un objeto a un mapa, útil para enviar en la solicitud POST
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario': usuario,
      'tagPrefijo': tagPrefijo,
      'tagCentro': tagCentro,
      'tagSubfijo': tagSubfijo,
      'descripcion': descripcion,
      'disciplina': disciplina,
      'turno': turno,
      'interlockSeguridad': interlockSeguridad,
      'responsable': responsable,
      'riesgo': riesgoA,
      'nivelRiesgo': riesgo,
      'probabilidad': probabilidad,
      'impacto': impacto,
      'solicitante': solicitante,
      'aprobador': aprobador,
      'ejecutor': ejecutor,
      'autorizacion': autorizacion,
      'tipoForzado': tipoForzado,
      'proyecto': projectName,
    };
  }

  // Método para crear un objeto a partir de un mapa (útil para recibir los datos del cuerpo de la petición)
  factory InsertQueryParameters.fromMap(Map<String, dynamic> map) {
    return InsertQueryParameters(
      id: map['id'] ?? '',
      usuario: map['usuario'] ?? '',
      tagPrefijo: map['tagPrefijo'] ?? '',
      tagCentro: map['tagCentro'] ?? '',
      tagSubfijo: map['tagSubfijo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      disciplina: map['disciplina'] ?? '',
      turno: map['turno'] ?? '',
      interlockSeguridad: map['interlockSeguridad'] ?? '',
      responsable: map['responsable'] ?? '',
      riesgoA: map['riesgoA'] ?? '',
      riesgo: map['riesgo'] ?? '',
      probabilidad: map['probabilidad'] ?? '',
      impacto: map['impacto'] ?? '',
      solicitante: map['solicitante'] ?? '',
      aprobador: map['aprobador'] ?? '',
      ejecutor: map['ejecutor'] ?? '',
      autorizacion: map['autorizacion'] ?? '',
      tipoForzado: map['tipoForzado'] ?? '',
      projectName: map['proyectoId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tagPrefijo': tagPrefijo,
      'tagCentro': tagCentro,
      'tagSubfijo': tagSubfijo,
      'descripcion': descripcion,
      'disciplina': disciplina,
      'turno': turno,
      'interlockSeguridad': interlockSeguridad,
      'responsable': responsable,
      'riesgo': riesgo,
      'riesgoA': riesgoA,
      'probabilidad': probabilidad,
      'impacto': impacto,
      'solicitante': solicitante,
      'aprobador': aprobador,
      'ejecutor': ejecutor,
      'autorizacion': autorizacion,
      'tipoForzado': tipoForzado,
    };
  }
}
