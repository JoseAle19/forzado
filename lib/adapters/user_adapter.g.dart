// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdapterUserAdapter extends TypeAdapter<AdapterUser> {
  @override
  final int typeId = 6;

  @override
  AdapterUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdapterUser(
      apePaterno: fields[0] as String?,
      apeMaterno: fields[1] as String?,
      areaId: fields[2] as int?,
      areaDescripcion: fields[3] as String?,
      rolId: fields[4] as int?,
      rolDescripcion: fields[5] as String?,
      roles: (fields[6] as Map?)?.cast<String, String>(),
      estado: fields[7] as int?,
      dni: fields[8] as String?,
      puestoId: fields[9] as int?,
      puestoDescripcion: fields[10] as String?,
      correo: fields[11] as String?,
      usuario: fields[12] as String?,
      id: fields[14] as int?,
      nombre: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdapterUser obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.apePaterno)
      ..writeByte(1)
      ..write(obj.apeMaterno)
      ..writeByte(2)
      ..write(obj.areaId)
      ..writeByte(3)
      ..write(obj.areaDescripcion)
      ..writeByte(4)
      ..write(obj.rolId)
      ..writeByte(5)
      ..write(obj.rolDescripcion)
      ..writeByte(6)
      ..write(obj.roles)
      ..writeByte(7)
      ..write(obj.estado)
      ..writeByte(8)
      ..write(obj.dni)
      ..writeByte(9)
      ..write(obj.puestoId)
      ..writeByte(10)
      ..write(obj.puestoDescripcion)
      ..writeByte(11)
      ..write(obj.correo)
      ..writeByte(12)
      ..write(obj.usuario)
      ..writeByte(14)
      ..write(obj.id)
      ..writeByte(15)
      ..write(obj.nombre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdapterUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
