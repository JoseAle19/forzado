// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_tags.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterTagsAdapter extends TypeAdapter<AdapterTags> {
  @override
  final int typeId = 7;

  @override
  AdapterTags read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterTags(
      id: fields[0] as int?,
      prefijoId: fields[1] as int?,
      centroId: fields[2] as int?,
      sufijo: fields[3] as String?,
      probabilidadId: fields[4] as int?,
      impactoId: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterTags obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.prefijoId)
      ..writeByte(2)
      ..write(obj.centroId)
      ..writeByte(3)
      ..write(obj.sufijo)
      ..writeByte(4)
      ..write(obj.probabilidadId)
      ..writeByte(5)
      ..write(obj.impactoId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterTagsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
