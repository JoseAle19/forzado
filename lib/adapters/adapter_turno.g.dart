// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_turno.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterTurnoAdapter extends TypeAdapter<AdapterTurno> {
  @override
  final int typeId = 8;

  @override
  AdapterTurno read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterTurno(
      id: fields[0] as int,
      descripcion: fields[1] as String,
      horaInicio: fields[2] as String,
      horaFin: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterTurno obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.horaInicio)
      ..writeByte(3)
      ..write(obj.horaFin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterTurnoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
