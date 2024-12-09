// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forzado_baja.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForzadoBajaAdapter extends TypeAdapter<ForzadoBaja> {
  @override
  final int typeId = 5;

  @override
  ForzadoBaja read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForzadoBaja(
      id: fields[0] as int?,
      descripcion: fields[1] as String?,
      idApplicant: fields[2] as int?,
      descripcionApplicant: fields[3] as String?,
      idApprover: fields[5] as int?,
      descripcionApprover: fields[6] as String?,
      idExecutor: fields[7] as int?,
      descripcionExecutor: fields[8] as String?,
      id_forzado: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ForzadoBaja obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.idApplicant)
      ..writeByte(3)
      ..write(obj.descripcionApplicant)
      ..writeByte(4)
      ..write(obj.id_forzado)
      ..writeByte(5)
      ..write(obj.idApprover)
      ..writeByte(6)
      ..write(obj.descripcionApprover)
      ..writeByte(7)
      ..write(obj.idExecutor)
      ..writeByte(8)
      ..write(obj.descripcionExecutor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForzadoBajaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
