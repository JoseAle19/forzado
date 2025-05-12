// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_position.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuestoValueAdapter extends TypeAdapter<PuestoValue> {
  @override
  final int typeId = 11;

  @override
  PuestoValue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PuestoValue(
      id: fields[0] as int?,
      descripcion: fields[1] as String?,
      estado: fields[2] as int?,
      aprobadorNivel: fields[3] as String?,
      turnos: (fields[4] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PuestoValue obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.estado)
      ..writeByte(3)
      ..write(obj.aprobadorNivel)
      ..writeByte(4)
      ..write(obj.turnos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuestoValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
