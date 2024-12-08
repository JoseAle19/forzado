import 'package:hive/hive.dart';

part 'adapter_forzados.g.dart';

@HiveType(typeId: 4) // TypeId único para identificar este modelo
class Forzados {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nombre;
  @HiveField(2)
  final String area;
  @HiveField(3)
  final String solicitante;
  @HiveField(4)
  final String estado;
  @HiveField(5)
  final DateTime? fecha;
  @HiveField(6)
  final String descripcion;
  @HiveField(7)
  final String estadoSolicitud;
  @HiveField(8)
  final DateTime? fechaRealizacion;
  @HiveField(9)
  final DateTime? fechaCierre;
  @HiveField(10)
  final String usuarioCreacion;
  @HiveField(11)
  final DateTime? fechaCreacion;
  @HiveField(12)
  final String usuarioModificacion;
  @HiveField(13)
  final DateTime? fechaModificacion;
  @HiveField(14)
  final String subareaCodigo;
  @HiveField(15)
  final String subareaDescripcion;
  @HiveField(16)
  final String disciplinaDescripcion;
  @HiveField(17)
  final String turnoDescripcion;
  @HiveField(18)
  final String motivoRechazoDescripcion;
  @HiveField(19)
  final String tipoForzadoDescripcion;
  @HiveField(20)
  final String tagCentroCodigo;
  @HiveField(21)
  final String tagCentroDescripcion;
  @HiveField(22)
  final String responsableNombre;
  @HiveField(23)
  final String riesgoDescripcion;

  Forzados({
    required this.id,
    required this.nombre,
    required this.area,
    required this.solicitante,
    required this.estado,
    required this.fecha,
    required this.descripcion,
    required this.estadoSolicitud,
    required this.fechaRealizacion,
    required this.fechaCierre,
    required this.usuarioCreacion,
    required this.fechaCreacion,
    required this.usuarioModificacion,
    required this.fechaModificacion,
    required this.subareaCodigo,
    required this.subareaDescripcion,
    required this.disciplinaDescripcion,
    required this.turnoDescripcion,
    required this.motivoRechazoDescripcion,
    required this.tipoForzadoDescripcion,
    required this.tagCentroCodigo,
    required this.tagCentroDescripcion,
    required this.responsableNombre,
    required this.riesgoDescripcion,
  });
  factory Forzados.fromJson(Map<String, dynamic> json) {
    return Forzados(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? 'Sin información',
      area: json['area'] ?? 'Sin información',
      solicitante: json['solicitante'] ?? 'Sin información',
      estado: json['estado'] ?? 'Sin información',
      fecha: json['fecha'] != null ? DateTime.tryParse(json['fecha']) : null,
      descripcion: json['descripcion'] ?? 'Sin información',
      estadoSolicitud: json['estadoSolicitud'] ?? 'Sin información',
      fechaRealizacion: json['fechaRealizacion'] != null
          ? DateTime.tryParse(json['fechaRealizacion'])
          : null,
      fechaCierre: json['fechaCierre'] != null
          ? DateTime.tryParse(json['fechaCierre'])
          : null,
      usuarioCreacion: json['usuarioCreacion'] ?? 'Sin información',
      fechaCreacion: json['fechaCreacion'] != null
          ? DateTime.tryParse(json['fechaCreacion'])
          : null,
      usuarioModificacion: json['usuarioModificacion'] ?? 'Sin información',
      fechaModificacion: json['fechaModificacion'] != null
          ? DateTime.tryParse(json['fechaModificacion'])
          : null,
      subareaCodigo: json['subareaCodigo'] ?? 'Sin información',
      subareaDescripcion: json['subareaDescripcion'] ?? 'Sin información',
      disciplinaDescripcion: json['disciplinaDescripcion'] ?? 'Sin información',
      turnoDescripcion: json['turnoDescripcion'] ?? 'Sin información',
      motivoRechazoDescripcion:
          json['motivoRechazoDescripcion'] ?? 'Sin información',
      tipoForzadoDescripcion:
          json['tipoForzadoDescripcion'] ?? 'Sin información',
      tagCentroCodigo: json['tagCentroCodigo'] ?? 'Sin información',
      tagCentroDescripcion: json['tagCentroDescripcion'] ?? 'Sin información',
      responsableNombre: json['responsableNombre'] ?? 'Sin información',
      riesgoDescripcion: json['riesgoDescripcion'] ?? 'Sin información',
    );
  }
}
