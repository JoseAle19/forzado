// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_matriz_riesgo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterMatrizRiesgoAdapter extends TypeAdapter<AdapterMatrizRiesgo> {
  @override
  final int typeId = 20;

  @override
  AdapterMatrizRiesgo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterMatrizRiesgo(
      id: fields[0] as int,
      impactoId: fields[1] as int,
      riesgoId: fields[2] as int,
      probabilidadId: fields[3] as int,
      nivel: fields[4] as int,
      estado: fields[5] as int,
      impactoDescripcion: fields[6] as String,
      probabilidadDescripcion: fields[7] as String,
      riesgoDescripcion: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterMatrizRiesgo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.impactoId)
      ..writeByte(2)
      ..write(obj.riesgoId)
      ..writeByte(3)
      ..write(obj.probabilidadId)
      ..writeByte(4)
      ..write(obj.nivel)
      ..writeByte(5)
      ..write(obj.estado)
      ..writeByte(6)
      ..write(obj.impactoDescripcion)
      ..writeByte(7)
      ..write(obj.probabilidadDescripcion)
      ..writeByte(8)
      ..write(obj.riesgoDescripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterMatrizRiesgoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
