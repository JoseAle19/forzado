// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adapter_tag_forzado.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterTagForzadoAdapter extends TypeAdapter<AdapterTagForzado> {
  @override
  final int typeId = 21;

  @override
  AdapterTagForzado read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterTagForzado(
      id: fields[0] as int?,
      prefijoId: fields[1] as int?,
      centroId: fields[2] as int?,
      sufijo: fields[3] as String?,
      probabilidadDescripcion: fields[4] as String?,
      impactoDescripcion: fields[5] as String?,
      probabilidadId: fields[6] as int?,
      impactoId: fields[7] as int?,
      descripcion: fields[8] as String?,
      tagConcat: fields[9] as String?,
      prefijoCodigo: fields[10] as String?,
      prefijoDescripcion: fields[11] as String?,
      centroCodigo: fields[12] as String?,
      centroDescripcion: fields[13] as String?,
      interlock: fields[14] as int?,
      riesgoAId: fields[15] as int?,
      riesgoADescripcion: fields[16] as String?,
      interlockDescripcion: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterTagForzado obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.prefijoId)
      ..writeByte(2)
      ..write(obj.centroId)
      ..writeByte(3)
      ..write(obj.sufijo)
      ..writeByte(4)
      ..write(obj.probabilidadDescripcion)
      ..writeByte(5)
      ..write(obj.impactoDescripcion)
      ..writeByte(6)
      ..write(obj.probabilidadId)
      ..writeByte(7)
      ..write(obj.impactoId)
      ..writeByte(8)
      ..write(obj.descripcion)
      ..writeByte(9)
      ..write(obj.tagConcat)
      ..writeByte(10)
      ..write(obj.prefijoCodigo)
      ..writeByte(11)
      ..write(obj.prefijoDescripcion)
      ..writeByte(12)
      ..write(obj.centroCodigo)
      ..writeByte(13)
      ..write(obj.centroDescripcion)
      ..writeByte(14)
      ..write(obj.interlock)
      ..writeByte(15)
      ..write(obj.riesgoAId)
      ..writeByte(16)
      ..write(obj.riesgoADescripcion)
      ..writeByte(17)
      ..write(obj.interlockDescripcion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterTagForzadoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
