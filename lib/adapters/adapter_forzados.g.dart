// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_forzados.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForzadosAdapter extends TypeAdapter<Forzados> {
  @override
  final int typeId = 4;

  @override
  Forzados read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forzados(
      id: fields[0] as int,
      nombre: fields[1] as String,
      area: fields[2] as String,
      solicitante: fields[3] as String,
      estado: fields[4] as String,
      fecha: fields[5] as DateTime?,
      descripcion: fields[6] as String,
      estadoSolicitud: fields[7] as String,
      fechaRealizacion: fields[8] as DateTime?,
      fechaCierre: fields[9] as DateTime?,
      usuarioCreacion: fields[10] as String,
      fechaCreacion: fields[11] as DateTime?,
      usuarioModificacion: fields[12] as String,
      fechaModificacion: fields[13] as DateTime?,
      subareaCodigo: fields[14] as String,
      subareaDescripcion: fields[15] as String,
      disciplinaDescripcion: fields[16] as String,
      turnoDescripcion: fields[17] as String,
      motivoRechazoDescripcion: fields[18] as String,
      tipoForzadoDescripcion: fields[19] as String,
      tagCentroCodigo: fields[20] as String,
      tagCentroDescripcion: fields[21] as String,
      responsableNombre: fields[22] as String,
      riesgoDescripcion: fields[23] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Forzados obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.area)
      ..writeByte(3)
      ..write(obj.solicitante)
      ..writeByte(4)
      ..write(obj.estado)
      ..writeByte(5)
      ..write(obj.fecha)
      ..writeByte(6)
      ..write(obj.descripcion)
      ..writeByte(7)
      ..write(obj.estadoSolicitud)
      ..writeByte(8)
      ..write(obj.fechaRealizacion)
      ..writeByte(9)
      ..write(obj.fechaCierre)
      ..writeByte(10)
      ..write(obj.usuarioCreacion)
      ..writeByte(11)
      ..write(obj.fechaCreacion)
      ..writeByte(12)
      ..write(obj.usuarioModificacion)
      ..writeByte(13)
      ..write(obj.fechaModificacion)
      ..writeByte(14)
      ..write(obj.subareaCodigo)
      ..writeByte(15)
      ..write(obj.subareaDescripcion)
      ..writeByte(16)
      ..write(obj.disciplinaDescripcion)
      ..writeByte(17)
      ..write(obj.turnoDescripcion)
      ..writeByte(18)
      ..write(obj.motivoRechazoDescripcion)
      ..writeByte(19)
      ..write(obj.tipoForzadoDescripcion)
      ..writeByte(20)
      ..write(obj.tagCentroCodigo)
      ..writeByte(21)
      ..write(obj.tagCentroDescripcion)
      ..writeByte(22)
      ..write(obj.responsableNombre)
      ..writeByte(23)
      ..write(obj.riesgoDescripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForzadosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
