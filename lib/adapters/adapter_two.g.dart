// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_two.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterTwoAdapter extends TypeAdapter<AdapterTwo> {
  @override
  final int typeId = 1;

  @override
  AdapterTwo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterTwo(
      id: fields[0] as int,
      descripcion: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterTwo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterTwoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
