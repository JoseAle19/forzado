// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_one.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterOneAdapter extends TypeAdapter<AdapterOne> {
  @override
  final int typeId = 0;

  @override
  AdapterOne read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterOne(
      id: fields[0] as int,
      codigo: fields[1] as String,
      descripcion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterOne obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.codigo)
      ..writeByte(2)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterOneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
