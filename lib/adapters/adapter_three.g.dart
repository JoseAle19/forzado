// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_three.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterThreeAdapter extends TypeAdapter<AdapterThree> {
  @override
  final int typeId = 2;

  @override
  AdapterThree read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterThree(
      id: fields[0] as int,
      nombre: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterThree obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterThreeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
